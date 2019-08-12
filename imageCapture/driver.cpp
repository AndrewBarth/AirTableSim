
#include "opencv2/opencv.hpp"
#include <iostream>

using namespace cv;
int getImage(cv::VideoCapture *cap, unsigned char imageOut1[]);
int initCamera(cv::VideoCapture *cap);

int main() {

   int rc;
   cv::VideoCapture cap;

   unsigned char imageOut[307200];

   rc = initCamera(&cap);
   rc = getImage(&cap,imageOut);

   return 0;

}
