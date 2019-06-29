
data1=load('Top6DOFModel_1_1.mat');


figure;subplot(2,1,1);plot(data1.rt_tout,squeeze(data1.rt_yout.signals(2).values(1,1:2,:)))
legend('x','y');xlabel('Time (s)');ylabel('Linear Acceleration (m/s^2)')
title('Filtered Acceleration');
subplot(2,1,2);plot(data1.rt_tout,squeeze(data1.rt_yout.signals(2).values(1,3,:)))

figure;plot(data1.rt_tout,squeeze(data1.rt_yout.signals(2).values(1,4:6,:)))
legend('z');xlabel('Time (s)');ylabel('Angular Rate (rad/s)')
title('Filtered Rates');

figure;plot(data1.rt_tout,squeeze(data1.rt_yout.signals(2).values(1,11:13,:)))
legend('x','y','z');xlabel('Time (s)');ylabel('Mag Field (Gauss)')
title('Magnetic Field Vector');

npts = size(data1.rt_tout,1);
for i = 1:npts
    angle(i) = atan2(data1.rt_yout.signals(2).values(1,12,i),data1.rt_yout.signals(2).values(1,11,i));
    rotAngle(i) = -84*pi/180 - angle(i);
end
figure;subplot(2,1,1);plot(data1.rt_tout,angle*180/pi);
       title('SensedAngle')
       subplot(2,1,2);plot(data1.rt_tout,rotAngle*180/pi);
       title('RotationAngle')

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