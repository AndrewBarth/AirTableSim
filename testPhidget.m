
coder.extrinsic('py.Accelerometer.Accelerometer');
% addpath("C:\Program Files\MATLAB\R2018b\toolbox\matlab\external\interfaces\python");
% addpath("C:\Program Files");
% addpath("C:\Program Files\Python-3.5.7");
P = py.sys.path;
pathval{1} = 'Z:\My Documents\Phidget22Python';
pathval{2} = 'Z:\My Documents\Phidget22Python\Phidget22';
pathval{3} = 'Z:\My Documents\Phidget22Python\Phidget22\Devices';
pathval{4} = 'Z:\My Documents\MATLAB\AirTableSim';
for i = 1:size(pathval,2)
    if count(P,pathval{i}) == 0
        insert(P,int32(0),pathval{i});
    end
end

% Create Accelerometer object
accelPhidget = py.Accelerometer.Accelerometer;
accelPhidget.setDeviceSerialNumber(int32(484118));
accelPhidget.setIsHubPortDevice(int32(0));

% Create a Gyroscope object
gyroPhidget = py.Gyroscope.Gyroscope;
gyroPhidget.setDeviceSerialNumber(int32(484118));
gyroPhidget.setIsHubPortDevice(int32(0)); 

% Create a Distance Sensor object
distPhidget1 = py.DistanceSensor.DistanceSensor;
distPhidget1.setDeviceSerialNumber(int32(538408));
distPhidget1.setHubPort(int32(0));

distPhidget2 = py.DistanceSensor.DistanceSensor;
distPhidget2.setDeviceSerialNumber(int32(538408));
distPhidget2.setHubPort(int32(2));

distPhidget3 = py.DistanceSensor.DistanceSensor;
distPhidget3.setDeviceSerialNumber(int32(538408));
distPhidget3.setHubPort(int32(3));

distPhidget4 = py.DistanceSensor.DistanceSensor;
distPhidget4.setDeviceSerialNumber(int32(538408));
distPhidget4.setHubPort(int32(5));

% Attach to the device
try
    accelPhidget.openWaitForAttachment(int32(5000));
    gyroPhidget.openWaitForAttachment(int32(5000));
%     distPhidget1.openWaitForAttachment(int32(5000));
%     distPhidget2.openWaitForAttachment(int32(5000));
%     distPhidget3.openWaitForAttachment(int32(5000));
%     distPhidget4.openWaitForAttachment(int32(5000));
catch
    disp('Error attaching to Phidgets')
end
pause(30);

% Set the rate at which the device will gather data
accelPhidget.setDataInterval(int32(10));
gyroPhidget.setDataInterval(int32(10));
% distPhidget1.setDataInterval(int32(100));
% distPhidget2.setDataInterval(int32(100));
% distPhidget3.setDataInterval(int32(100));
% distPhidget4.setDataInterval(int32(100));

disp('collecting data:')
for i=1:100
    accelMeasurement(i,:) = cell2mat(cell(accelPhidget.getAcceleration()));
    rateMeasurement(i,:)  = cell2mat(cell(gyroPhidget.getAngularRate()));
%     distMeasurement(i,1) = double(distPhidget1.getDistance());
%     distMeasurement(i,2) = double(distPhidget2.getDistance());
%     distMeasurement(i,3) = double(distPhidget1.getDistance());
%     distMeasurement(i,4) = double(distPhidget2.getDistance());
    pause(.10);
end

accelPhidget.close();
gyroPhidget.close();
distPhidget1.close();
distPhidget2.close();
distPhidget3.close();
distPhidget4.close();
clear accelPhidget gyroPhidget distPhidget1 distPhidget2 distPhidget3 distPhidget4




