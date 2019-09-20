
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

data1=load('testUDP_2_1.mat');
data2=load('testUDP_2_1.mat');
data3=load('testUDP_3_1.mat');
data4=load('testUDP_4_1.mat');
data5=load('testUDP_5_1.mat');
data6=load('testUDP_6_1.mat');

in2m = 0.0254;
g2mpss = 9.81;
d2r = pi/180;
% mass = [11.4]; 
mass = [18.0];

% Dimensions of sled
width = 18*in2m;
depth = 18*in2m;
height = 6.5*in2m;

% Inertia of solid cube
Izz = 1/12 * mass * (width^2 + depth^2);

% ignore the first second of data
beginTime = 1;
startTime = 5;
endTime = 7;

clear filtAccel filtRate iAccel eAccel iRate eRate dAccel dRate
for i=1:6
    newVar = strcat('data',int2str(i));
    data = eval(newVar);
    filtAccel = squeeze(data.rt_yout.signals(2).values(1,1:3,:));
    filtRate  = squeeze(data.rt_yout.signals(2).values(1,4:6,:));
    
    sPt = find(data.rt_tout>startTime,1);
    ePt = find(data.rt_tout>endTime,1);
    bPt = find(data1.rt_tout>beginTime,1);
    
    basePt = (sPt - bPt)/2;
    duration = endTime-startTime;
    offset = 0.2;
    
    newsPt = find(data.rt_tout>(startTime+duration*offset),1);
    newePt = find(data.rt_tout>(endTime-duration*offset),1);
    deltaTime = data.rt_tout(newePt) - data.rt_tout(newsPt);
    
    if i == 1 || i == 2
        iAccel(i) = mean(filtAccel(1,bPt:basePt));
        eAccel(i) = mean(filtAccel(1,newsPt:newePt));
        dAccel(i) = eAccel(i) - iAccel(i);
        thrust(i) = dAccel(i)*mass;
    elseif i == 3 || i == 4
        iAccel(i) = mean(filtAccel(2,bPt:basePt));
        eAccel(i) = mean(filtAccel(2,newsPt:newePt));
        dAccel(i) = eAccel(i) - iAccel(i);
        thrust(i) = dAccel(i)*mass;
    elseif i == 5 || i == 6
        iRate(i) = mean(filtRate(3,bPt:basePt));
        eRate(i) = mean(filtRate(3,newsPt:newePt));
        dRate(i) = eRate(i) - iRate(i);
        angAccel(i) = dRate(i)/deltaTime;
        moment(i) = Izz*angAccel(i);
        force(i) = moment(i)/(width/2);
    end
    
    
    
    
    
end
return








 


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