
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_1_*.mat'));
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_2_*.mat'));
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_3_*.mat'));
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_4_*.mat'));
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_5_*.mat'));
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_6_*.mat'));

clear data

% data1=load('ThrusterTest_1__stitched.mat');
% data2=load('ThrusterTest_2__stitched.mat');
% data3=load('ThrusterTest_3__stitched.mat');
% data4=load('ThrusterTest_4__stitched.mat');
% data5=load('ThrusterTest_5__stitched.mat');
% data6=load('ThrusterTest_6__stitched.mat');

npts = 2000;
iAccel(1) = mean(data1.rt_yout.signals(2).values(1:npts/2,1));
iAccel(2) = mean(data2.rt_yout.signals(2).values(1:npts/2,1));
iAccel(3) = mean(data3.rt_yout.signals(2).values(1:npts/2,2));
iAccel(4) = mean(data4.rt_yout.signals(2).values(1:npts/2,2));
iRate(5) =  data5.rt_yout.signals(2).values(npts/2,6);
iRate(6) =  data6.rt_yout.signals(2).values(npts/2,6);
sPt = npts/2;
ePt = sPt+npts/10;
tAccel(1) = mean(data1.rt_yout.signals(2).values(sPt:ePt,1));
tAccel(2) = mean(data2.rt_yout.signals(2).values(sPt:ePt,1));
tAccel(3) = mean(data3.rt_yout.signals(2).values(sPt:ePt,2));
tAccel(4) = mean(data4.rt_yout.signals(2).values(sPt:ePt,2));
fRate(5) =  data5.rt_yout.signals(2).values(ePt,6);
fRate(6) =  data6.rt_yout.signals(2).values(ePt,6);
dAccel = tAccel-iAccel;
dRate = fRate-iRate;


in2m = 0.0254;
g2mpss = 9.81;
d2r = pi/180;
m = [11.4]; 

% Dimensions of sled
width = 18*in2m;
depth = 18*in2m;
height = 6.5*in2m;

% Inertia of solid cube
Izz = 1/12 * m * (width^2 + depth^2);

thrust = dAccel*g2mpss*m;
angAccel = dRate*d2r/1;
moment = Izz*angAccel;
force = moment/(width/2);

return
data=data6;
thrusterCmds = squeeze(data.rt_yout.signals(1).values(1,:,:))';
sensorData = data.rt_yout.signals(2).values


% figure;
% subplot(4,1,1);plot(data.rt_tout,thrusterCmds(:,1))
% title('Thruster 1');xlabel('Time (sec)');ylabel('Cmd (--)')
% subplot(4,1,2);plot(data.rt_tout,thrusterCmds(:,2))
% title('Thruster 2');xlabel('Time (sec)');ylabel('Cmd (--)')
% subplot(4,1,3);plot(data.rt_tout,thrusterCmds(:,3))
% title('Thruster 3');xlabel('Time (sec)');ylabel('Cmd (--)')
% subplot(4,1,4);plot(data.rt_tout,thrusterCmds(:,4))
% title('Thruster 4');xlabel('Time (sec)');ylabel('Cmd (--)')
% 
% figure;
% subplot(4,1,1);plot(data.rt_tout,thrusterCmds(:,5))
% title('Thruster 5');xlabel('Time (sec)');ylabel('Cmd (--)')
% subplot(4,1,2);plot(data.rt_tout,thrusterCmds(:,6))
% title('Thruster 6');xlabel('Time (sec)');ylabel('Cmd (--)')
% subplot(4,1,3);plot(data.rt_tout,thrusterCmds(:,7))
% title('Thruster 7');xlabel('Time (sec)');ylabel('Cmd (--)')
% subplot(4,1,4);plot(data.rt_tout,thrusterCmds(:,8))
% title('Thruster 8');xlabel('Time (sec)');ylabel('Cmd (--)')

figure;
subplot(3,1,1);plot(data.rt_tout,sensorData(:,1))

title('X Axis Acceleration');xlabel('Time (sec)');ylabel('Accel (g''s)');
subplot(3,1,2);plot(data.rt_tout,sensorData(:,2))
title('Y Axis Acceleration');xlabel('Time (sec)');ylabel('Accel (g''s)');
subplot(3,1,3);plot(data.rt_tout,sensorData(:,3))
title('Z Axis Acceleration');xlabel('Time (sec)');ylabel('Accel (g''s)');

figure;
subplot(3,1,1);plot(data.rt_tout,sensorData(:,4))
title('X Axis Angular Rate');xlabel('Time (sec)');ylabel('Rate (deg/s)');
subplot(3,1,2);plot(data.rt_tout,sensorData(:,5))
title('Y Axis Angular Rate');xlabel('Time (sec)');ylabel('Rate (deg/s)');
subplot(3,1,3);plot(data.rt_tout,sensorData(:,6))
title('Z Axis Angular Rate');xlabel('Time (sec)');ylabel('Rate (deg/s)');