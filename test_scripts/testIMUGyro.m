
% This was a test of the IMU placed on a spinning chair. Rotation times
% were manually recorded based on looking at a video from the test

% Test 1
clear videoTimes offsetTime timeVec nRot rotTime rotRate
videoTimes = [7.4 9.0 10.4 12.1 14.4 17.4];
nRot = size(videoTimes,2)-1;
for i = 1:nRot
    rotTime(i) = videoTimes(i+1)-videoTimes(i);
    rotRate(i) = 360/rotTime(i);
end
offsetTime = videoTimes(1) - 0.45;
timeVec = videoTimes - offsetTime;
test1 = load('gyroTest1.csv','-ascii');
figure;plot(test1(:,1)./1000,test1(:,2:4));legend('x','y','z');title('Acceleration Test 1')
figure;plot(test1(:,1)./1000,test1(:,5:7));legend('x','y','z');title('Rate Test 1'); hold all
plot(timeVec,[rotRate(1) rotRate]);

% Test 2
clear videoTimes offsetTime timeVec nRot rotTime rotRate
videoTimes = [6.5 8.5 10.2 11.8 13.4 15.1 16.7 18.3 20.0 21.7 23.4 25.1 26.8 28.5 30.3 32.3];
nRot = size(videoTimes,2)-1;
for i = 1:nRot
    rotTime(i) = videoTimes(i+1)-videoTimes(i);
    rotRate(i) = 360/rotTime(i);
end
offsetTime = videoTimes(1) - 0.4;
timeVec = videoTimes - offsetTime;
test2 = load('gyroTest2.csv','-ascii');
figure;plot(test2(:,1)./1000,test2(:,2:4));legend('x','y','z');title('Acceleration Test 2')
figure;plot(test2(:,1)./1000,test2(:,5:7));legend('x','y','z');title('Rate Test 2'); hold all
plot(timeVec,[rotRate(1) rotRate]);

% Test 3
clear videoTimes offsetTime timeVec nRot rotTime rotRate
videoTimes = [8.4 13.1 17.3 23.8 28.7 31.9 36.6 41.4 46.4 51.4 55.1];
nRot = size(videoTimes,2)-1;
signs = [-1 -1 -1 1 1 1 1 -1 -1 -1];
for i = 1:nRot
    rotTime(i) = videoTimes(i+1)-videoTimes(i);
    rotRate(i) = 180/rotTime(i)*signs(i);
end
offsetTime = videoTimes(1) - 0.55;
timeVec = videoTimes - offsetTime;
test3 = load('gyroTest3.csv','-ascii');
figure;plot(test3(:,1)./1000,test3(:,2:4));legend('x','y','z');title('Acceleration Test 3')
figure;plot(test3(:,1)./1000,test3(:,5:7));legend('x','y','z');title('Rate Test 3'); hold all
plot(timeVec,[rotRate(1) rotRate]);

% Test 4
clear videoTimes offsetTime timeVec nRot rotTime rotRate
videoTimes = [6.8 11.2 16.7 23.8 30.2 35.9 42.5 51.5 59.9];
nRot = size(videoTimes,2)-1;
for i = 1:nRot
    rotTime(i) = videoTimes(i+1)-videoTimes(i);
    rotRate(i) = -360/rotTime(i);
end
offsetTime = videoTimes(1) - 0.45;
timeVec = videoTimes - offsetTime;
test4 = load('gyroTest4.csv','-ascii');
figure;plot(test4(:,1)./1000,test4(:,2:4));legend('x','y','z');title('Acceleration Test 4')
figure;plot(test4(:,1)./1000,test4(:,5:7));legend('x','y','z');title('Rate Test 4'); hold all
plot(timeVec,[rotRate(1) rotRate]);