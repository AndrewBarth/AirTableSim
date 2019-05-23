// Phidget_Library_Client.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "Accelerometer.h"

int main()
{
	double accelx;
	double accely;
	double accelz;
	double timestamp;

	printf("Start Test");
	int status = Accelerometermain(&accelx,&accely,&accelz,&timestamp);
	printf("My Test Values \n");
	//printf("[Acceleration Event] -> Acceleration: %7.3f%8.3f%8.3f\n", acceleration[0], acceleration[1], acceleration[2]);
	printf("Accel: %7.3f%7.3f%7.3f\n", accelx,accely,accelz);
	printf("Press ENTER to end program.\n");
	getchar();

    return 0;
}

