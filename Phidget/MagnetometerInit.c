#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#include <phidget22.h>
#include "PhidgetHelperFunctions.h"

PhidgetMagnetometerHandle MagnetometerInit() {
	PhidgetMagnetometerHandle mch = NULL;
	PhidgetReturnCode prc; //Used to catch error codes from each Phidget function call
	
	int dataInterval = 10; // 10 ms
	double magField[3];
	
	/*
	 * Allocate a new Phidget Channel object
	*/
	prc = PhidgetMagnetometer_create(&mch);
	CheckError(prc, "Creating Channel", (PhidgetHandle *)&mch);

	printf("Hello World\n");
	prc = Phidget_setDeviceSerialNumber((PhidgetHandle)mch, 595407);
	CheckError(prc, "Setting DeviceSerialNumber", (PhidgetHandle *)&mch);

	printf("Opening and Waiting for Attachment...\n");
	prc = Phidget_openWaitForAttachment((PhidgetHandle)mch, 5000);
	CheckOpenError(prc, (PhidgetHandle *)&mch);

	Sleep(5000);

	prc = Phidget_setDataInterval((PhidgetHandle)mch, dataInterval);
	CheckOpenError(prc, (PhidgetHandle *)&mch);

	//prc = PhidgetMagnetometer_getMagneticField(mch, &magField);
	//CheckOpenError(prc, (PhidgetHandle *)&mch);
	//printf("[Magnetometer Event] -> Magnetic Field: %7.3f%8.3f%8.3f\n", magField[0], magField[1], magField[2]);

	return mch;
}
