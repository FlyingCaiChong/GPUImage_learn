#ifndef __MTCNN_H__
#define __MTCNN_H__

#include <string>
#include <vector>
#include <time.h>
#include <algorithm>
#include <map>
#include <iostream>
#include <math.h>

#include <ncnn/net.h>

using namespace std;
struct Bbox
{
    float score;
    int x1;
    int y1;
    int x2;
    int y2;
    float area;
    float ppoint[5*2];
    float regreCoord[4];
};

class MTCNN{
public:
    static MTCNN * getInstance();
    ~MTCNN();

    bool init(const string &model_path);
    void setMinFace(int minSize);
	void setNumThreads(int numThreads);
	void setTimeCount(int timeCount);

    int * faceDetect(unsigned char *imageData, int imageWidth, int imageHeight, int imageChannel, int scale_w=4, int scale_h=4);

private:
    bool init_ok=false;
    static MTCNN *instance;
    MTCNN();

    void detect(ncnn::Mat& img_, std::vector<Bbox>& finalBbox_);

    void generateBbox(ncnn::Mat score, ncnn::Mat location, vector<Bbox>& boundingBox_, float scale);
	void nmsTwoBoxs(vector<Bbox> &boundingBox_, vector<Bbox> &previousBox_, const float overlap_threshold, string modelname = "Union");
	void nms(vector<Bbox> &boundingBox_, const float overlap_threshold, string modelname="Union");
    void refine(vector<Bbox> &vecBbox, const int &height, const int &width, bool square);

	void PNet(float scale);
	void PNet();
    void RNet();
    void ONet();
    ncnn::Net Pnet, Rnet, Onet;
    ncnn::Mat img;
    const float nms_threshold[3] = {0.5f, 0.7f, 0.7f};
   
    const float mean_vals[3] = {127.5, 127.5, 127.5};
    const float norm_vals[3] = {0.0078125, 0.0078125, 0.0078125};
	const int MIN_DET_SIZE = 12;
    std::vector<Bbox> firstBbox_, secondBbox_,thirdBbox_;
	std::vector<Bbox> firstPreviousBbox_, secondPreviousBbox_, thirdPrevioussBbox_;
    int img_w, img_h;

private://部分可调参数
	const float threshold[3] = { 0.8f, 0.8f, 0.6f };
	int minsize = 40;
	const float pre_facetor = 0.709f;

	int count = 10;
	int num_threads = 4;
	
};

#endif __MTCNN_H__