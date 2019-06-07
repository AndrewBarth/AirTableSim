function [accelMeasurement] = testpython(accelPhidget)

% persistent accelPhidget
% coder.extrinsic('pyversion');
% coder.extrinsic('py.int');
% coder.extrinsic('py.sys.path');
% coder.extrinsic('py.sys.path.insert');
% coder.extrinsic('py.Accelerometer.Accelerometer');
% coder.extrinsic('py.Manager');
% coder.extrinsic('py.AccelerometerInit');
% coder.extrinsic('py.myAccelerometer.myAccelerometerFcn');
% P = py.sys.path;

% pathval = cell(1,3);
% pathval{1} = 'Z:\My Documents\Phidget22Python';
% pathval{2} = 'Z:\My Documents\Phidget22Python\Phidget2';
% pathval{3} = 'Z:\My Documents\Phidget22Python\Phidget22\Devices';

% for i = 1:size(pathval,2)
%     if count(P,pathval{i}) == 0
%         insert(P,int32(0),pathval{i});
%     end
% end
% if count(P,char('Z:\My Documents\Phidget22Python')) == 0
%     insert(P,int32(0),'Z:\My Documents\Phidget22Python');
% end
% if count(P,char('Z:\My Documents\Phidget22Python\Phidget2')) == 0
%     insert(P,int32(0),char('Z:\My Documents\Phidget22Python\Phidget2'));
% end
% if count(P,char('Z:\My Documents\Phidget22Python\Phidget22\Devices')) == 0
%     insert(P,int32(0),char('Z:\My Documents\Phidget22Python\Phidget22\Devices'));
% end
% pyversion
x = py.int(1);

%     if isempty(accelPhidget)
%         accelPhidget = py.Accelerometer.Accelerometer
%         py.AccelerometerInit()
%         py.myAccelerometer.myAccelerometerFcn()
        test = int64(accelPhidget.getAttached())
        if test == 0
            test2 = int64(accelPhidget.getDeviceSerialNumber())
            test3 = int64(accelPhidget.getIsChannel())
    %         testAccel(:) = cell2mat(cell(accelPhidget.getAcceleration()))
            accelPhidget.setDeviceSerialNumber(int32(484118));
            disp('test1')
    %         test4 = int64(accelPhidget.getDeviceID())
            accelPhidget.setIsHubPortDevice(int32(0));
            disp('test2')
            accelPhidget.openWaitForAttachment(int32(10000));
            disp('test3')
            pause(5);
        end
%     end
% accelMeasurement = [0 0 0];
accelMeasurement(:) = cell2mat(cell(accelPhidget.getAcceleration()));