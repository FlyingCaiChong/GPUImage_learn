

一、类MTCNN用于人脸检测， 单例模式

MTCNN * getInstance();   获取类实例指针
bool init(const string &model_path); 初始化实例，成功返回true, 失败返回false

void SetMinFace(int minSize);           设置人脸的最小检测尺寸，小于这个尺寸不检测，这个参数有默认值可以不必调用这个函数，默认24
void SetNumThreads(int numThreads);     设置多线程，这个参数有默认值可以不必调用这个函数，默认4
void SetTimeCount(int timeCount);       设置对同一张图片循环检测的次数，主要用于测试时计算平均检测时间，这个参数有默认值可以不必调用这个函数，默认1

int * faceDetect(unsigned char *imageData, int imageWidth, int imageHeight, int imageChannel, int scale_w=4, int scale_h=4);    

检测人脸
返回值： 
    int 数组指针
    检测失败返回nullptr。调用init()失败或者输入数据为空或者图片宽高小于20都会检测失败。
    检测成功返回数组地址，第一个元素表示检测到的人脸数量，紧接着四个元素分别是人脸区域的left,top,right,bottom。如果检测到多个人脸，则按照left,top,right,bottom,left,right...的顺序拼接。
输入： 
    imageData为图片数据，需要将图片按照RGBA的顺序转换为unsigned char 数据，也就是将图片每个通道的值放到一个unsigned char中。图片数据从第一行开始，然后时第二行，以此类推拼接在一起。安卓上面对应了Bitmap::copyPixelsToBuffer函数。
    imageWidth 原图片宽度，小于20会检测失败
    imageHeight 原图片高度，小于20会检测失败
    imageChannel 原图片通道数，这个函数只支持通道数为3（通道顺序为BGR）和通道数为4（通道顺序为RGBA）
    scale_w 对图片宽度缩小的倍数，用于提升速度,默认为4
    scale_h 对图片高度缩小的倍数，用于提升速度，默认为4，最好和scale_w相等，否则改变了图片的宽高比例可能降低识别率


示例代码：

MTCNN *mtcnn = MTCNN::getInstance();
bool init_ok = mtcnn.init("your model path");
if(!init_ok){
    std::cout<<"init failed"<<std::endl;
    //中断后续操作
}
mtcnn.SetMinFace(24);
mtcnn.SetNumThreads(4);
mtcnn.SetTimeCount(1);

unsigned char * imgData = xx;    //get your image data
int imageWidth = xx;
int imageHeight = xx;
int imageChannel = xx; 
mtcnn.faceDetect(imgData, imageWidth, imageHeight, imageChannel, 4, 4);

delete mtcnn;


二、类Landmark用于定位人脸特征点，单例模式

Landmark * getInstance();        获取类实例指针
bool init(const string &model_path); 初始化实例，成功返回true, 失败返回false
void setNumThreads(int numThreads); 设置多线程，这个参数有默认值可以不必调用这个函数，默认4
void setParam(int width=112, int height=112, int mumPoints=127); 设置图片缩放尺寸和特征点数量，默认参数为112,112,127, 主要为了兼容不同的模型，一般不需要调用。

int * detect(unsigned char *imageData, int width, int height, int channel, int left, int top, int right, int bottom);
返回值：
    int 数组指针
    失败返回nullpth。调用init()失败后者输入数据为空会检测失败。
    成功返回数组指针，长度为254， 第i个点的X坐标下表为 i*2, Y坐标下标为i*2+1
输入数据：
    imageData为图片数据，需要将图片按照RGBA的顺序转换为unsigned char 数据，也就是将图片每个通道的值放到一个unsigned char中。图片数据从第一行开始，然后时第二行，以此类推拼接在一起。安卓上面对应了Bitmap::copyPixelsToBuffer函数。
    width 原图片宽度，小于20会检测失败
    height 原图片高度，小于20会检测失败
    channel 原图片通道数，这个函数只支持通道数为3（通道顺序为BGR）和通道数为4（通道顺序为RGBA）    
    left, top, right, bottom 为人脸区域

int * detectS(unsigned char *imageData, int width, int height, int channel, int left, int top, int right, int bottom);
返回值：
    int 数组指针
    失败返回nullptr。调用init()失败或者输入数据为空会检测失败。
    检测成功返回数组指针，长度为255。 前面254个元素为特征点坐标，第i个点的X坐标下表为 i*2, Y坐标下标为i*2+1。最后一个元素为smile score。
输入数据：
    imageData为图片数据，需要将图片按照RGBA的顺序转换为unsigned char 数据，也就是将图片每个通道的值放到一个unsigned char中。图片数据从第一行开始，然后时第二行，以此类推拼接在一起。安卓上面对应了Bitmap::copyPixelsToBuffer函数。
    width 原图片宽度，小于20会检测失败
    height 原图片高度，小于20会检测失败
    channel 原图片通道数，这个函数只支持通道数为3（通道顺序为BGR）和通道数为4（通道顺序为RGBA）    
    left, top, right, bottom 为人脸区域

int * detectSE(unsigned char *imageData, int width, int height, int channel, int left, int top, int right, int bottom);
返回值：
    int 数组指针
    失败返回nullptr。调用init()失败或者输入数据为空会检测失败。
    检测成功返回数组指针，长度为256。 前面254个元素为特征点坐标，第i个点的X坐标下表为 i*2, Y坐标下标为i*2+1。最后两个元素为smile score和是否为双眼皮（1表示双眼皮，0表示单眼皮）。
输入数据：
    imageData为图片数据，需要将图片按照RGBA的顺序转换为unsigned char 数据，也就是将图片每个通道的值放到一个unsigned char中。图片数据从第一行开始，然后时第二行，以此类推拼接在一起。安卓上面对应了Bitmap::copyPixelsToBuffer函数。
    width 原图片宽度，小于20会检测失败
    height 原图片高度，小于20会检测失败
    channel 原图片通道数，这个函数只支持通道数为3（通道顺序为BGR）和通道数为4（通道顺序为RGBA）    
    left, top, right, bottom 为人脸区域

示例代码：

MTCNN *mtcnn = MTCNN::getInstance();
bool init_ok = mtcnn.init("your model path");
if(!init_ok){
    std::cout<<"init failed"<<std::endl;
    delete mtcnn;
    //中断后续操作
}
mtcnn.SetMinFace(24);
mtcnn.SetNumThreads(4);
mtcnn.SetTimeCount(1);

unsigned char * imgData = xx;    //get your image data
int imageWidth = xx;
int imageHeight = xx;
int imageChannel = xx; 
int * faces = mtcnn.faceDetect(imgData, imageWidth, imageHeight, imageChannel, 4, 4);
if(!faces || faces[0]==0){
    delete mtcnn;
    //检测失败或没检测到人脸，中断后续操作
    
}

Landmark * landmark = Landmark::getInstance();
bool init_ok = landmark.init("your model path");
if(!init_ok){
    std::cout<<"init failed"<<std::endl;
    delete landmark;
    //中断后续操作
}

landmark.setNumThreads(4);
landmark.setParam(112,112,127);

unsigned char * imgData = xx;    //get your image data
int imageWidth = xx;
int imageHeight = xx;
int imageChannel = xx; 
int numFace = faces[0];
for(int i=0; i<numFace; i++){
    int left = faces[1+4*i];
    int top = faceInfo[2+4*i];
    int right = faceInfo[3+4*i];
    int bottom = faceInfo[4+4*i];
    int * points = landmark.detect(imgData, imageWidth, imageHeight, imageChannel, left, top, right, bottom);

    int numPoint = 127;
    for (int p = 0; p < numPoints * 2; p = p + 2){
        std::cout<<"point i, x:"<<points[p] << "y: "<< points[p+1] << std::endl;
        //Do your own operations;
    }

}

delete landmark;
delete mtcnn;