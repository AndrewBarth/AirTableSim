
% Clear persistent states
clear imuFilter
clear eml_IIR_Filter

clear newrate newrate2

time = sensedRate.Time;
xrate = squeeze(sensedRate.Data(1,1,:));
npts = length(time);
% npts = 5;

b = [0.2462e-5 0.4924e-5 0.2462e-5];
a = [1.0000   -1.9956    0.9956];
for i = 1:npts
    newrate(i) = imuFilter(xrate(i));
    newrate2(i) = eml_IIR_Filter(xrate(i) , 1 , b , a , 0); 
end

figure;plot(time(1:npts),xrate(1:npts),time(1:npts),newrate(1:npts));legend('orig','filtered')
    
