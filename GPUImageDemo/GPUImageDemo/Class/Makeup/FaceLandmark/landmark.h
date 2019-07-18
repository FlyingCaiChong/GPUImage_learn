#ifndef __LANDMARK_H__
#define __LANDMARK_H__

#include <ncnn/net.h>
#include <string>
#include <vector>
#include <time.h>
#include <algorithm>
#include <map>
#include <iostream>
#include <math.h>

using namespace std;

class Landmark{
public:
    static Landmark * getInstance();
    ~Landmark();

    bool init(const string &model_path);
    void setNumThreads(int numThreads);
    void setParam(int width=112, int height=112, int mumPoints=127);
    int * detect(unsigned char *imageData, int width, int height, int channel, int left, int top, int right, int bottom);
    int * detectS(unsigned char *imageData, int width, int height, int channel, int left, int top, int right, int bottom);
    int * detectSE(unsigned char *imageData, int width, int height, int channel, int left, int top, int right, int bottom);

private:
    bool init_ok = false;
    static Landmark *instance;
    int width;
    int height;
    int num_points;
    int num_threads;
    ncnn::Net model;
    ncnn::Net eyelid_model;

    Landmark();
    void inference(ncnn::Mat& img_, ncnn::Mat& pred);
    void inferenceEyelid(ncnn::Mat& img_, ncnn::Mat& pred);

};

#endif //__LANDMARK_H__
