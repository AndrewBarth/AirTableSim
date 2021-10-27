% Script to test the phidget API
%
% Inputs: 
%
% Output: 
%
% Assumptions and Limitations:
%    The phidget device(s) must be attached
%    The script uses hardcoded paths that must be updated for the current
%    system.
%
% Dependencies:
%    Phidget22 python library
%    A python release must be available. Check the 'pyenv' command in
%    Matlab to verify that python was detected
%    The python path in matlab (py.sys.path) must be set up prior to execution
%
% References:
%    API for Phidgets found at phidgets.com
%
% Author: Andrew Barth
%
% Modification History:
%    May    2019 - Initial version
%

accelActive = 1;
gyroActive = 1;
magActive = 1;
rangeActive = 0;

P = py.sys.path;

pathval{1} = 'C:\Program Files\Phidget22Python';
pathval{2} = 'C:\Program Files\Phidget22Python\Phidget22';
pathval{3} = 'C:\Program Files\Phidget22Python\Phidget22\Devices';

for i = 1:size(pathval,2)
    if count(P,pathval{i}) == 0
        insert(P,int32(0),pathval{i});
    end
end
coder.extrinsic('py.Accelerometer.Accelerometer');

% Spatial_SerialNum = 595407;
Spatial_SerialNum = 484118;
RangeHub_SerialNum = 538408;

% Create Accelerometer object
if accelActive
    accelPhidget = py.Accelerometer.Accelerometer;
    accelPhidget.setDeviceSerialNumber(int32(Spatial_SerialNum));
    accelPhidget.setIsHubPortDevice(int32(0));
end

% Create a Gyroscope object
if gyroActive
    gyroPhidget = py.Gyroscope.Gyroscope;
    gyroPhidget.setDeviceSerialNumber(int32(Spatial_SerialNum));
    gyroPhidget.setIsHubPortDevice(int32(0)); 
end

% Create a Magnetometer object
if magActive
    magPhidget = py.Magnetometer.Magnetometer;
    magPhidget.setDeviceSerialNumber(int32(Spatial_SerialNum));
    magPhidget.setIsHubPortDevice(int32(0));
end

% Create a Distance Sensor object
if rangeActive
    distPhidget1 = py.DistanceSensor.DistanceSensor;
    distPhidget1.setDeviceSerialNumber(int32(RangeHub_SerialNum));
    distPhidget1.setHubPort(int32(0));

    distPhidget2 = py.DistanceSensor.DistanceSensor;
    distPhidget2.setDeviceSerialNumber(int32(RangeHub_SerialNum));
    distPhidget2.setHubPort(int32(1));

    distPhidget3 = py.DistanceSensor.DistanceSensor;
    distPhidget3.setDeviceSerialNumber(int32(RangeHub_SerialNum));
    distPhidget3.setHubPort(int32(4));

    distPhidget4 = py.DistanceSensor.DistanceSensor;
    distPhidget4.setDeviceSerialNumber(int32(RangeHub_SerialNum));
    distPhidget4.setHubPort(int32(5));
end

% Attach to the device
try
    if accelActive
        accelPhidget.openWaitForAttachment(int32(5000));
    end
    if gyroActive
        gyroPhidget.openWaitForAttachment(int32(5000));
    end
    if magActive
        magPhidget.openWaitForAttachment(int32(5000));
    end
    if rangeActive
        distPhidget1.openWaitForAttachment(int32(5000));
        distPhidget2.openWaitForAttachment(int32(5000));
        distPhidget3.openWaitForAttachment(int32(5000));
        distPhidget4.openWaitForAttachment(int32(5000));
    end
catch
    disp('Error attaching to Phidgets')
end
pause(30);

% Set the rate at which the device will gather data
if accelActive
    accelPhidget.setDataInterval(int32(10));
end
if gyroActive
    gyroPhidget.setDataInterval(int32(10));
end
if magActive
    magPhidget.setDataInterval(int32(10));
end
if rangeActive
    distPhidget1.setDataInterval(int32(100));
    distPhidget2.setDataInterval(int32(100));
    distPhidget3.setDataInterval(int32(100));
    distPhidget4.setDataInterval(int32(100));
end

disp('collecting data:')
npts = 100;
for i=1:npts
    if accelActive
        accelMeasurement(i,:) = cell2mat(cell(accelPhidget.getAcceleration()));
    end
    if gyroActive
        rateMeasurement(i,:)  = cell2mat(cell(gyroPhidget.getAngularRate()));
    end
    if magActive
        magFieldMeasurement(i,:)  = cell2mat(cell(magPhidget.getMagneticField()));
    end
    if rangeActive
        distMeasurement(i,1) = double(distPhidget1.getDistance());
        distMeasurement(i,2) = double(distPhidget2.getDistance());
        distMeasurement(i,3) = double(distPhidget1.getDistance());
        distMeasurement(i,4) = double(distPhidget2.getDistance());
    end
    pause(.10);
end

if accelActive
    accelPhidget.close();
end
if gyroActive
    gyroPhidget.close();
end
if magActive
    magPhidget.close();
end
if rangeActive
    distPhidget1.close();
    distPhidget2.close();
    distPhidget3.close();
    distPhidget4.close();
end

if accelActive
    figure;plot(1:npts,accelMeasurement)
    xlabel('Data Point');ylabel('Acceleration');
    legend('x','y','z')
    title('Acceleration Data')
end
if gyroActive
    figure;plot(1:npts,rateMeasurement)
    xlabel('Data Point');ylabel('Angular Rate');
    legend('x','y','z')
    title('Angular Rate Data')
end
if magActive
    figure;plot(1:npts,magFieldMeasurement)
    xlabel('Data Point');ylabel('Magnetic Field');
    legend('x','y','z')
    title('Magnetic Field Data')
end

clear accelPhidget gyroPhidget magPhidget distPhidget1 distPhidget2 distPhidget3 distPhidget4




