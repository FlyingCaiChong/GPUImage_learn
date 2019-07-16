#include "landmark.h"
#include "smile_score.h"

Landmark * Landmark::instance = nullptr;
Landmark * Landmark::getInstance()
{
    if(instance == nullptr){
        instance = new Landmark();
    }
    
    return instance;
}

Landmark::Landmark(){}

Landmark::~Landmark()
{
    model.clear();
    eyelid_model.clear();
}

bool Landmark::init(const string &model_path)
{
    std::string param_file = model_path + "/shufflenetv2_150w.model";
    std::string bin_file = model_path + "/shufflenetv2_150w.weights";
    std::string eyelid_param_file = model_path + "/eyelid.model";
    std::string eyelid_bin_file = model_path + "/eyelid.weights";
    int ret=0;
    
    ret += model.load_param(param_file.data());
    ret += model.load_model(bin_file.data());
    eyelid_model.load_param(eyelid_param_file.data());
    eyelid_model.load_model(eyelid_bin_file.data());
    
    if(!ret){
        init_ok = true;
        setNumThreads(4);
        setParam(112, 112, 127);
    }else{
        init_ok = false;
    }
    
    return init_ok;
}

void Landmark::setNumThreads(int numThreads)
{
    num_threads = numThreads;
}

void Landmark::setParam(int width, int height, int mumPoints)
{
    
    this->width = width;
    this->height = height;
    this->num_points = mumPoints;
}

int * Landmark::detect(unsigned char *imageData, int width, int height, int channel, int left, int top, int right, int bottom)
{
    if(!init_ok){
        return nullptr;
    }
    
    if(imageData == nullptr){
        return nullptr;
    }
    
    
    ncnn::Mat img ;
    if(channel == 3){
        img = ncnn::Mat::from_pixels(imageData, ncnn::Mat::PIXEL_BGR2RGB,
                                     width, height);
    }else if(channel == 4){
        img = ncnn::Mat::from_pixels(imageData, ncnn::Mat::PIXEL_RGBA2BGR,
                                     width, height);
    }else{
        return nullptr;
    }
    
    ncnn::Mat face;
    copy_cut_border(img, face, top, height-bottom, left, width-right);
    
    ncnn::Mat pred;
    inference(face, pred);
    
    if(pred.w==0 || pred.h==0){
        return nullptr;
    }
    
    int pointNum = num_points;
    int *points = new int[pointNum*2];
    int w = right - left;
    int h = bottom - top;
    
    for(int i=0; i<pointNum*2; i=i+2){
        points[i] = (int)(pred[i] * w + left);
        points[i+1] = (int)(pred[i+1] * h + top);
    }
    
    return points;
}

int * Landmark::detectS(unsigned char *imageData, int width, int height, int channel, int left, int top, int right, int bottom)
{
    if(!init_ok){
        return nullptr;
    }
    
    if(imageData == nullptr){
        return nullptr;
    }
    
    
    ncnn::Mat img ;
    if(channel == 3){
        img = ncnn::Mat::from_pixels(imageData, ncnn::Mat::PIXEL_BGR2RGB,
                                     width, height);
    }else if(channel == 4){
        img = ncnn::Mat::from_pixels(imageData, ncnn::Mat::PIXEL_RGBA2BGR,
                                     width, height);
    }else{
        return nullptr;
    }
    
    ncnn::Mat face;
    copy_cut_border(img, face, top, height-bottom, left, width-right);
    
    ncnn::Mat pred;
    inference(face, pred);
    
    if(pred.w==0 || pred.h==0){
        return nullptr;
    }
    
    int pointNum = num_points;
    int *points = new int[pointNum*2+1];
    int w = right - left;
    int h = bottom - top;
    
    for(int i=0; i<pointNum*2; i=i+2){
        points[i] = (int)(pred[i] * w + left);
        points[i+1] = (int)(pred[i+1] * h + top);
    }
    
    int smileScore = score(points);
    points[pointNum*2] = smileScore;
    return points;
}

int * Landmark::detectSE(unsigned char *imageData, int width, int height, int channel, int left, int top, int right, int bottom)
{
    if(!init_ok){
        return nullptr;
    }
    
    if(imageData == nullptr){
        return nullptr;
    }
    
    ncnn::Mat img ;
    if(channel == 3){
        img = ncnn::Mat::from_pixels(imageData, ncnn::Mat::PIXEL_BGR2RGB,
                                     width, height);
    }else if(channel == 4){
        img = ncnn::Mat::from_pixels(imageData, ncnn::Mat::PIXEL_RGBA2BGR,
                                     width, height);
    }else{
        return nullptr;
    }
    
    ncnn::Mat face;
    copy_cut_border(img, face, top, height-bottom, left, width-right);
    
    ncnn::Mat pred;
    inference(face, pred);
    
    if(pred.w==0 || pred.h==0){
        return nullptr;
    }
    
    int pointNum = num_points;
    int *points = new int[pointNum*2+1+1];
    int w = right - left;
    int h = bottom - top;
    
    for(int i=0; i<pointNum*2; i=i+2){
        points[i] = (int)(pred[i] * w + left);
        points[i+1] = (int)(pred[i+1] * h + top);
    }
    
    int smileScore = score(points);
    points[pointNum*2] = smileScore;
    
    {
        ncnn::Mat cls;
        inferenceEyelid(face, cls);
        int eyelid_cls;
        if(cls[0]>=cls[1]){
            eyelid_cls = 0;
        }else{
            eyelid_cls = 1;
        }
        points[pointNum*2+1] = eyelid_cls;
    }
    
    return points;
}

void Landmark::inference(ncnn::Mat& img_, ncnn::Mat& pred)
{
    ncnn::Mat input;
    if(img_.w != width || img_.h != height){
        resize_bilinear(img_, input, width, height);
    }else{
        input = img_;
    }
    
    float mean[] = {(float)135.70923, (float)142.39746, (float)169.96283};
    float norm[] =  {(float)(1.0/63.605362), (float)(1.0/64.640724), (float)(1.0/75.43583)};
    input.substract_mean_normalize(mean, norm);
    
    ncnn::Extractor ex = model.create_extractor();
    ex.set_light_mode(true);
    ex.set_num_threads(num_threads);
    
    
    int ret = ex.input("data", input);
    
    ret = ex.extract("landmark_pred", pred);
}

void Landmark::inferenceEyelid(ncnn::Mat& img_, ncnn::Mat& pred)
{
    ncnn::Mat input;
    if(img_.w != width || img_.h != height){
        resize_bilinear(img_, input, width, height);
    }else{
        input = img_;
    }
    
    float mean[] = {(float)135.70923, (float)142.39746, (float)169.96283};
    float norm[] =  {(float)(1.0/63.605362), (float)(1.0/64.640724), (float)(1.0/75.43583)};
    input.substract_mean_normalize(mean, norm);
    
    ncnn::Extractor ex = eyelid_model.create_extractor();
    ex.set_light_mode(true);
    ex.set_num_threads(num_threads);
    
    int ret = ex.input("data", input);
    ret = ex.extract("sigmoid", pred);
}
