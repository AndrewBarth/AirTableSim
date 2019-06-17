
% time   = sensedRate.Time;
% signal = squeeze(sensedRate.Data(1,1,:));
% signal = squeeze(sensedAccel.Data(1,1,:));

gyrotest1 = load('gyroTest1.csv','-ascii');
gyrotest2 = load('gyroTest2.csv','-ascii');
gyrotest3 = load('gyroTest3.csv','-ascii');
gyrotest4 = load('gyroTest4.csv','-ascii');

time = gyrotest1(:,1)/1000;
signal = gyrotest1(:,6);


npts = length(time);
Fs = round(1/((time(end)-time(1))/npts));  % Hz

figure;plot(time,signal);

ff = fft(signal);

% fft is a two-sided spectrum, convert to single sided
p2 = abs(ff/npts);
p1 = p2(1:npts/2+1);
p1(2:end-1) = 2*p1(2:end-1);

% form vector of frequencies
freq = Fs*(0:(npts/2))/npts;

% plot the amplitude spectrum
figure;plot(freq,p1)

fc = 1.0;
% fc = 10;
[b,a] = butter(2,fc/(Fs/2));

fsignal = filter(b,a,signal);
fsignal1 = filtfilt(b,a,signal);

figure;
plot(time,signal); hold all;
plot(time,fsignal);
plot(time,fsignal1);
title('The filtered signal');
legend('Signal','Filtered Signal');

% Fs = 1000;            % Sampling frequency                    
% T = 1/Fs;             % Sampling period       
% L = 1500;             % Length of signal
% t = (0:L-1)*T;        % Time vector
% 
% S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
% X = S + 2*randn(size(t));
% 
% figure;
% plot(1000*t(1:50),X(1:50))
% title('Signal Corrupted with Zero-Mean Random Noise')
% xlabel('t (milliseconds)')
% ylabel('X(t)')
% hold all;
% plot(1000*t(1:50),S(1:50))
% legend('Noisy Signal','Original Signal')
% 
% Y = fft(X);
% P2 = abs(Y/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% 
% f = Fs*(0:(L/2))/L;
% figure;
% plot(f,P1) 
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')