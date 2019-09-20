/*
 * Classroom License -- for classroom instructional use only.  Not for
 * government, commercial, academic research, or other organizational use.
 *
 * File: ert_main.c
 *
 * Code generated for Simulink model 'Top6DOFModel'.
 *
 * Model version                  : 1.580
 * Simulink Coder version         : 9.0 (R2018b) 24-May-2018
 * C/C++ source code generated on : Thu Jun  6 12:23:51 2019
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "Top6DOFModel.h"
#include "Top6DOFModel_private.h"
#include "rtwtypes.h"
#include "limits.h"
#include "rt_nonfinite.h"
#include "rt_logging.h"
#include "MW_raspi_init.h"
#include "linuxinitialize.h"
#include "arduino-serial-lib.h"
#include <phidget22.h>
#define UNUSED(x)                      x = x
#define QUOTE1(name)                   #name
#define QUOTE(name)                    QUOTE1(name)              /* need to expand name */
#ifndef SAVEFILE
# define MATFILE2(file)                #file ".mat"
# define MATFILE1(file)                MATFILE2(file)
# define MATFILE                       MATFILE1(MODEL)
#else
# define MATFILE                       QUOTE(SAVEFILE)
#endif

/* Function prototype declaration*/
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
int serial_init();
int serial_fd;
void *subrateTask(void *arg)
{
  int tid = *((int *) arg);
  int subRateId;
  subRateId = tid + 1;
  int rc;
  char theMessage[8];
  int timeTic;
  while (runModel) {
    sem_wait(&subrateTaskSem[tid]);
    timeTic = (int) (Top6DOFModel_Y.timeOut*1000);
    if ( (timeTic % 25) == 0) {
       //printf("Time to check sensor\n");
       printf("Current Time: %6.3f\n",Top6DOFModel_Y.timeOut);
       for (int i=0; i<8; i++) {
           theMessage[i] = Top6DOFModel_Y.thrusterCmds[i] + '0';
       }
       //printf("The message: %c %c %c %c %c %c %c %c\n",theMessage[0],theMessage[1],theMessage[2],theMessage[3],theMessage[4],theMessage[5],theMessage[6],theMessage[7]);
       rc = serialport_write(serial_fd,theMessage);
    }
    if (Top6DOFModel_Y.timeOut > Top6DOFModel_M->Timing.tFinal) {
       rc = serialport_write(serial_fd,"00000000");
       terminateTask(arg);
    }
    if (terminatingmodel)
      break;

#ifdef MW_RTOS_DEBUG

    printf(" -subrate task %d semaphore received\n", subRateId);

#endif

    Top6DOFModel_step(subRateId);

    /* Get model outputs here */
  }

  pthread_exit((void *)0);
  return NULL;
}

void *baseRateTask(void *arg)
{
  runModel = (rtmGetErrorStatus(Top6DOFModel_M) == (NULL));
  while (runModel) {
    sem_wait(&baserateTaskSem);

#ifdef MW_RTOS_DEBUG

    printf("*base rate task semaphore received\n");
    fflush(stdout);

#endif

    if (rtmStepTask(Top6DOFModel_M, 1)
        ) {
      sem_post(&subrateTaskSem[0]);
    }

    Top6DOFModel_step(0);

    /* Get model outputs here */
    stopRequested = !((rtmGetErrorStatus(Top6DOFModel_M) == (NULL)));
    rt_StopDataLogging(MATFILE, Top6DOFModel_M->rtwLogInfo);
  }

  terminateTask(arg);
  pthread_exit((void *)0);
  return NULL;
}

void exitFcn(int sig)
{
  UNUSED(sig);
  rtmSetErrorStatus(Top6DOFModel_M, "stopping the model");
  runModel = 0;
}

void *terminateTask(void *arg)
{
  UNUSED(arg);
  terminatingmodel = 1;

  {
    int i;

    /* Signal all periodic tasks to complete */
    for (i=0; i<1; i++) {
      CHECK_STATUS(sem_post(&subrateTaskSem[i]), 0, "sem_post");
      CHECK_STATUS(sem_destroy(&subrateTaskSem[i]), 0, "sem_destroy");
    }

    /* Wait for all periodic tasks to complete */
    for (i=0; i<1; i++) {
      CHECK_STATUS(pthread_join(subRateThread[i],(void *)&threadJoinStatus), 0,
                   "pthread_join");
    }

    runModel = 0;
  }

  mwRaspiTerminate();

  /* Disable rt_OneStep() here */

  /* Terminate model */
  Top6DOFModel_terminate();
  sem_post(&stopSem);
  return NULL;
}

int main(int argc, char **argv)
{
  UNUSED(argc);
  UNUSED(argv);
  subratePriority[0] = 39;
  mwRaspiInit();
  rtmSetErrorStatus(Top6DOFModel_M, 0);

  /* Initialize model */
  Top6DOFModel_initialize();

  /* Open Serial Port */
  serial_fd = serial_init();

  /* Call RTOS Initialization function */
  myRTOSInit(0.005, 1);

  /* Wait for stop semaphore */
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

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
