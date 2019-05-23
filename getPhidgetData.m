function [accelMeasurement,rateMeasurement,distMeasurement]= getPhidgetData()

coder.extrinsic('pyversion');
coder.extrinsic('addpath');
% persistent accelPhidget

% addpath("C:\Program Files\MATLAB\R2018b\toolbox\matlab\external\interfaces\python");
% addpath("C:\Program Files");
% addpath("C:\Program Files\Python-3.5.7");
% addpath("Z:\My Documents\MATLAB\AirTableSim\Phidget\Phidget_Library_Python");
% addpath("Z:\My Documents\Phidget22Python");
% addpath("Z:\My Documents\Phidget22Python\Phidget22");
% addpath("Z:\My Documents\Phidget22Python\Phidget22\Devices");

pyversion
pyinfo
% py.int(1)
% tw = py.textwrap.TextWrapper;

%     if isempty(accelPhidget)
%         accelPhidget = py.Accelerometer.Accelerometer;
%         accelPhidget.setDeviceSerialNumber(int32(484118));
%         accelPhidget.setIsHubPortDevice(int32(0));
%         accelPhidget.openWaitForAttachment(int32(5000));
%         pause(5);
%     end
% 
    accelMeasurement = 0;
    rateMeasurement = 0;
    distMeasurement = zeros(1,4);
%     
%     accelMeasurement   = cell2mat(cell(accelPhidget.getAcceleration()));
%     rateMeasurement    = cell2mat(cell(gyroPhidget.getAngularRate()));
%     distMeasurement(1) = double(distPhidget1.getDistance());
%     distMeasurement(2) = double(distPhidget2.getDistance());
%     distMeasurement(3) = double(distPhidget1.getDistance());
%     distMeasurement(4) = double(distPhidget2.getDistance());