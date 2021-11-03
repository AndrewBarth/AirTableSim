#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#include <phidget22.h>
#include "PhidgetHelperFunctions.h"

int DistanceInit(PhidgetDistanceSensorHandle dch[]) {

	PhidgetReturnCode prc; //Used to catch error codes from each Phidget function call

	int dataInterval = 100; // 100 ms
	double acceleration[3];

	/*
	 * Allocate a new Phidget Channel object
	*/
	for (int i = 0; i < 4; i++) {
		prc = PhidgetDistanceSensor_create(&dch[i]);
		CheckError(prc, "Creating Channel", (PhidgetHandle *)&dch[i]);

		prc = Phidget_setDeviceSerialNumber((PhidgetHandle)dch[i], 538408);
		CheckError(prc, "Setting DeviceSerialNumber", (PhidgetHandle *)&dch[i]);
	}
	printf("Hello World: Distance Sensor\n");
	prc = Phidget_setHubPort((PhidgetHandle)dch[0], 0);
	CheckError(prc, "Setting DeviceSerialNumber", (PhidgetHandle *)&dch[0]);
	prc = Phidget_setHubPort((PhidgetHandle)dch[1], 1);
	CheckError(prc, "Setting DeviceSerialNumber", (PhidgetHandle *)&dch[1]);
	prc = Phidget_setHubPort((PhidgetHandle)dch[2], 2);
	CheckError(prc, "Setting DeviceSerialNumber", (PhidgetHandle *)&dch[2]);
	prc = Phidget_setHubPort((PhidgetHandle)dch[3], 3);
	CheckError(prc, "Setting DeviceSerialNumber", (PhidgetHandle *)&dch[3]);

	printf("Opening and Waiting for Attachment...\n");
	prc = Phidget_openWaitForAttachment((PhidgetHandle)dch[0], 5000);
	CheckOpenError(prc, (PhidgetHandle *)&dch[0]);
	Sleep(5000);

	printf("Opening and Waiting for Attachment...\n");
	prc = Phidget_openWaitForAttachment((PhidgetHandle)dch[1], 5000);
	CheckOpenError(prc, (PhidgetHandle *)&dch[1]);
	Sleep(5000);

	printf("Opening and Waiting for Attachment...\n");
	prc = Phidget_openWaitForAttachment((PhidgetHandle)dch[2], 5000);
	CheckOpenError(prc, (PhidgetHandle *)&dch[2]);
	Sleep(5000);

	printf("Opening and Waiting for Attachment...\n");
	prc = Phidget_openWaitForAttachment((PhidgetHandle)dch[3], 5000);
	CheckOpenError(prc, (PhidgetHandle *)&dch[3]);
	Sleep(5000);

	for (int j = 0; j < 4; j++) {
		prc = Phidget_setDataInterval((PhidgetHandle)dch[j], dataInterval);
		CheckOpenError(prc, (PhidgetHandle *)&dch[j]);
	}

	return 0;
}
