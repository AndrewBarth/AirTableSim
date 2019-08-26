
data1=load('Top6DOFModel_3_1.mat');


figure;subplot(2,1,1);plot(data1.rt_tout,squeeze(data1.rt_yout.signals(2).values(1,1:2,:)))
legend('x','y');xlabel('Time (s)');ylabel('Linear Acceleration (m/s^2)')
title('Filtered Acceleration');
subplot(2,1,2);plot(data1.rt_tout,squeeze(data1.rt_yout.signals(2).values(1,3,:)))
xlabel('Time (s)');ylabel('Linear Acceleration (m/s^2)')
title('Z Acceleration');

figure;plot(data1.rt_tout,squeeze(data1.rt_yout.signals(2).values(1,4:6,:)))
legend('x','y','z');xlabel('Time (s)');ylabel('Angular Rate (rad/s)')
title('Filtered Rates');

figure;plot(data1.rt_tout,squeeze(data1.rt_yout.signals(2).values(1,11:13,:)))
legend('x','y','z');xlabel('Time (s)');ylabel('Mag Field (Gauss)')
title('Magnetic Field Vector');

figure;plot(data1.rt_tout,squeeze(data1.rt_yout.signals(2).values(1,7:10,:)))
legend('1','2','3','4');xlabel('Time (s)');ylabel('Range (m)')
title('Range Data');

figure;plot(data1.rt_tout,squeeze(data1.rt_yout.signals(3).values(:,7:10)))
legend('1','2','3','4');xlabel('Time (s)');ylabel('Range (mm)')
title('Raw Range Data');

npts = size(data1.rt_tout,1);
clear angle rotAngle
for i = 1:npts
    angle(i) = atan2(data1.rt_yout.signals(2).values(1,12,i),data1.rt_yout.signals(2).values(1,11,i));
    rotAngle(i) = -84*pi/180 - angle(i);
end
figure;subplot(2,1,1);plot(data1.rt_tout,angle*180/pi);
       title('SensedAngle')
       subplot(2,1,2);plot(data1.rt_tout,rotAngle*180/pi);
       title('RotationAngle')

% if exist('filteredRate','var')
Tvel(1,:) = [0 0];
dt = data1.rt_tout(2) - data1.rt_tout(1);

for i = 2:npts
    Tvel(i,1) = (data1.rt_yout.signals(2).values(1,15,i) - data1.rt_yout.signals(2).values(1,15,i-1))/dt;
    Tvel(i,2) = (data1.rt_yout.signals(2).values(1,16,i) - data1.rt_yout.signals(2).values(1,16,i-1))/dt;
end
    


figure;subplot(3,1,1);plot(data1.rt_tout,squeeze(data1.rt_yout.signals(2).values(1,15,:)),squeeze(data1.rt_yout.signals(8).values(1:6,1,1)),squeeze(data1.rt_yout.signals(8).values(1:6,2,1)));
xlabel('Time (s)');ylabel('Position (m)');
legend('Tracked','Reference')
title('Filtered Tracker X Position');
subplot(3,1,2);plot(data1.rt_tout,squeeze(data1.rt_yout.signals(2).values(1,16,:)),squeeze(data1.rt_yout.signals(8).values(1:6,1,1)),squeeze(data1.rt_yout.signals(8).values(1:6,3,1)));
xlabel('Time (s)');ylabel('Position (m)');
legend('Tracked','Reference')
title('Filtered Tracker Y Position');
subplot(3,1,3);plot(squeeze(data1.rt_yout.signals(2).values(1,15,:)),squeeze(data1.rt_yout.signals(2).values(1,16,:)),squeeze(data1.rt_yout.signals(8).values(1:6,2,1)),squeeze(data1.rt_yout.signals(8).values(1:6,3,1)));
xlabel('X Position (m)');ylabel('Y Position (m)')
legend('Tracked','Reference')
title('Tracker Trajectory')

figure;plot(data1.rt_tout,squeeze(data1.rt_yout.signals(2).values(1,20,:)*180/pi),squeeze(data1.rt_yout.signals(8).values(1:6,1,1)),squeeze(data1.rt_yout.signals(8).values(1:6,7,1)));
xlabel('Time (s)');ylabel('Angle (deg)');
legend('Tracked','Reference')
title('Filtered Tracker Rotation Angle');

% figure;subplot(2,1,1);plot(data1.rt_tout,Tvel(:,1),data1.rt_tout,squeeze(data1.rt_yout.signals(7).values(1,1,:)));
% xlabel('Time (s)');ylabel('Velocity (m/s)');
% legend('Tracked','Integrated');
% title('X Velocity');
% subplot(2,1,2);plot(data1.rt_tout,Tvel(:,2),data1.rt_tout,squeeze(data1.rt_yout.signals(7).values(1,2,:)));
% xlabel('Time (s)');ylabel('Velocity (m/s)');
% legend('Tracked','Integrated');
% title('Y Velocity');

figure;subplot(2,1,1);plot(data1.rt_tout,squeeze(data1.rt_yout.signals(3).values(:,15)));
xlabel('Time (s)');ylabel('Position (m)');
title('Raw Tracker X Position');
subplot(2,1,2);plot(data1.rt_tout,squeeze(data1.rt_yout.signals(3).values(:,16)));
xlabel('Time (s)');ylabel('Position (m)');
title('Raw Tracker Y Position');

figure;plot(data1.rt_tout,squeeze(data1.rt_yout.signals(3).values(:,20)));
xlabel('Time (s)');ylabel('Angle (deg)');
title('Raw Tracker Rotation Angle');

thrusterCmds = data1.rt_yout.signals(1).values;

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