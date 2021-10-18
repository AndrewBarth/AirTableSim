
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_1_*.mat'));
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_2_*.mat'));
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_3_*.mat'));
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_4_*.mat'));
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_5_*.mat'));
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_6_*.mat'));
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_7_*.mat'));
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_8_*.mat'));
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_9_*.mat'));
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_10_*.mat'));
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_11_*.mat'));
% Raspberrypi_MAT_stitcher(dir('ThrusterTest_12_*.mat'));

clear data

% data1=load('ThrusterTest_1__stitched.mat');
% data2=load('ThrusterTest_2__stitched.mat');
% data3=load('ThrusterTest_3__stitched.mat');
% data4=load('ThrusterTest_4__stitched.mat');
% data5=load('ThrusterTest_5__stitched.mat');
% data6=load('ThrusterTest_6__stitched.mat');
% data7=load('ThrusterTest_7__stitched.mat');
% data8=load('ThrusterTest_8__stitched.mat');
% data9=load('ThrusterTest_9__stitched.mat');
% data10=load('ThrusterTest_10__stitched.mat');
% data11=load('ThrusterTest_11__stitched.mat');
% data12=load('ThrusterTest_12__stitched.mat');

data1=load('ThrusterTest_new_1__stitched.mat');

% nCase = 12;
nCase = 1;
% Define type of test (1: X trans, 2: Y trans, 3: rot)
type = [1 1 2 2 3 3 1 1 2 2 3 3];

% data1=load('testUDP_2_1.mat');
% data2=load('testUDP_2_1.mat');
% data3=load('testUDP_3_1.mat');
% data4=load('testUDP_4_1.mat');
% data5=load('testUDP_5_1.mat');
% data6=load('testUDP_6_1.mat');

in2m = 0.0254;
g2mpss = 9.81;
d2r = pi/180;
% mass = [11.4]; 
mass = [19.0];   % kg

% Dimensions of sled
width = 18*in2m;
depth = 18*in2m;
height = 6.5*in2m;

% Inertia of solid cube
inertiaSF = 0.63;
Izz = 1/12 * mass * (width^2 + depth^2);
Izz = Izz*inertiaSF;

% ignore the first second of data
beginTime = 1;
startTime = 5;
endTime = 6;
% ignore the beginning of the firing
boffset = 0.4;
eoffset = 0.1;

clear iAccel eAccel dAccel thrust iRate eRate dRate angAccel moment force
thrust = zeros(nCase,1);
moment = zeros(nCase,1);
force = zeros(nCase,1);
for i=1:nCase
    clear filtAccel filtRate
    
    newVar = strcat('data',int2str(i));
    data = eval(newVar);
%     filtAccel = squeeze(data.rt_yout.signals(2).values(1,1:3,:));
%     filtRate  = squeeze(data.rt_yout.signals(2).values(1,4:6,:));
    filtAccel = (data.rt_yout.signals(2).values(:,1:3)*g2mpss)';
    filtRate  = (data.rt_yout.signals(2).values(:,4:6)*d2r)';
    
    sPt = find(data.rt_tout>startTime,1);
    ePt = find(data.rt_tout>endTime,1);
    bPt = find(data1.rt_tout>beginTime,1);
    
    basePt = (sPt - bPt)/2;
    duration = endTime-startTime;
    
    newsPt = find(data.rt_tout>(startTime+duration*boffset),1);
    newePt = find(data.rt_tout>(endTime-duration*eoffset),1);
    deltaTime = data.rt_tout(newePt) - data.rt_tout(newsPt);
    
    
    if type(i) == 1
%         iAccel(i) = mean(filtAccel(1,bPt:basePt));
        iAccel(i) = mean(filtAccel(1,bPt:sPt));
        eAccel(i) = mean(filtAccel(1,newsPt:newePt));
        dAccel(i) = eAccel(i) - iAccel(i);
        thrust(i) = dAccel(i)*mass;
    elseif type(i) == 2
%         iAccel(i) = mean(filtAccel(2,bPt:basePt));
        iAccel(i) = mean(filtAccel(2,bPt:sPt));
        eAccel(i) = mean(filtAccel(2,newsPt:newePt));
        dAccel(i) = eAccel(i) - iAccel(i);
        thrust(i) = dAccel(i)*mass;
    elseif type(i) == 3
%         iRate(i) = mean(filtRate(3,bPt:basePt));
        iRate(i) = mean(filtRate(3,bPt:sPt));
        eRate(i) = filtRate(3,newePt);
        dRate(i) = eRate(i) - iRate(i);
        angAccel(i) = dRate(i)/deltaTime;
        moment(i) = Izz*angAccel(i);
        force(i) = moment(i)/(width/2);
    end
    
    figure;
    subplot(2,1,1);plot(data.rt_tout,filtAccel(1,:))
    xlabel('Time (sec)');ylabel('Accel (m/s2)');
    title(['X Linear Acceleration, Case: ' num2str(i)])
    subplot(2,1,2);plot(data.rt_tout,filtAccel(2,:))
    xlabel('Time (sec)');ylabel('Accel (m/s2)');
    title(['Y Linear Acceleration, Case: ' num2str(i)])  
    
    figure;
    plot(data.rt_tout,filtRate(3,:)./d2r)
    xlabel('Time (sec)');ylabel('Rate (deg/s)');
    title(['Rotational Rate, Case:' num2str(i)])
    
%     thrusterCmds = squeeze(data.rt_yout.signals(1).values(1,:,:))';
%     figure;
%     subplot(4,1,1);plot(data.rt_tout,thrusterCmds(:,1))
%     title(['Thruster 1, Case: ' num2str(i)]);xlabel('Time (sec)');ylabel('Cmd (--)')
%     subplot(4,1,2);plot(data.rt_tout,thrusterCmds(:,2))
%     title('Thruster 2');xlabel('Time (sec)');ylabel('Cmd (--)')
%     subplot(4,1,3);plot(data.rt_tout,thrusterCmds(:,3))
%     title('Thruster 3');xlabel('Time (sec)');ylabel('Cmd (--)')
%     subplot(4,1,4);plot(data.rt_tout,thrusterCmds(:,4))
%     title('Thruster 4');xlabel('Time (sec)');ylabel('Cmd (--)')
%     
%     figure;
%     subplot(4,1,1);plot(data.rt_tout,thrusterCmds(:,5))
%     title(['Thruster 5, Case: ' num2str(i)]);xlabel('Time (sec)');ylabel('Cmd (--)')
%     subplot(4,1,2);plot(data.rt_tout,thrusterCmds(:,6))
%     title('Thruster 6');xlabel('Time (sec)');ylabel('Cmd (--)')
%     subplot(4,1,3);plot(data.rt_tout,thrusterCmds(:,7))
%     title('Thruster 7');xlabel('Time (sec)');ylabel('Cmd (--)')
%     subplot(4,1,4);plot(data.rt_tout,thrusterCmds(:,8))
%     title('Thruster 8');xlabel('Time (sec)');ylabel('Cmd (--)')
end


return
% npts = 2000;
% iAccel(1) = mean(data1.rt_yout.signals(2).values(1:npts/2,1));
% iAccel(2) = mean(data2.rt_yout.signals(2).values(1:npts/2,1));
% iAccel(3) = mean(data3.rt_yout.signals(2).values(1:npts/2,2));
% iAccel(4) = mean(data4.rt_yout.signals(2).values(1:npts/2,2));
% iRate(5) =  data5.rt_yout.signals(2).values(npts/2,6);
% iRate(6) =  data6.rt_yout.signals(2).values(npts/2,6);
% sPt = npts/2;
% ePt = sPt+npts/10;
% tAccel(1) = mean(data1.rt_yout.signals(2).values(sPt:ePt,1));
% tAccel(2) = mean(data2.rt_yout.signals(2).values(sPt:ePt,1));
% tAccel(3) = mean(data3.rt_yout.signals(2).values(sPt:ePt,2));
% tAccel(4) = mean(data4.rt_yout.signals(2).values(sPt:ePt,2));
% fRate(5) =  data5.rt_yout.signals(2).values(ePt,6);
% fRate(6) =  data6.rt_yout.signals(2).values(ePt,6);
% dAccel = tAccel-iAccel;
% dRate = fRate-iRate;

% thrust = dAccel*g2mpss*m;
% angAccel = dRate*d2r/1;
% moment = Izz*angAccel;
% force = moment/(width/2);

% return
% data=data6;
% thrusterCmds = squeeze(data.rt_yout.signals(1).values(1,:,:))';
% sensorData = data.rt_yout.signals(2).values


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

% figure;
% subplot(3,1,1);plot(data.rt_tout,sensorData(:,1))
% 
% title('X Axis Acceleration');xlabel('Time (sec)');ylabel('Accel (g''s)');
% subplot(3,1,2);plot(data.rt_tout,sensorData(:,2))
% title('Y Axis Acceleration');xlabel('Time (sec)');ylabel('Accel (g''s)');
% subplot(3,1,3);plot(data.rt_tout,sensorData(:,3))
% title('Z Axis Acceleration');xlabel('Time (sec)');ylabel('Accel (g''s)');
% 
% figure;
% subplot(3,1,1);plot(data.rt_tout,sensorData(:,4))
% title('X Axis Angular Rate');xlabel('Time (sec)');ylabel('Rate (deg/s)');
% subplot(3,1,2);plot(data.rt_tout,sensorData(:,5))
% title('Y Axis Angular Rate');xlabel('Time (sec)');ylabel('Rate (deg/s)');
% subplot(3,1,3);plot(data.rt_tout,sensorData(:,6))
% title('Z Axis Angular Rate');xlabel('Time (sec)');ylabel('Rate (deg/s)');