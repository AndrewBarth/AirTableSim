
#include <unistd.h>

#include "opencv2/opencv.hpp" // opencv2 headers !

#include <iostream>
using namespace cv;           // c++ namespaces !
using namespace std;

//extern "C" int getImage(unsigned char imageOut[],unsigned char imageOut1[],unsigned char imageOut2[]);
int getImage(cv::VideoCapture *cap, unsigned char imageOut1[]);

//int getImage(unsigned char imageOut[],unsigned char imageOut1[], unsigned char imageOut2[])
int getImage(cv::VideoCapture *cap, unsigned char imageOut1[])
{
//    VideoCapture cap;         // c++ classes !
//    cap.open(0);
    if (! cap->isOpened())     // you have to CHECK this !
    {
        cout << "could not open the VideoCapture !" << endl;
        return -1;
    }
    int i = 0;
    int j;
    int k;
 
        Mat frame;
//        Mat bgr[3];
        Mat gray;
//        Mat bimg;

        bool ok = cap->read(frame);
        if (! ok)             // also, mandatory CHECK !
             return 0;
//             break; 
//        printf("Size: %7.3f\n",frame.size());
//        printf("Array Size: %d\n",frame.total());
//        printf("Channels: %d\n",frame.channels());
//        split(frame,bgr);//split source  

        cvtColor(frame, gray, COLOR_BGR2GRAY);
//        threshold(gray,bimg,0,255,THRESH_BINARY);
//        threshold(gray,bimg,50,255,THRESH_BINARY);
// best        threshold(gray,bimg,50,255,THRESH_BINARY_INV);
//        adaptiveThreshold(gray,bimg,255,ADAPTIVE_THRESH_MEAN_C,THRESH_BINARY,11,2);
//        adaptiveThreshold(gray,bimg,255,ADAPTIVE_THRESH_MEAN_C,THRESH_BINARY,5,2);

        
//        memcpy(imageOut,b,307200*sizeof(unsigned char));
//        memcpy(imageOut+307200,g,307200*sizeof(unsigned char));
//        memcpy(imageOut+307200+307200,r,307200*sizeof(unsigned char));
//        memcpy(imageOut,bgr[0].data,307200*sizeof(unsigned char));
//        memcpy(imageOut+307200,bgr[1].data,307200*sizeof(unsigned char));
//        memcpy(imageOut+307200+307200,bgr[2].data,307200*sizeof(unsigned char));

        memcpy(imageOut1,gray.data,307200*sizeof(unsigned char));
//        memcpy(imageOut2,bimg.data,307200*sizeof(unsigned char));


//        b = bgr[0].data;
//        printf("Size b: %d\n",sizeof(bgr[0]));
//        printf("Size g: %d\n",sizeof(bgr[1]));
//        printf("Size r: %d\n",sizeof(bgr[2]));
//        printf("Array Size b: %d\n",bgr[0].total());
//        printf("Array Size g: %d\n",bgr[1].total());
//        printf("Array Size r: %d\n",bgr[2].total());

//        Mat b = bgr[0];
//        int bLength = sizeof(b)/sizeof(b[0]);
//        printf("blength: %d\n",blength);

    return 0;
}

