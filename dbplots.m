
% figure;plot(stateOutECEF.Time,stateOutECEF.Data(:,6)*180/pi,stateOutECEF2.Time,stateOutECEF2.Data(:,6)*180/pi);legend('1','2')
% figure; plot(controlMoment.Time,controlMoment.Data(:,3),controlMoment2.Time,controlMoment2.Data(:,3));legend('contw 1','contw 2')

figure;plotyy(stateOutECEF.Time,stateOutECEF.Data(:,1:2),stateOutECEF.Time,stateOutECEF.Data(:,3));legend('vx','vy','w');title('Velocity/Rate')
figure;plotyy(stateOutECEF.Time,stateOutECEF.Data(:,4:5),stateOutECEF.Time,stateOutECEF.Data(:,6)*180/pi);legend('x','y','theta');title('Position/Theta')
figure;plot(controlMoment.Time,controlMoment.Data);legend('x','y','w');title('Control Moment')

figure;plot(thrusterOut.Time,thrusterOut.Data(:,1),thrusterOut2.Time,thrusterOut2.Data(:,1));legend('x 1','x 2');title('X Force')
figure;plot(thrusterOut.Time,thrusterOut.Data(:,2),thrusterOut2.Time,thrusterOut2.Data(:,2));legend('y 1','y 2');title('Y Force')
figure;plot(thrusterOut.Time,thrusterOut.Data(:,3),thrusterOut2.Time,thrusterOut2.Data(:,3));legend('w 1','w 2');title('Z Moment')

figure;plot(thrusterOnTimes.Time,thrusterOnTimes.Data(:,1),thrusterOnTimes2.Time,thrusterOnTimes2.Data(:,1));title('Jet 1');legend('1','2')
figure;plot(thrusterOnTimes.Time,thrusterOnTimes.Data(:,2),thrusterOnTimes2.Time,thrusterOnTimes2.Data(:,2));title('Jet 2');legend('1','2')
figure;plot(thrusterOnTimes.Time,thrusterOnTimes.Data(:,3),thrusterOnTimes2.Time,thrusterOnTimes2.Data(:,3));title('Jet 3');legend('1','2')
figure;plot(thrusterOnTimes.Time,thrusterOnTimes.Data(:,4),thrusterOnTimes2.Time,thrusterOnTimes2.Data(:,4));title('Jet 4');legend('1','2')
figure;plot(thrusterOnTimes.Time,thrusterOnTimes.Data(:,5),thrusterOnTimes2.Time,thrusterOnTimes2.Data(:,5));title('Jet 5');legend('1','2')
figure;plot(thrusterOnTimes.Time,thrusterOnTimes.Data(:,6),thrusterOnTimes2.Time,thrusterOnTimes2.Data(:,6));title('Jet 6');legend('1','2')
figure;plot(thrusterOnTimes.Time,thrusterOnTimes.Data(:,7),thrusterOnTimes2.Time,thrusterOnTimes2.Data(:,7));title('Jet 7');legend('1','2')
figure;plot(thrusterOnTimes.Time,thrusterOnTimes.Data(:,8),thrusterOnTimes2.Time,thrusterOnTimes2.Data(:,8));title('Jet 8');legend('1','2')

