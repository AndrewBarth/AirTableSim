% script to test the image processing function

clear; close all; clc;

storage = {};
rangeTable = [2500 5000];
range = 2.5;   % m

% camObj = webcam('Logitech HD Webcam C310');
% imgO = snapshot(camObj);
% imshow(imgO)
% imaqhwinfo

adaptorname = 'winvideo';
camObj = imaq.VideoDevice(adaptorname);
% camObj = imaq.VideoDevice('winvideo');

while true
[theta,BW,imgO,x,quality] = imageProcess(camObj,range,rangeTable);

    subplot(2,1,1)
    imshow(BW);
    subplot(2,1,2)
    imshow(imgO);
    
    storage=[storage; {x,theta}];
    
    x
    theta
end