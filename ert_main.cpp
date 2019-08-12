//
// Classroom License -- for classroom instructional use only.  Not for
// government, commercial, academic research, or other organizational use.
//
// File: ert_main.cpp
//
// Code generated for Simulink model 'Top6DOFModel'.
//
// Model version                  : 1.798
// Simulink Coder version         : 9.0 (R2018b) 24-May-2018
// C/C++ source code generated on : Fri Jul 26 08:36:13 2019
//
// Target selection: ert.tlc
// Embedded hardware selection: ARM Compatible->ARM Cortex
// Code generation objectives: Unspecified
// Validation result: Not run
//
#include <stdio.h>
#include <stdlib.h>
#include "Top6DOFModel.h"
#include "Top6DOFModel_private.h"
#include "rtwtypes.h"
#include "limits.h"
#include "rt_nonfinite.h"
#include "rt_logging.h"
#include "MW_raspi_init.h"
#include "linuxinitialize.h"
extern "C" {
#include "arduino-serial-lib.h"
}
#include <phidget22.h>
#include "opencv2/opencv.hpp"
#include "opencv2/videoio.hpp"
#define UNUSED(x)                      x = x
#define QUOTE1(name)                   #name
#define QUOTE(name)                    QUOTE1(name)              // need to expand name 
#ifndef SAVEFILE
# define MATFILE2(file)                #file ".mat"
# define MATFILE1(file)                MATFILE2(file)
# define MATFILE                       MATFILE1(MODEL)
#else
# define MATFILE                       QUOTE(SAVEFILE)
#endif
/* Determine if we are on Windows of Unix */
#ifdef _WIN32
#include <windows.h>
#else
#include <unistd.h>
#define Sleep(x) usleep((x)*1000)
#endif

static Top6DOFModelModelClass Top6DOFModel_Obj;// Instance of model class

// Function prototype declaration
void exitFcn(int sig);
void *terminateTask(void *arg);
void *baseRateTask(void *arg);
void *subrateTask(void *arg);
volatile boolean_T stopRequested = false;
volatile boolean_T runModel = true;
sem_t stopSem;
sem_t baserateTaskSem;
sem_t subrateTaskSem[1];
int taskId[1];
pthread_t schedulerThread;
pthread_t baseRateThread;
unsigned long threadJoinStatus[8];
int terminatingmodel = 0;
pthread_t subRateThread[1];
int subratePriority[1];

using namespace cv;

/* Function Prototypes for Arduino comm and Phidget comm */
extern "C" int serial_init();
PhidgetAccelerometerHandle AccelerometerInit();
PhidgetGyroscopeHandle GyroscopeInit();
PhidgetMagnetometerHandle MagnetometerInit();
int DistanceInit(PhidgetDistanceSensorHandle dch[] );
int getImage(cv::VideoCapture *cap,unsigned char imageOut[]);
int initCamera(cv::VideoCapture *cap);
int initializeUDP(int *handle);
int getUDPData(int handle, char *packet_data);

/* Variables for Arduino comm and Phidget comm */
PhidgetAccelerometerHandle ach;
PhidgetGyroscopeHandle gch;
PhidgetMagnetometerHandle mch;
PhidgetDistanceSensorHandle dch[4];
int prc;
int rc;
int serial_fd;
double acceleration[3];
double angularRate[3];
double magField[3];
unsigned int distance[4];
int handle = 0;
char packet_data[1024];
double tx;
double ty;
double rz;

cv::VideoCapture cap;

void *subrateTask(void *arg)
{
  int tid = *((int *) arg);
  int subRateId;
  subRateId = tid + 1;
  while (runModel) {
    sem_wait(&subrateTaskSem[tid]);
    if (terminatingmodel)
      break;

#ifdef MW_RTOS_DEBUG

    printf(" -subrate task %d semaphore received\n", subRateId);

#endif

    switch (subRateId) {
     case 1:
      Top6DOFModel_Obj.step1();
      break;

     default:
      break;
    }
  }

  pthread_exit((void *)0);
  return NULL;
}

void *baseRateTask(void *arg)
{
  int timeTic;
  char theMessage[8];
  //unsigned char imageOut[921600];
  unsigned char imageOut[307200];
  //FILE *fid=fopen("testGyro.txt","w");

  runModel = (rtmGetErrorStatus(Top6DOFModel_Obj.getRTM()) == (NULL));
  while (runModel) {
//    timeTic = (int) (Top6DOFModel_Obj.Top6DOFModel_B.DigitalClock*1000);
    timeTic = (int)(rtmGetT(Top6DOFModel_Obj.getRTM())*1000);
    // Process Sensor inputs
    if ( (timeTic % 25) == 0) {

       // Camera Data
       rc = getImage(&cap,imageOut);
    //   printf("The image: %d\n",imageOut[52]);
       //memcpy(Top6DOFModel_Obj.Top6DOFModel_U.ImageData,imageOut,921600*sizeof(char));
       memcpy(Top6DOFModel_Obj.Top6DOFModel_U.ImageData,imageOut,307200*sizeof(char));
       Top6DOFModel_Obj.Top6DOFModel_U.NewImage = 1;

       // Vision Tracker Data
       rc = getUDPData(handle, packet_data);
       //printf("name %c%c%c%c%c%c%c%c\n",packet_data[8],packet_data[9],packet_data[10],packet_data[11],packet_data[12],packet_data[13],packet_data[14],packet_data[15]);
       memcpy(&tx,&packet_data[32],8*sizeof(char));
       memcpy(&ty,&packet_data[40],8*sizeof(char));
       memcpy(&rz,&packet_data[72],8*sizeof(char));
       Top6DOFModel_Obj.Top6DOFModel_U.PositionData[0] = tx;
       Top6DOFModel_Obj.Top6DOFModel_U.PositionData[1] = ty;
       Top6DOFModel_Obj.Top6DOFModel_U.PositionData[2] = 0.0;
       Top6DOFModel_Obj.Top6DOFModel_U.RotationData[0] = 0.0;
       Top6DOFModel_Obj.Top6DOFModel_U.RotationData[1] = 0.0;
       Top6DOFModel_Obj.Top6DOFModel_U.RotationData[2] = rz;
       printf("Location: %10.3f\nty %10.3f\n",tx,ty);
       printf("Rotation: %10.3f\n",rz*57.2957);

      // IMU and Range Data
       prc = PhidgetAccelerometer_getAcceleration(ach, &acceleration);
       prc = PhidgetGyroscope_getAngularRate(gch, &angularRate);
       prc = PhidgetMagnetometer_getMagneticField(mch, &magField);
       for (int j=0; j<4; j++) {
          prc = PhidgetDistanceSensor_getDistance(dch[j], &distance[j]);
       }
       for (int k=0; k<3; k++) {
          Top6DOFModel_Obj.Top6DOFModel_U.GyroData[k] = angularRate[k];
          Top6DOFModel_Obj.Top6DOFModel_U.AccelerometerData[k] = acceleration[k];
          Top6DOFModel_Obj.Top6DOFModel_U.MagFieldData[k] = magField[k];
          Top6DOFModel_Obj.Top6DOFModel_U.RangeData[k] = distance[k];
       }
       Top6DOFModel_Obj.Top6DOFModel_U.RangeData[3] = distance[3];
    //   printf("Acceleration: %8.3f%8.3f%8.3f\n",acceleration[0],acceleration[1],acceleration[2]);
    //   printf("Angular Rate: %8.3f%8.3f%8.3f\n",angularRate[0],angularRate[1],angularRate[2]);
    //   printf("Magnetic Field: %8.3f%8.3f%8.3f\n",magField[0],magField[1],magField[2]);
    //   printf("Distance: %6d %6d %6d %6d\n",distance[0],distance[1],distance[2],distance[3]);
    //   fprintf(fid,"%10d %8.3f%8.3f%8.3f%8.3f%8.3f%8.3f\n",timeTic,acceleration[0],acceleration[1],acceleration[2],angularRate[0],angularRate[1],angularRate[2]);


    } else {
       Top6DOFModel_Obj.Top6DOFModel_U.NewImage = 0;
    }

#ifdef MW_RTOS_DEBUG

    printf("*base rate task semaphore received\n");
    fflush(stdout);

#endif

    if (rtmStepTask(Top6DOFModel_Obj.getRTM(), 1)
        ) {
      sem_post(&subrateTaskSem[0]);
    }

    Top6DOFModel_Obj.step0();

    if ( (timeTic % 25) == 0) {
       //printf("Current Time: %6.3f\n",Top6DOFModel_Obj.Top6DOFModel_B.DigitalClock);
       printf("Current Time: %6.3f\n",rtmGetT(Top6DOFModel_Obj.getRTM()));
       for (int i=0; i<8; i++) {
           theMessage[i] = Top6DOFModel_Obj.Top6DOFModel_Y.thrusterCmds[i] + '0';
       }
//       printf("The message: %c %c %c %c %c %c %c %c\n",theMessage[0],theMessage[1],theMessage[2],theMessage[3],theMessage[4],theMessage[5],theMessage[6],theMessage[7]);
//       rc = serialport_write(serial_fd,theMessage);

       printf("Theta Angle: %7.3f deg\n",Top6DOFModel_Obj.Top6DOFModel_Y.filteredSensorData[13]*57.2958);
       //printf("Theta Qual: %6.2f \n",Top6DOFModel_Obj.Top6DOFModel_Y.sensorQuality[4]);
    }

    stopRequested = !((rtmGetErrorStatus(Top6DOFModel_Obj.getRTM()) == (NULL)));
    rt_StopDataLogging(MATFILE, Top6DOFModel_Obj.getRTM()->rtwLogInfo);
    //if (Top6DOFModel_Obj.Top6DOFModel_B.DigitalClock > Top6DOFModel_Obj.Top6DOFModel_M->Timing.tFinal) {
    if (rtmGetT(Top6DOFModel_Obj.getRTM()) > rtmGetTFinal(Top6DOFModel_Obj.getRTM())) {
       //fclose(fid);
       rc = serialport_write(serial_fd,"00000000");
       Sleep(1000);
       terminateTask(arg);
    }
  }

  terminateTask(arg);
  pthread_exit((void *)0);
  return NULL;
}

void exitFcn(int sig)
{
  UNUSED(sig);
  rtmSetErrorStatus(Top6DOFModel_Obj.getRTM(), "stopping the model");
  runModel = 0;
}

void *terminateTask(void *arg)
{
  UNUSED(arg);
  terminatingmodel = 1;

  {
    int i;

    // Signal all periodic tasks to complete
    for (i=0; i<1; i++) {
      CHECK_STATUS(sem_post(&subrateTaskSem[i]), 0, "sem_post");
      CHECK_STATUS(sem_destroy(&subrateTaskSem[i]), 0, "sem_destroy");
    }

    // Wait for all periodic tasks to complete
    for (i=0; i<1; i++) {
      CHECK_STATUS(pthread_join(subRateThread[i],(void *)&threadJoinStatus), 0,
                   "pthread_join");
    }

    runModel = 0;
  }

  mwRaspiTerminate();

  // Disable rt_OneStep() here

  // Terminate model
  Top6DOFModel_Obj.terminate();
  sem_post(&stopSem);
  return NULL;
}

int main(int argc, char **argv)
{
  UNUSED(argc);
  UNUSED(argv);
  subratePriority[0] = 39;
  mwRaspiInit();
  rtmSetErrorStatus(Top6DOFModel_Obj.getRTM(), 0);

  // Initialize model
  Top6DOFModel_Obj.initialize();

  // Open Serial Port
  serial_fd = serial_init();

  // Open Phidget Channels
//  ach = AccelerometerInit();
//  gch = GyroscopeInit();
//  mch = MagnetometerInit();
//  int rc = DistanceInit(dch);

  // Open camera
  rc = initCamera(&cap);
   
  // Open UDP channel to Vicon data
  rc = initializeUDP(&handle);

  // Call RTOS Initialization function
  myRTOSInit(0.005, 1);

  // Wait for stop semaphore
  sem_wait(&stopSem);

#if (MW_NUMBER_TIMER_DRIVEN_TASKS > 0)

  {
    int i;
    for (i=0; i < MW_NUMBER_TIMER_DRIVEN_TASKS; i++) {
      CHECK_STATUS(sem_destroy(&timerTaskSem[i]), 0, "sem_destroy");
    }
  }

#endif

  return 0;
}

//
// File trailer for generated code.
//
// [EOF]
//
