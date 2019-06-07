import sys
import time
import traceback

from Phidget22.Devices.Accelerometer import *
from Phidget22.PhidgetException import *
from Phidget22.Phidget import *
from Phidget22.Net import *

try:
    from PhidgetHelperFunctions import *
except ImportError:
    sys.stderr.write("\nCould not find PhidgetHelperFunctions. Either add PhdiegtHelperFunctions.py to your project folder "
                      "or remove the import from your project.")
    sys.stderr.write("\nPress ENTER to end program.")
    readin = sys.stdin.readline()
    sys.exit()

"""
* Configures the device's DataInterval and ChangeTrigger.
* Displays info about the attached Phidget channel.
* Fired when a Phidget channel with onAttachHandler registered attaches
*
* @param self The Phidget channel that fired the attach event
"""
def onAttachHandler(self):
    
    ph = self
    try:
        #If you are unsure how to use more than one Phidget channel with this event, we recommend going to
        #www.phidgets.com/docs/Using_Multiple_Phidgets for information
        
        print("\nAttach Event:")
        
        """
        * Get device information and display it.
        """
        channelClassName = ph.getChannelClassName()
        serialNumber = ph.getDeviceSerialNumber()
        channel = ph.getChannel()
        if(ph.getDeviceClass() == DeviceClass.PHIDCLASS_VINT):
            hubPort = ph.getHubPort()
            print("\n\t-> Channel Class: " + channelClassName + "\n\t-> Serial Number: " + str(serialNumber) +
                "\n\t-> Hub Port: " + str(hubPort) + "\n\t-> Channel:  " + str(channel) + "\n")
        else:
            print("\n\t-> Channel Class: " + channelClassName + "\n\t-> Serial Number: " + str(serialNumber) +
                    "\n\t-> Channel:  " + str(channel) + "\n")
        
        """
        * Set the DataInterval inside of the attach handler to initialize the device with this value.
        * DataInterval defines the minimum time between AccelerationChange events.
        * DataInterval can be set to any value from MinDataInterval to MaxDataInterval.
        """
        print("\n\tSetting DataInterval to 10ms")
        ph.setDataInterval(10)

        """
        * Set the AccelerationChangeTrigger inside of the attach handler to initialize the device with this value.
        * AccelerationChangeTrigger will affect the frequency of AccelerationChange events, by limiting them to only occur when
        * the acceleration changes by at least the value set.
        """
        print("\tSetting Acceleration ChangeTrigger to 0.0")
        ph.setAccelerationChangeTrigger(0.0)
        
    except PhidgetException as e:
        print("\nError in Attach Event:")
        DisplayError(e)
        traceback.print_exc()
        return

"""
* Displays info about the detached Phidget channel.
* Fired when a Phidget channel with onDetachHandler registered detaches
*
* @param self The Phidget channel that fired the attach event
"""
def onDetachHandler(self):

    ph = self
    try:
        #If you are unsure how to use more than one Phidget channel with this event, we recommend going to
        #www.phidgets.com/docs/Using_Multiple_Phidgets for information
    
        print("\nDetach Event:")
        
        """
        * Get device information and display it.
        """
        serialNumber = ph.getDeviceSerialNumber()
        channelClass = ph.getChannelClassName()
        channel = ph.getChannel()
        
        deviceClass = ph.getDeviceClass()
        if (deviceClass != DeviceClass.PHIDCLASS_VINT):
            print("\n\t-> Channel Class: " + channelClass + "\n\t-> Serial Number: " + str(serialNumber) +
                  "\n\t-> Channel:  " + str(channel) + "\n")
        else:            
            hubPort = ph.getHubPort()
            print("\n\t-> Channel Class: " + channelClass + "\n\t-> Serial Number: " + str(serialNumber) +
                  "\n\t-> Hub Port: " + str(hubPort) + "\n\t-> Channel:  " + str(channel) + "\n")
        
    except PhidgetException as e:
        print("\nError in Detach Event:")
        DisplayError(e)
        traceback.print_exc()
        return


"""
* Writes Phidget error info to stderr.
* Fired when a Phidget channel with onErrorHandler registered encounters an error in the library
*
* @param self The Phidget channel that fired the attach event
* @param errorCode the code associated with the error of enum type ph.ErrorEventCode
* @param errorString string containing the description of the error fired
"""
def onErrorHandler(self, errorCode, errorString):

    sys.stderr.write("[Phidget Error Event] -> " + errorString + " (" + str(errorCode) + ")\n")

"""
* Outputs the Accelerometer's most recently reported acceleration.
* Fired when a Accelerometer channel with onAccelerationChangeHandler registered meets DataInterval and ChangeTrigger criteria
*
* @param self The Accelerometer channel that fired the AccelerationChange event
* @param acceleration The reported acceleration from the Accelerometer channel
"""
def onAccelerationChangeHandler(self, acceleration, timestamp):

    print("[Acceleration Event] -> Acceleration: %f %f %f" % (acceleration[0], acceleration[1], acceleration[2]))
    print("                      -> Timestamp   : %f\n" % timestamp)

"""
* Prints descriptions of how events related to this class work
"""
def PrintEventDescriptions():

    print("\n--------------------\n"
        "\n  | Acceleration change events will call their associated function every time new acceleration data is received from the device.\n"
        "  | The rate of these events can be set by adjusting the DataInterval for the channel.\n"
        "  | Press ENTER once you have read this message.")
        
    readin = sys.stdin.readline(1)
    
    print("\n--------------------")
   
"""
* Creates, configures, and opens a Accelerometer channel.
* Displays Acceleration events for 10 seconds
* Closes out Accelerometer channel
*
* @return 0 if the program exits successfully, 1 if it exits with errors.
"""
def AccelerometerMain():
    try:
        """
        * Allocate a new Phidget Channel object
        """
        ch = Accelerometer()

        """
        * Set matching parameters to specify which channel to open
        """
        
        #You may remove this line and hard-code the addressing parameters to fit your application
        #ALB channelInfo = AskForDeviceParameters(ch)
        
        #ALB ch.setDeviceSerialNumber(channelInfo.deviceSerialNumber)
        #ALB ch.setHubPort(channelInfo.hubPort)
        #ALB ch.setIsHubPortDevice(channelInfo.isHubPortDevice)
        #ALB ch.setChannel(channelInfo.channel)   
        
        ch.setDeviceSerialNumber(484118)
        #ch.setHubPort(2)
        ch.setIsHubPortDevice(0)

        #ALB if(channelInfo.netInfo.isRemote):
        #ALB     ch.setIsRemote(channelInfo.netInfo.isRemote)
        #ALB     if(channelInfo.netInfo.serverDiscovery):
        #ALB         try:
        #ALB             Net.enableServerDiscovery(PhidgetServerType.PHIDGETSERVER_DEVICEREMOTE)
        #ALB         except PhidgetException as e:
        #ALB             PrintEnableServerDiscoveryErrorMessage(e)
        #ALB             raise EndProgramSignal("Program Terminated: EnableServerDiscovery Failed")
        #ALB     else:
        #ALB         Net.addServer("Server", channelInfo.netInfo.hostname,
        #ALB             channelInfo.netInfo.port, channelInfo.netInfo.password, 0)
        
        """
        * Add event handlers before calling open so that no events are missed.
        """
        print("\n--------------------------------------")
        print("\nSetting OnAttachHandler...")
        ch.setOnAttachHandler(onAttachHandler)
        
        print("Setting OnDetachHandler...")
        ch.setOnDetachHandler(onDetachHandler)
        
        print("Setting OnErrorHandler...")
        ch.setOnErrorHandler(onErrorHandler)
        
        #This call may be harmlessly removed
        #ALB PrintEventDescriptions()
        
        print("\nSetting OnAccelerationChangeHandler...")
        ch.setOnAccelerationChangeHandler(onAccelerationChangeHandler)
        
        """
        * Open the channel with a timeout
        """
        
        print("\nOpening and Waiting for Attachment...")
        
        try:
            ch.openWaitForAttachment(5000)
        except PhidgetException as e:
            PrintOpenErrorMessage(e, ch)
            raise EndProgramSignal("Program Terminated: Open Failed")
        
        print("Sampling data for 2 seconds...")
        
        print("You can do stuff with your Phidgets here and/or in the event handlers.")
        
        time.sleep(2)
        
        """
        * Perform clean up and exit
        """

        print("\nDone Sampling...")

        print("Cleaning up...")
        ch.close()
        print("\nExiting...")
        return 0

    except PhidgetException as e:
        sys.stderr.write("\nExiting with error(s)...")
        DisplayError(e)
        traceback.print_exc()
        print("Cleaning up...")
        ch.close()
        return 1
    except EndProgramSignal as e:
        print(e)
        print("Cleaning up...")
        ch.close()
        return 1
    except RuntimeError as e:
         sys.stderr.write("Runtime Error: \n\t" + e)
         traceback.print_exc()
         return 1
    finally:
        #ALB print("Press ENTER to end program.")
        #ALB readin = sys.stdin.readline()
        return 0

#main()

