% Raspberrypi_MAT_stitcher(dir('Top6DOFModel_1_*.mat'));
% Raspberrypi_MAT_stitcher(dir('Top6DOFModel_2_*.mat'));
% Raspberrypi_MAT_stitcher(dir('Top6DOFModel_3_*.mat'));
% Raspberrypi_MAT_stitcher(dir('Top6DOFModel_4_*.mat'));
% Raspberrypi_MAT_stitcher(dir('Top6DOFModel_5_*.mat'));
% Raspberrypi_MAT_stitcher(dir('Top6DOFModel_6_*.mat'));

clear data

% data1=load('Top6DOFModel_1__stitched.mat');
% data2=load('Top6DOFModel_2__stitched.mat');
% data3=load('Top6DOFModel_3__stitched.mat');
% data4=load('Top6DOFModel_4__stitched.mat');
% data5=load('Top6DOFModel_5__stitched.mat');
% data6=load('Top6DOFModel_6__stitched.mat');


% Compute offset
xAccel1 = mean(squeeze(data1.rt_yout.signals(2).values(1,1,:)));
xAccel2 = mean(squeeze(data2.rt_yout.signals(2).values(1,1,:)));
yAccel1 = mean(squeeze(data1.rt_yout.signals(2).values(1,2,:)));
yAccel2 = mean(squeeze(data2.rt_yout.signals(2).values(1,2,:)));
zAccel1 = mean(squeeze(data1.rt_yout.signals(2).values(1,3,:)));
zAccel2 = mean(squeeze(data2.rt_yout.signals(2).values(1,3,:)));
Accel = [mean([xAccel1 xAccel2]); mean([yAccel1 yAccel2]); mean([zAccel1 zAccel2])];
uAccel = Accel / norm(Accel);
planarAccel = [0 0 -1]';
rotAxis = cross(uAccel,planarAccel)/norm(cross(uAccel,planarAccel));
rotAngle = acos(dot(uAccel,planarAccel));

rotMat = rotAxis*rotAxis' + (eye(3,3) - rotAxis*rotAxis')*cos(rotAngle) + skewMat(rotAxis)*sin(rotAngle)
rotEuler = DCMToEuler_321(rotMat)

rawAccelx = data1.rt_yout.signals(3).values(:,1);
rawAccely = data1.rt_yout.signals(3).values(:,2);
rawAccelz = data1.rt_yout.signals(3).values(:,3);
fullRot = ZRot(pi)*M_IMU_To_Body;

for i=1:size(rawAccelx,1)
    newAccel(i,:) = rotMat*[rawAccelx(i); rawAccely(i); rawAccelz(i)];
    newAccel2(i,:) = M_IMU_To_Body*[rawAccelx(i); rawAccely(i); rawAccelz(i)];
    newAccel3(i,:) = fullRot*[rawAccelx(i); rawAccely(i); rawAccelz(i)];
end
%  return

data=data1;
thrusterCmds = squeeze(data.rt_yout.signals(1).values(1,:,:))';
sensorData = squeeze(data.rt_yout.signals(2).values(1,:,:))';

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
