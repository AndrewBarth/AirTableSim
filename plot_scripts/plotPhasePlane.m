

rtd = 180/pi;

drift_channel_db    = PPGains(9)*rtd;
drift_channel_rate  = PPGains(10)*rtd;
drift_channel_width = PPGains(11)*rtd; 


deadzone_slope = (2*drift_channel_rate + drift_channel_width) / (2*drift_channel_db);
zero_cross = (drift_channel_db - 0)*deadzone_slope + (-1*drift_channel_rate);
upper_line_x = [-90 -1*drift_channel_db*5 -1*drift_channel_db 0 drift_channel_db drift_channel_db*5 90];
upper_line_y = [drift_channel_rate+drift_channel_width drift_channel_rate+drift_channel_width drift_channel_rate+drift_channel_width ...
                zero_cross -1*drift_channel_rate -1*drift_channel_rate -1*drift_channel_rate];
lower_line_x = upper_line_x;
lower_line_y = upper_line_y - drift_channel_width;
figure;hold all;
plot(upper_line_x,upper_line_y,'b',lower_line_x,lower_line_y,'b')
plot(controlErrorBody.Data(:,6)*rtd,controlErrorBody.Data(:,12)*rtd,'r')