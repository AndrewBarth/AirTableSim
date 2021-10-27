
addpath('Phidget\Phidget_Library_C\Phidget_Library_C');
addpath('Phidget\Phidget_Library_C\x64\Debug')
addpath('C:\Program Files\Phidgets\Phidget22');
clear axPtr ayPtr azPtr ax ay az

axPtr=libpointer('doublePtr',0);
ayPtr=libpointer('doublePtr',0);
azPtr=libpointer('doublePtr',0);
timePtr = libpointer('doublePtr',0);

% [notfound,warnings]=loadlibrary('Phidget_Library.dll','Accelerometer.h','addheader','PhidgetHelperFunctions.h','addheader','phidget22.h');
[notfound,warnings]=loadlibrary('Phidget_Library.dll','PhidgetHelperFunctions.h','addheader','phidget22.h');
[rc] = calllib('Phidget_Library','Accelerometermain',axPtr,ayPtr,azPtr,timePtr);
ax = get(axPtr,'Value');
ay = get(ayPtr,'Value');
az = get(azPtr,'Value');
timestamp = get(timePtr,'Value');

disp(sprintf("Acceleration: %7.3f %7.3f %7.3f %7.3f\n",ax,ay,az,timestamp)) 

% unloadlibrary('Phidget_Library');


