
dtr = pi/180;

% Kp = [100 100 0 0 0 30];
% Kd = [200 200 0 0 0 10];
% Ki = [0 0 0 0 0 0];
% 
% Kp = [90.0275  148.5641 0 0 0 41.2792];
% Kd = [99.8064   99.8232 0 0 0 14.3925];
% Ki = [12.5056   23.2486 0 0 0 1.9867];

Kp = [70 70 0 0 0 20];
Kd = [80 80 0 0 0 5];
Ki = [4  4  0 0 0  1];

Kp = [70 70 0 0 0 20].*[.2 .2  0 0 0 .25];
Kd = [80 80 0 0 0 5] .*[.2 .2  0 0 0 .1];
Ki = [4  4  0 0 0 1] .*[1   1  0 0 0 0];

Kp = [70 70 0 0 0 20].*[.2 .2  0 0 0 .25];
Kd = [80 80 0 0 0 5] .*[.2 .2  0 0 0 .1];
Ki = [4  4  0 0 0 1] .*[1   1  0 0 0 .5];

Kp = [14 14 0 0 0 5];
Kd = [16 16 0 0 0 0.5];
Ki = [4  4  0 0 0 0.5];

Kp = [14 14 0 0 0 2];
Kd = [16 16 0 0 0 1.3];
Ki = [4  4  0 0 0 0.0];
% 
% Kp = [70 70   0 0 0 20]*.01;
% Kd = [80 80 0 0 0 5]*.1;
% Ki = [4  4  0 0 0  1]*.01;
% Kp = [500.0000  246.1321 0 0 0 50.1701];
% Kd = [500.0000  501.0938 0 0 0 18.4778];
% Ki = [1.0000    1.0313   0 0 0 58.1181];

% Kp = [23.0083  241.1549 0 0 0 20.0000];
% Kd = [500.0000 331.8547 0 0 0  8.0000];
% Ki = [1.0000    0.5000  0 0 0  0];
% Kp = [50.0  50.0 0 0 0  10.0000];
% Kd = [130.0 130.0 0 0 0  5.0000];
% Ki = [0 0 0 0 0 0];

% Kp = [50.0000  155.9614  0   0 0 48.6550];
% Kd = [131.0000  130.0000 0   0 0  5.0000];
% Ki = [  1.0000    1.0000 0   0 0  0];

% SMGains = [2 2 2 2 2 4 1];
% SMGains = [1.6264    1.5585    4.8510    8.0133    1.6984    4.8066    1.2611];
% SMGains = [2.0801    3.0489    8.9333    4.9881    3.0029    9.5293    0.6944    2.9403    3.0662];
SMGains = [3.5078    3.9888    6.3119    1.8214    4.7749    7.3059    3.6553    1.9774    4.3207];
% SMGains = [1 1 2 1 1 1 1 1 1];
% SMGains = [2 2 12 2 2 1 1 1 10];
% SMGains = [8.6506    4.1815    6.1690    9.8805    6.3439    0.1717    1.0000   13.0080   10.0000];


%% Gains for Phase Plane controller

% X Translation channel
drift_channel_db = 0.1;
drift_channel_rate = 0.01;
drift_channel_width = 0.05;
max_cmd = 100.0;

PPGains = [drift_channel_db drift_channel_rate drift_channel_width max_cmd];

% Y Translation channel
drift_channel_db = 0.1;
drift_channel_rate = 0.01;
drift_channel_width = 0.05;
max_cmd = 100.0;

PPGains = [PPGains drift_channel_db drift_channel_rate drift_channel_width max_cmd];

% Attitude channel
% drift_channel_db = 5*dtr;
% drift_channel_rate = 0.1*dtr;
% drift_channel_width = 0.5 *dtr;
drift_channel_db = 7*dtr;
drift_channel_rate = 0.5*dtr;
drift_channel_width = 1.2 *dtr;
max_cmd = 100.0;

PPGains = [PPGains drift_channel_db drift_channel_rate drift_channel_width max_cmd];