#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#include <phidget22.h>
#include "PhidgetHelperFunctions.h"

PhidgetAccelerometerHandle AccelerometerInit() {
	PhidgetAccelerometerHandle ach = NULL;
	PhidgetReturnCode prc; //Used to catch error codes from each Phidget function call
	
	int dataInterval = 10; // 10 ms
	double acceleration[3];
	
	/*
	 * Allocate a new Phidget Channel object
	*/
	prc = PhidgetAccelerometer_create(&ach);
	CheckError(prc, "Creating Channel", (PhidgetHandle *)&ach);

	printf("Hello World: Accelerometer\n");
	prc = Phidget_setDeviceSerialNumber((PhidgetHandle)ach, 595407);
	CheckError(prc, "Setting DeviceSerialNumber", (PhidgetHandle *)&ach);

	printf("Opening and Waiting for Attachment...\n");
	prc = Phidget_openWaitForAttachment((PhidgetHandle)ach, 5000);
	CheckOpenError(prc, (PhidgetHandle *)&ach);

	Sleep(5000);

	prc = Phidget_setDataInterval((PhidgetHandle)ach, dataInterval);
	CheckOpenError(prc, (PhidgetHandle *)&ach);

	//prc = PhidgetAccelerometer_getAcceleration(ach, &acceleration);
	//CheckOpenError(prc, (PhidgetHandle *)&ach);
	//printf("[Acceleration Event] -> Acceleration: %7.3f%8.3f%8.3f\n", acceleration[0], acceleration[1], acceleration[2]);

	return ach;
}

PhidgetGyroscopeHandle GyroscopeInit() {
	PhidgetGyroscopeHandle gch = NULL;
	PhidgetReturnCode prc; //Used to catch error codes from each Phidget function call

	int dataInterval = 10; // 10 ms
	double angularRate[3];

	/*
	* Allocate a new Phidget Channel object
	*/
	prc = PhidgetGyroscope_create(&gch);
	CheckError(prc, "Creating Channel", (PhidgetHandle *)&gch);

	printf("Hello World: Gyroscope\n");
	prc = Phidget_setDeviceSerialNumber((PhidgetHandle)gch, 595407);
	CheckError(prc, "Setting DeviceSerialNumber", (PhidgetHandle *)&gch);

	printf("Opening and Waiting for Attachment...\n");
	prc = Phidget_openWaitForAttachment((PhidgetHandle)gch, 5000);
	CheckOpenError(prc, (PhidgetHandle *)&gch);

	Sleep(5000);

	prc = Phidget_setDataInterval((PhidgetHandle)gch, dataInterval);
	CheckOpenError(prc, (PhidgetHandle *)&gch);

	//prc = PhidgetGyroscope_getAngularRate(gch, &angularRate);
	//CheckOpenError(prc, (PhidgetHandle *)&gch);
	//printf("[Angular Rate Event] -> Angular Rate: %7.3f%8.3f%8.3f\n", angularRate[0], angularRate[1], angularRate[2]);

	return gch;
}
