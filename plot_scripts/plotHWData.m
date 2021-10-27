
close all;
% data1=load('Top6DOFModel_1_1.mat');
% data1=load('testUDP_1_1.mat');
data1=load('ThrusterTest_1_1.mat');
reference = 0;
control = 0;


filtSens  = squeeze(data1.rt_yout.signals(2).values(1,:,:));
rawSens   = data1.rt_yout.signals(3).values;

filtAccel = filtSens(1:3,:);
filtRate  = filtSens(4:6,:)*180/pi;
trackPos  = filtSens(15:17,:);
trackAng  = filtSens(18:20,:)*180/pi;
trackVel  = filtSens(21:23,:);
rawPos    = rawSens(:,15:17);
rawAng    = rawSens(:,18:20);

thrusterCmds = data1.rt_yout.signals(1).values;
% thrusterCmds = squeeze(data1.rt_yout.signals(1).values(1,:,:))';
 
if reference
    refTraj = squeeze(data1.rt_yout.signals(7).values(:,:,1));
end
if control
    controlError = data1.rt_yout.signals(8).values;
    controlSignal = data1.rt_yout.signals(10).values;
end

figure;subplot(2,1,1);plot(data1.rt_tout,filtAccel(1:2,:))
legend('x','y');xlabel('Time (s)');ylabel('Linear Acceleration (m/s^2)')
title('Filtered Acceleration');
subplot(2,1,2);plot(data1.rt_tout,filtAccel(3,:))
xlabel('Time (s)');ylabel('Linear Acceleration (m/s^2)')
title('Z Acceleration');

figure;plot(data1.rt_tout,filtRate(:,:))
legend('x','y','z');xlabel('Time (s)');ylabel('Angular Rate (deg/s)')
title('Filtered Rates');

% figure;plot(data1.rt_tout,squeeze(data1.rt_yout.signals(2).values(1,11:13,:)))
% legend('x','y','z');xlabel('Time (s)');ylabel('Mag Field (Gauss)')
% title('Magnetic Field Vector');

% figure;plot(data1.rt_tout,squeeze(data1.rt_yout.signals(2).values(1,7:10,:)))
% legend('1','2','3','4');xlabel('Time (s)');ylabel('Range (m)')
% title('Range Data');
% 
% figure;plot(data1.rt_tout,squeeze(data1.rt_yout.signals(3).values(:,7:10)))
% legend('1','2','3','4');xlabel('Time (s)');ylabel('Range (mm)')
% title('Raw Range Data');

npts = size(data1.rt_tout,1);
% clear angle rotAngle
% for i = 1:npts
%     angle(i) = atan2(data1.rt_yout.signals(2).values(1,12,i),data1.rt_yout.signals(2).values(1,11,i));
%     rotAngle(i) = -84*pi/180 - angle(i);
% end
% figure;subplot(2,1,1);plot(data1.rt_tout,angle*180/pi);
%        title('SensedAngle')
%        subplot(2,1,2);plot(data1.rt_tout,rotAngle*180/pi);
%        title('RotationAngle')

% if exist('filteredRate','var')
Tvel(1,:) = [0 0];
dt = data1.rt_tout(2) - data1.rt_tout(1);

for i = 2:npts
    Tvel(i,1) = (data1.rt_yout.signals(2).values(1,15,i) - data1.rt_yout.signals(2).values(1,15,i-1))/dt;
    Tvel(i,2) = (data1.rt_yout.signals(2).values(1,16,i) - data1.rt_yout.signals(2).values(1,16,i-1))/dt;
end
    


figure;subplot(3,1,1);plot(data1.rt_tout,trackPos(1,:)); hold all;
xlabel('Time (s)');ylabel('Position (m)');
if reference
    plot(refTraj(:,1),refTraj(:,2));
    legend('Tracked','Reference')
else
    legend('Tracked')
end
title('Filtered Tracker X Position');
subplot(3,1,2);plot(data1.rt_tout,trackPos(2,:)); hold all;
xlabel('Time (s)');ylabel('Position (m)');
if reference
    plot(refTraj(:,1),refTraj(:,3));
    legend('Tracked','Reference')
else
    legend('Tracked')
end
title('Filtered Tracker Y Position');
subplot(3,1,3);plot(trackPos(1,:),trackPos(2,:)); hold all;
xlabel('X Position (m)');ylabel('Y Position (m)')
if reference 
    plot(refTraj(:,2),refTraj(:,3));
    legend('Tracked','Reference')
else
    legend('Tracked')
end
title('Tracker Trajectory')

figure;plot(data1.rt_tout,trackAng(3,:)); hold all;
xlabel('Time (s)');ylabel('Angle (deg)');
if reference
    plot(refTraj(:,1),refTraj(:,7)*180/pi);
    legend('Tracked','Reference')
else
    legend('Tracked')
end
title('Filtered Tracker Rotation Angle');

figure;subplot(2,1,1);plot(data1.rt_tout,trackVel(1,:));
xlabel('Time (s)');ylabel('Velocity (m/s)');
legend('Integrated');
title('X Velocity');
subplot(2,1,2);plot(data1.rt_tout,trackVel(2,:));
xlabel('Time (s)');ylabel('Velocity (m/s)');
legend('Integrated');
title('Y Velocity');

figure;subplot(2,1,1);plot(data1.rt_tout,rawPos(:,1));
xlabel('Time (s)');ylabel('Position (mm)');
title('Raw Tracker X Position');
subplot(2,1,2);plot(data1.rt_tout,rawPos(:,2));
xlabel('Time (s)');ylabel('Position (mm)');
title('Raw Tracker Y Position');

figure;plot(data1.rt_tout,rawAng(:,3));
xlabel('Time (s)');ylabel('Angle (deg)');
title('Raw Tracker Rotation Angle');


if control
    figure;
    subplot(3,1,1);plot(data1.rt_tout,controlError(:,1))
    title('X Position Error');xlabel('Time (sec)');ylabel('Pos Error (m)');
    subplot(3,1,2);plot(data1.rt_tout,controlError(:,2))
    title('Y Position Error');xlabel('Time (sec)');ylabel('Pos Error (m)');
    subplot(3,1,3);plot(data1.rt_tout,controlError(:,6)*180/pi)
    title('Angular Error');xlabel('Time (sec)');ylabel('Ang Error (deg)');

    figure;plot(data1.rt_tout,controlError(:,12)*180/pi)
    title('Angular Rate Error');xlabel('Time (sec)');ylabel('Ang Rate Error (deg/s)');


    figure;
    subplot(3,1,1);plot(data1.rt_tout,controlSignal(:,1))
    title('X Control Signal');xlabel('Time (sec)');ylabel('Pos Signal ()');
    subplot(3,1,2);plot(data1.rt_tout,controlSignal(:,2))
    title('Y Control Signal');xlabel('Time (sec)');ylabel('Pos Signal ()');
    subplot(3,1,3);plot(data1.rt_tout,controlSignal(:,6))
    title('Angular Control Signal');xlabel('Time (sec)');ylabel('Ang Signal ()');

end

figure;
subplot(4,1,1);plot(data1.rt_tout,thrusterCmds(:,1))
title('Thruster 1');xlabel('Time (sec)');ylabel('Cmd (--)')
subplot(4,1,2);plot(data1.rt_tout,thrusterCmds(:,2))
title('Thruster 2');xlabel('Time (sec)');ylabel('Cmd (--)')
subplot(4,1,3);plot(data1.rt_tout,thrusterCmds(:,3))
title('Thruster 3');xlabel('Time (sec)');ylabel('Cmd (--)')
subplot(4,1,4);plot(data1.rt_tout,thrusterCmds(:,4))
title('Thruster 4');xlabel('Time (sec)');ylabel('Cmd (--)')

figure;
subplot(4,1,1);plot(data1.rt_tout,thrusterCmds(:,5))
title('Thruster 5');xlabel('Time (sec)');ylabel('Cmd (--)')
subplot(4,1,2);plot(data1.rt_tout,thrusterCmds(:,6))
title('Thruster 6');xlabel('Time (sec)');ylabel('Cmd (--)')
subplot(4,1,3);plot(data1.rt_tout,thrusterCmds(:,7))
title('Thruster 7');xlabel('Time (sec)');ylabel('Cmd (--)')
subplot(4,1,4);plot(data1.rt_tout,thrusterCmds(:,8))
title('Thruster 8');xlabel('Time (sec)');ylabel('Cmd (--)')