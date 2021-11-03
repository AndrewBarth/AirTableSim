#include <stdio.h>
#include <stdlib.h>

#include <phidget22.h>
#include "PhidgetHelperFunctions.h"


PhidgetAccelerometerHandle AccelerometerInit();
PhidgetGyroscopeHandle GyroscopeInit();
int DistanceInit(PhidgetDistanceSensorHandle dch[] );

int main() {
	
	int rc;
	PhidgetAccelerometerHandle ach;
	PhidgetGyroscopeHandle gch;
        PhidgetDistanceSensorHandle dch[4];
	PhidgetReturnCode prc; //Used to catch error codes from each Phidget function call
	
	double acceleration[3];
	double angularRate[3];
        int    distance[4];

        printf("Run this as sudo!!!\n");

	ach = AccelerometerInit();
	gch = GyroscopeInit();
        rc = DistanceInit(dch);
        

	prc = PhidgetAccelerometer_getAcceleration(ach, &acceleration);
	CheckOpenError(prc, (PhidgetHandle *)&ach);
	printf("[Final Acceleration Event] -> Acceleration: %7.3f%8.3f%8.3f\n", acceleration[0], acceleration[1], acceleration[2]);

	prc = PhidgetGyroscope_getAngularRate(gch, &angularRate);
	CheckOpenError(prc, (PhidgetHandle *)&gch);
	printf("[Final Angular Rate Event] -> Angular Rate: %7.3f%8.3f%8.3f\n", angularRate[0], angularRate[1], angularRate[2]);

	for (int i = 0; i < 4; i++) {
		prc = PhidgetDistanceSensor_getDistance(dch[i], &distance[i]);
		CheckOpenError(prc, (PhidgetHandle *)&dch[i]);
	}
	printf("[Final Distance Event] -> Distance: %6d %6d %6d %6d\n", distance[0], distance[1], distance[2], distance[3]);

	printf("Press ENTER to end program.\n");
	getchar();

	return 0;
}
