#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#include "phidget22.h"
#include "PhidgetHelperFunctions.h"


/**
* Configures the device's DataInterval and ChangeTrigger.
* Displays info about the attached Phidget channel.
* Fired when a Phidget channel with onAttachHandler registered attaches
*
* @param ph The Phidget channel that fired the attach event
* @param *ctx Context pointer. Used to pass information to the event handler.
*/
static void CCONV onAttachHandler(PhidgetHandle ph, void *ctx) {
	PhidgetReturnCode prc; //Used to catch error codes from each Phidget function call
	Phidget_DeviceClass deviceClass;
	const char* channelClassName;
	int32_t serialNumber;
	int32_t hubPort;
	int32_t channel;

	//If you are unsure how to use more than one Phidget channel with this event, we recommend going to
	//www.phidgets.com/docs/Using_Multiple_Phidgets for information

	printf("\nAttach Event: ");
	/*
	* Get device information and display it.
	*/
	prc = Phidget_getDeviceSerialNumber(ph, &serialNumber);
	CheckError(prc, "Getting DeviceSerialNumber", (PhidgetHandle *)&ph);

	prc = Phidget_getChannel(ph, &channel);
	CheckError(prc, "Getting Channel", (PhidgetHandle *)&ph);

	prc = Phidget_getChannelClassName(ph, &channelClassName);
	CheckError(prc, "Getting Channel Class Name", (PhidgetHandle *)&ph);

	prc = Phidget_getDeviceClass(ph, &deviceClass);
	CheckError(prc, "Getting Device Class", (PhidgetHandle *)&ph);

	if (deviceClass == PHIDCLASS_VINT) {
		prc = Phidget_getHubPort(ph, &hubPort);
		CheckError(prc, "Getting HubPort", (PhidgetHandle *)&ph);

		printf("\n\t-> Channel Class: %s\n\t-> Serial Number: %d\n\t-> Hub Port: %d\n\t-> Channel %d\n\n", channelClassName, serialNumber, hubPort, channel);
	}
	else { //Not VINT
		printf("\n\t-> Channel Class: %s\n\t-> Serial Number: %d\n\t-> Channel %d\n\n", channelClassName, serialNumber, channel);
	}

	/*
	*	Set the DataInterval inside of the attach handler to initialize the device with this value.
	*	DataInterval defines the minimum time between AccelerationChange events.
	*	DataInterval can be set to any value from MinDataInterval to MaxDataInterval.
	*/
	printf("\tSetting DataInterval to 1000ms\n");
	prc = PhidgetAccelerometer_setDataInterval((PhidgetAccelerometerHandle)ph, 1000);
	CheckError(prc, "Setting DataInterval", (PhidgetHandle *)&ph);

	/*
	*	Set the AccelerationChangeTrigger inside of the attach handler to initialize the device with this value.
	*	AccelerationChangeTrigger will affect the frequency of AccelerationChange events, by limiting them to only occur when
	*	the acceleration changes by at least the value set.
	*/
	printf("\tSetting Acceleration ChangeTrigger to 0.0\n");
	prc = PhidgetAccelerometer_setAccelerationChangeTrigger((PhidgetAccelerometerHandle)ph, 0.0);
	CheckError(prc, "Setting ChangeTrigger", (PhidgetHandle *)&ph);
}

/**
* Displays info about the detached Phidget channel.
* Fired when a Phidget channel with onDetachHandler registered detaches
*
* @param ph The Phidget channel that fired the detach event
* @param *ctx Context pointer. Used to pass information to the event handler.
*/
static void CCONV onDetachHandler(PhidgetHandle ph, void *ctx) {
	PhidgetReturnCode prc; //Used to catch error codes from each Phidget function call
	Phidget_DeviceClass deviceClass;
	const char* channelClassName;
	int32_t serialNumber;
	int32_t hubPort;
	int32_t channel;

	//If you are unsure how to use more than one Phidget channel with this event, we recommend going to
	//www.phidgets.com/docs/Using_Multiple_Phidgets for information

	printf("\nDetach Event: ");
	/*
	* Get device information and display it.
	*/
	prc = Phidget_getDeviceSerialNumber(ph, &serialNumber);
	CheckError(prc, "Getting DeviceSerialNumber", (PhidgetHandle *)&ph);

	prc = Phidget_getChannel(ph, &channel);
	CheckError(prc, "Getting Channel", (PhidgetHandle *)&ph);

	prc = Phidget_getChannelClassName(ph, &channelClassName);
	CheckError(prc, "Getting Channel Class Name", (PhidgetHandle *)&ph);

	prc = Phidget_getDeviceClass(ph, &deviceClass);
	CheckError(prc, "Getting Device Class", (PhidgetHandle *)&ph);

	if (deviceClass == PHIDCLASS_VINT) {
		prc = Phidget_getHubPort(ph, &hubPort);
		CheckError(prc, "Getting HubPort", (PhidgetHandle *)&ph);

		printf("\n\t-> Channel Class: %s\n\t-> Serial Number: %d\n\t-> Hub Port: %d\n\t-> Channel %d\n\n", channelClassName, serialNumber, hubPort, channel);
	}
	else { //Not VINT
		printf("\n\t-> Channel Class: %s\n\t-> Serial Number: %d\n\t-> Channel %d\n\n", channelClassName, serialNumber, channel);
	}
}

/**
* Writes Phidget error info to stderr.
* Fired when a Phidget channel with onErrorHandler registered encounters an error in the library
*
* @param ph The Phidget channel that fired the error event
* @param *ctx Context pointer. Used to pass information to the event handler.
* @param errorCode the code associated with the error of enum type Phidget_ErrorEventCode
* @param *errorString string containing the description of the error fired
*/
static void CCONV onErrorHandler(PhidgetHandle ph, void *ctx, Phidget_ErrorEventCode errorCode, const char *errorString) {

	fprintf(stderr, "[Phidget Error Event] -> %s (%d)\n", errorString, errorCode);
}

/**
* Outputs the Accelerometer's most recently reported acceleration.
* Fired when a Accelerometer channel with onAccelerationChangeHandler registered meets DataInterval and ChangeTrigger criteria
*
* @param ph The Accelerometer channel that fired the AccelerationChange event
* @param *ctx Context pointer. Used to pass information to the event handler.
* @param *acceleration An array representing the acceleration from each axis of the Accelerometer channel
* @param timestamp The timestamp of the data sent from the Accelerometer channel
*/
static void CCONV onAccelerationChangeHandler(PhidgetAccelerometerHandle ch, void *ctx, const double* acceleration, double timestamp) {

	printf("[Acceleration Event] -> Acceleration: %7.3f%8.3f%8.3f\n", acceleration[0], acceleration[1], acceleration[2]);
	printf("                     -> Timestamp:    %.0f\n\n", timestamp);
}

/**
* Prints descriptions of the available events for this class
*/
void PrintEventDescriptions() {

	printf("\n--------------------\n"
		"\n  | Acceleration change events will call their associated function every time new acceleration data is received from the device.\n"
		"  | The rate of these events can be set by adjusting the DataInterval for the channel.\n"
		"  | Press ENTER once you have read this message.\n");

	getchar();

	printf("\n--------------------\n");
}


/**
* Creates, configures, and opens a Accelerometer channel.
* Displays acceleration change events for 10 seconds
* Closes out Accelerometer channel
*
* @return 0 if the program exits successfully, 1 if it exits with errors.
*/
int main() {
	PhidgetAccelerometerHandle ch = NULL;
	ChannelInfo channelInfo; //Information from AskForDeviceParameters(). May be removed when hard-coding parameters.
	PhidgetReturnCode prc; //Used to catch error codes from each Phidget function call

						   /*
						   * Allocate a new Phidget Channel object
						   */

	prc = PhidgetAccelerometer_create(&ch);
	CheckError(prc, "Creating Channel", (PhidgetHandle *)&ch);

	/*
	* Set addressing parameters to specify which channel to open
	*/

	//You can safely remove this line and hard-code the parameters to make the program can start without user input
	/*AskForDeviceParameters(&channelInfo, (PhidgetHandle *)&ch);

	prc = Phidget_setDeviceSerialNumber((PhidgetHandle)ch, channelInfo.deviceSerialNumber);
	CheckError(prc, "Setting DeviceSerialNumber", (PhidgetHandle *)&ch);

	prc = Phidget_setHubPort((PhidgetHandle)ch, channelInfo.hubPort);
	CheckError(prc, "Setting HubPort", (PhidgetHandle *)&ch);

	prc = Phidget_setChannel((PhidgetHandle)ch, channelInfo.channel);
	CheckError(prc, "Setting Channel", (PhidgetHandle *)&ch);

	if (channelInfo.netInfo.isRemote) {
		prc = Phidget_setIsRemote((PhidgetHandle)ch, channelInfo.netInfo.isRemote);
		CheckError(prc, "Setting IsRemote", (PhidgetHandle *)&ch);
		if (channelInfo.netInfo.serverDiscovery) {
			prc = PhidgetNet_enableServerDiscovery(PHIDGETSERVER_DEVICEREMOTE);
			CheckEnableServerDiscoveryError(prc, (PhidgetHandle *)&ch);
		}
		else {
			prc = PhidgetNet_addServer("Server", channelInfo.netInfo.hostname,
				channelInfo.netInfo.port, channelInfo.netInfo.password, 0);
			CheckError(prc, "Adding Server", (PhidgetHandle *)&ch);
		}
	} */
	prc = Phidget_setDeviceSerialNumber((PhidgetHandle)ch, 484118);
	CheckError(prc, "Setting DeviceSerialNumber", &(PhidgetHandle)ch);

	/*
	* Add event handlers before calling open so that no events are missed.
	*/

	printf("\n--------------------------------------\n");
	printf("\nSetting OnAttachHandler...\n");
	prc = Phidget_setOnAttachHandler((PhidgetHandle)ch, onAttachHandler, NULL);
	CheckError(prc, "Setting OnAttachHandler", (PhidgetHandle *)&ch);

	printf("Setting OnDetachHandler...\n");
	prc = Phidget_setOnDetachHandler((PhidgetHandle)ch, onDetachHandler, NULL);
	CheckError(prc, "Setting OnDetachHandler", (PhidgetHandle *)&ch);

	printf("Setting OnErrorHandler...\n");
	prc = Phidget_setOnErrorHandler((PhidgetHandle)ch, onErrorHandler, NULL);
	CheckError(prc, "Setting OnErrorHandler", (PhidgetHandle *)&ch);

	//This call may be harmlessly removed
	PrintEventDescriptions();

	printf("Setting OnAccelerationChangeHandler...\n");
	prc = PhidgetAccelerometer_setOnAccelerationChangeHandler(ch, onAccelerationChangeHandler, NULL);
	CheckError(prc, "Setting OnAccelerationChangeHandler", (PhidgetHandle *)&ch);

	/*
	* Open the channel with a timeout
	*/
	printf("Opening and Waiting for Attachment...\n");
	prc = Phidget_openWaitForAttachment((PhidgetHandle)ch, 5000);
	CheckOpenError(prc, (PhidgetHandle *)&ch);

	/*
	* To find additional functionality not included in this example,
	* be sure to check the API for your device.
	*/

	printf("Sampling data for 10 seconds...\n");

	Sleep(10000);

	/*
	* Perform clean up and exit
	*/

	printf("\nDone Sampling...\n");

	printf("Cleaning up...\n");
	prc = Phidget_close((PhidgetHandle)ch);
	CheckError(prc, "Closing Channel", (PhidgetHandle *)&ch);
	prc = PhidgetAccelerometer_delete(&ch);
	CheckError(prc, "Deleting Channel", (PhidgetHandle *)&ch);
	printf("\nExiting...\n");
	printf("Press ENTER to end program.\n");
	getchar();

	return 0;

}
