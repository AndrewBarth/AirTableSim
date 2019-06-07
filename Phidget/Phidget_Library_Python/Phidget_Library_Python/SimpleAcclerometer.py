import sys
import time
import traceback

from Phidget22.Devices.Accelerometer import *
from Phidget22.PhidgetException import *
from Phidget22.Phidget import *
from Phidget22.Net import *


#from AccelerometerInit import *

class myAccelerometer:
    def myAccelerometerFcn(self):
        #AccelerometerMain()



        accelPhidget = Accelerometer()
        accelPhidget.setDeviceSerialNumber(484118)
        accelPhidget.setIsHubPortDevice(0)
        accelPhidget.openWaitForAttachment(5000)
        time.sleep(5)
        val = accelPhidget.getAcceleration()
        print("Final Point\n")
        print(val)

theAccel = myAccelerometer()
theAccel.myAccelerometerFcn()