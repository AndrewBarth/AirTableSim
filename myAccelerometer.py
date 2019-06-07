from AccelerometerInit import *

AccelerometerMain()



accelPhidget = Accelerometer()
accelPhidget.setDeviceSerialNumber(484118)
accelPhidget.setIsHubPortDevice(0)
accelPhidget.openWaitForAttachment(5000)
time.sleep(5)
val = accelPhidget.getAcceleration()
print("Final Point\n")
print(val)