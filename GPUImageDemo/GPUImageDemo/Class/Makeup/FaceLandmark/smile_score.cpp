#include "Eigen/Dense"
#include "Eigen/Core"
#include "Eigen/SVD"
#include <math.h>

using namespace Eigen;
using namespace std;

template<typename _Matrix_Type_>
_Matrix_Type_ pseudoInverse(const _Matrix_Type_ &a, double epsilon =
std::numeric_limits<double>::epsilon())
{
    Eigen::JacobiSVD< _Matrix_Type_ > svd(a ,Eigen::ComputeThinU | Eigen::ComputeThinV);
    double tolerance = epsilon * std::max(a.cols(), a.rows()) *svd.singularValues().array().abs()(0);
    return svd.matrixV() *  (svd.singularValues().array().abs() > tolerance).select(svd.singularValues().array().inverse(), 0).matrix().asDiagonal() * svd.matrixU().adjoint();
}


float radiusofcurve(int * landmarks)
{
    int down_lips[] = {48,60,67,66,65,64,54};
    int n = sizeof(down_lips)/sizeof(down_lips[0]);
    float pointX[sizeof(down_lips)/sizeof(down_lips[0])] = {0};
    float pointY[sizeof(down_lips)/sizeof(down_lips[0])] = {0};

    float mx = 0;
    float my = 0;

    for(int i=0; i<n; i++){
        int p = down_lips[i];
        pointX[i] = landmarks[p*2];
        mx += pointX[i];

        pointY[i] = landmarks[p*2+1];
        my += pointY[i];
    }

    mx /= (float)n;
    my /= (float)n;

    Map<Matrix<float, sizeof(down_lips)/sizeof(down_lips[0]), 1> > X(pointX);   //7 rows, 1 cols
    Map<Matrix<float, sizeof(down_lips)/sizeof(down_lips[0]), 1> > Y(pointY);

    float left = X.minCoeff();
    float right = X.maxCoeff();
    if(left == right){
        return -1;
    }

    X = X.array() - mx;
    Y = Y.array() - my;

    MatrixXf XX(sizeof(down_lips)/sizeof(down_lips[0]), 1);     // 7 rows , 1 cols
    MatrixXf YY(sizeof(down_lips)/sizeof(down_lips[0]), 1);
    XX = X.array().cwiseProduct(X.array());
    YY = Y.array().cwiseProduct(Y.array());

    float dx2 = XX.mean();
    float dy2 = YY.mean();

    MatrixXf RHS(sizeof(down_lips)/sizeof(down_lips[0]),1);     // 7 rows, 1 cols
    RHS = (XX.array()-dx2 + YY.array()-dy2)/2;

    MatrixXf M(X.rows(), X.cols()+Y.cols());        // 7 rows, 2 cols
    M << X, Y;

    MatrixXf M_PINV(M.cols(), M.rows());        // 2 rows, 7 cols

    M_PINV = pseudoInverse(M);

    MatrixXf t(M_PINV.rows(), RHS.cols());
    //t = M_PINV.dot(RHS);            // (2 rows, 7 cols) * (7 rows, 1 cols)  --> (2 rows, 1 cols)
    t = M_PINV * RHS;
    float ax = t.block(0,0,1,1).value();
    float ay = t.block(1,0,1,1).value();

    float r = sqrt(dx2 + dy2 + ax*ax + ay*ay);

    float eye_distance = sqrt(pow((landmarks[103*2]-landmarks[98*2]),2)+pow((landmarks[103*2+1]-landmarks[98*2+1]),2));

    //return r/(right-left);
    return r/ eye_distance;
}

float mouth_area(int * landmarks)
{
    int down_lips[] = {48,60,67,66,65,64,54, 48};
    int n = sizeof(down_lips)/sizeof(down_lips[0]);
    int pointX[sizeof(down_lips)/sizeof(down_lips[0])] = {0};
    int pointY[sizeof(down_lips)/sizeof(down_lips[0])] = {0};

    for(int i=0; i<n; i++){
        int p = down_lips[i];
        pointX[i] = landmarks[p*2];
        pointY[i] = landmarks[p*2+1];
    }

    float area = 0;
    float tmp =0;
    for(int i=0; i<n-1; i++){
        tmp =float(pointX[i])*float(pointY[i+1]) - float(pointY[i])*float(pointX[i+1]);
        area = area + tmp;
    }
    area /= 2.0;
    area = area>=0? area:-area;

   
    //int eye[]={98,103};
    float eye_distance2 = pow((landmarks[103*2]-landmarks[98*2]),2)+pow((landmarks[103*2+1]-landmarks[98*2+1]),2);


    return area/eye_distance2;
}

int score(int * landmarks)
{
    float r = radiusofcurve(landmarks);
    float area = mouth_area(landmarks);
    
    float r_score = 0;
    float area_score = 0;
    if(r>2 || r<0){
        r_score = 0;
    }else{
        r_score = pow(2.0/r, 4);
    }

    area_score = area*500;

    int score = r_score + area_score;

    if(r_score==0){
        score = score>20?20:score;
    }
    if(area_score<20){
        score = score>70? 70:score;
    }

    score = score>100? 100:score;
    return score;
}
