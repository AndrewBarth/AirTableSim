//#include "opencv2/core/core_c.h"
//#include "opencv2/highgui/highgui_c.h"
//#include "opencv2/videoio/videoio_c.h"

#include <unistd.h>

#include "opencv2/opencv.hpp" // opencv2 headers !

#include <iostream>
using namespace cv;           // c++ namespaces !
using namespace std;

int initCamera(cv::VideoCapture *cap);

int initCamera(cv::VideoCapture *cap)
{
//    VideoCapture cap;         // c++ classes !
    cap->open(0);
    if (! cap->isOpened())     // you have to CHECK this !
    {
        cout << "could not open the VideoCapture !" << endl;
        return -1;
    }
    return 0;
}

