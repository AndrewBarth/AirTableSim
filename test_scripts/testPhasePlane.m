
dtr = pi/180;

drift_channel_db = 5*dtr;
drift_channel_rate = 0.1*dtr;
drift_channel_width = 0.5 *dtr;
max_cmd = 1.0;

att = -10*dtr:.05*dtr:10*dtr;
rate = -2*dtr:.01*dtr:2*dtr;

cmdOut = zeros(length(att),length(rate));

for  i=1:length(att)
    att_err = att(i);
    for j=1:length(rate)
        rate_err = rate(j);
        if att_err == 0 && rate_err == 0
            disp('zeros')
        end
        [cmdOut(i,j)] = phasePlaneControl(att_err,rate_err,drift_channel_db,drift_channel_rate, ...
                                     drift_channel_width, max_cmd);
                                 
    end
end

[x,y]=find(cmdOut~=0);
figure;plot(att(x)./dtr,rate(y)./dtr,'x')