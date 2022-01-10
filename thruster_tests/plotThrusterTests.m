

nCase = 30;
% nCase = 15;
% nCase = 1;


clear alldata data
for i = 1:nCase
    outFile = strcat('ThrusterTest_',int2str(i),'_*.mat');
    Raspberrypi_MAT_stitcher(dir(outFile));
    
    stFile = strcat('ThrusterTest_',int2str(i),'__stitched.mat');
    alldata{i} = load(stFile);

end


% Define type of test (1: X trans, 2: Y trans, 3: rot)
type = [1 1 2 2 3 3 ...
        2 2 3 3 1 1 ...
        1 1 2 2 3 3 ...
        1 1 2 2 3 3 ...
        1 1 2 2 3 3];
% firing_duration = [0.2 0.2 0.2 0.2 0.2 0.2 ...
%                    0.5 0.5 0.5 0.5 0.5 0.5 ...
%                    0.5 0.5 0.5 0.5 0.5 0.5 ...
%                    0.5 0.5 0.5 0.5 0.5 0.5 ...
%                    0.5 0.5 0.5 0.5 0.5 0.5];
firing_duration = [0.5 0.5 0.5 0.5 0.5 0.5 ...
                   1.0 1.0 1.0 1.0 1.0 1.0 ...
                   0.5 0.5 0.5 0.5 0.5 0.5 ...
                   0.5 0.5 0.5 0.5 0.5 0.5 ...
                   0.5 0.5 0.5 0.5 0.5 0.5];
firing_start =    [2.0 2.0 2.0 2.0 2.0 2.0 ...
                   2.0 2.0 2.0 2.0 2.0 2.0 ...
                   2.0 2.0 2.0 2.0 2.0 2.0 ...
                   2.0 2.0 2.0 2.0 2.0 2.0 ...
                   2.0 2.0 2.0 2.0 2.0 2.0];
               
firing_end = firing_start + firing_duration;

in2m = 0.0254;
g2mpss = 9.81;
d2r = pi/180;
% mass = [11.4]; 
mass = [19.0];   % kg
nominalThrust = 0.38;   % N

% Dimensions of sled
width = 18*in2m;
depth = 18*in2m;
height = 6.5*in2m;

% Inertia of solid cube
inertiaSF = 0.63;
Izz = 1/12 * mass * (width^2 + depth^2);
Izz = Izz*inertiaSF;

% Assumption of nominal linear acceleration
nominalLinAccel = nominalThrust/mass;

% Assumption of nominal angular acceleration
nominalMoment = nominalThrust*(width/2);
nominalAngAccel = nominalMoment/Izz; 

% ignore the first second of data
beginTime = 1;

% ignore the beginning of the firing (these are percentages of duration)
boffset = 0.2;  
eoffset = 0.1;

clear iAccel eAccel dAccel thrust iRate eRate dRate angAccel moment force
nType = zeros(3,1);
thrusterList{1} = []; thrusterList{2} = []; thrusterList{3} = []; 
thrusterList{4} = []; thrusterList{5} = []; thrusterList{6} = [];
thrusterList{7} = []; thrusterList{8} = [];

typeList{1} = find(type==1);
typeList{2} = find(type==2);
typeList{3} = find(type==3);
for i=1:nCase
    clear filtAccel filtRate
    
    data = alldata{i};
%     filtAccel = squeeze(data.rt_yout.signals(2).values(1,1:3,:));
%     filtRate  = squeeze(data.rt_yout.signals(2).values(1,4:6,:));
    filtAccel = (data.rt_yout.signals(2).values(:,1:3)*g2mpss)';
    filtRate  = (data.rt_yout.signals(2).values(:,4:6)*d2r)';
    
    thrusterCmds = squeeze(data.rt_yout.signals(1).values(1,:,:))';
    
    thrusterOn{i} = zeros(8,1);
    for j=1:8
        if ~isempty(find(thrusterCmds(:,j) > 0))
            % List of thrusters on for each case
            thrusterOn{i}(j) = 1;
            % List of cases where each thruster is firing
            thrusterList{j}{length(thrusterList{j})+1} = i;
        end
        
    end
    
    sPt = find(data.rt_tout > firing_start(i),1);
    ePt = find(data.rt_tout > firing_end(i),1);
    bPt = find(data.rt_tout>beginTime,1);
    
    basePt = (sPt - bPt)/2;
    startTime = firing_start(i);
    endTime = firing_end(i);
    duration = firing_duration(i);
    
    newsPt = find(data.rt_tout>(startTime+duration*boffset),1);
    newePt = find(data.rt_tout>(endTime-duration*eoffset),1);
    deltaTime = data.rt_tout(newePt) - data.rt_tout(newsPt);
    
    
    if type(i) == 1
        nType(1) = nType(1) + 1;
%         iAccel(i) = mean(filtAccel(1,bPt:basePt));
        onAxisAccel = filtAccel(1,:);
        offAxisAccel = filtAccel(2,:);
%         iAccelOn{type(i)}{nType(type(i))} = mean(filtAccel(1,bPt:sPt));
%         eAccelOn{type(i)}{nType(type(i))} = mean(filtAccel(1,newsPt:newePt));
%         dAccelOn{type(i)}{nType(type(i))} = eAccelOn{type(i)}{nType(type(i))} - iAccelOn{type(i)}{nType(type(i))};
%         thrustOn{type(i)}{nType(type(i))} = dAccelOn{type(i)}{nType(type(i))}*mass;
%         
%         iAccelOff{type(i)}{nType(type(i))} = mean(filtAccel(1,bPt:sPt));
%         eAccelOff{type(i)}{nType(type(i))} = mean(filtAccel(1,newsPt:newePt));
%         dAccelOff{type(i)}{nType(type(i))} = eAccelOff{type(i)}{nType(type(i))} - iAccelOff{type(i)}{nType(type(i))};
%         thrustOff{type(i)}{nType(type(i))} = dAccelOff{type(i)}{nType(type(i))}*mass;
    elseif type(i) == 2
        nType(2) = nType(2) + 1;
        onAxisAccel = filtAccel(2,:);
        offAxisAccel = filtAccel(1,:);
% %         iAccel(i) = mean(filtAccel(2,bPt:basePt));
%         iAccelOn(i) = mean(filtAccel(2,bPt:sPt));
%         eAccelOn(i) = mean(filtAccel(2,newsPt:newePt));
%         dAccelOn(i) = eAccelOn(i) - iAccelOn(i);
%         thrustOn(i) = dAccelOn(i)*mass;
    elseif type(i) == 3
        nType(3) = nType(3) + 1;
        onAxisAccel = filtAccel(1,:);
        offAxisAccel = filtAccel(2,:);
% %         iRate(i) = mean(filtRate(3,bPt:basePt));
%         iRate(i) = mean(filtRate(3,bPt:sPt));
%         eRate(i) = filtRate(3,newePt);
%         dRate(i) = eRate(i) - iRate(i);
%         angAccel(i) = dRate(i)/deltaTime;
%         moment(i) = Izz*angAccel(i);
%         force(i) = moment(i)/(width/2);
    end

    iAccelOn(i) = mean(onAxisAccel(1,bPt:sPt));
    eAccelOn(i) = mean(onAxisAccel(1,newsPt:newePt));
    dAccelOn(i) = eAccelOn(i) - iAccelOn(i);
    thrustOn(i) = dAccelOn(i)*mass;
    
    iAccelOff(i) = mean(offAxisAccel(1,bPt:sPt));
    eAccelOff(i) = mean(offAxisAccel(1,newsPt:newePt));
    dAccelOff(i) = eAccelOff(i) - iAccelOff(i);
    thrustOff(i) = dAccelOff(i)*mass;
       
    iRate(i) = mean(filtRate(3,bPt:sPt));
    eRate(i) = filtRate(3,newePt);
    dRate(i) = eRate(i) - iRate(i);
    angAccel(i) = dRate(i)/deltaTime;
    moment(i) = Izz*angAccel(i);
    force(i) = moment(i)/(width/2);
    
%     figure;
%     subplot(2,1,1);plot(data.rt_tout,filtAccel(1,:))
%     xlabel('Time (sec)');ylabel('Accel (m/s2)');
%     title(['X Linear Acceleration, Case: ' num2str(i)])
%     subplot(2,1,2);plot(data.rt_tout,filtAccel(2,:))
%     xlabel('Time (sec)');ylabel('Accel (m/s2)');
%     title(['Y Linear Acceleration, Case: ' num2str(i)])  
%     
%     figure;
%     plot(data.rt_tout,filtRate(3,:)./d2r)
%     xlabel('Time (sec)');ylabel('Rate (deg/s)');
%     title(['Rotational Rate, Case:' num2str(i)])
    

    
   
%     figure;
%     subplot(4,1,1);plot(data.rt_tout,thrusterCmds(:,1))
%     title(['Thruster 1, Case: ' num2str(i)]);xlabel('Time (sec)');ylabel('Cmd (--)')
%     subplot(4,1,2);plot(data.rt_tout,thrusterCmds(:,2))
%     title('Thruster 2');xlabel('Time (sec)');ylabel('Cmd (--)')
%     subplot(4,1,3);plot(data.rt_tout,thrusterCmds(:,3))
%     title('Thruster 3');xlabel('Time (sec)');ylabel('Cmd (--)')
%     subplot(4,1,4);plot(data.rt_tout,thrusterCmds(:,4))
%     title('Thruster 4');xlabel('Time (sec)');ylabel('Cmd (--)')
%     
%     figure;
%     subplot(4,1,1);plot(data.rt_tout,thrusterCmds(:,5))
%     title(['Thruster 5, Case: ' num2str(i)]);xlabel('Time (sec)');ylabel('Cmd (--)')
%     subplot(4,1,2);plot(data.rt_tout,thrusterCmds(:,6))
%     title('Thruster 6');xlabel('Time (sec)');ylabel('Cmd (--)')
%     subplot(4,1,3);plot(data.rt_tout,thrusterCmds(:,7))
%     title('Thruster 7');xlabel('Time (sec)');ylabel('Cmd (--)')
%     subplot(4,1,4);plot(data.rt_tout,thrusterCmds(:,8))
%     title('Thruster 8');xlabel('Time (sec)');ylabel('Cmd (--)')
end

% Search through the translational cases and record the off-axis
% acceleration seen for each thruster
thrusterOffAxis{1} = []; thrusterOffAxis{2} = []; thrusterOffAxis{3} = [];
thrusterOffAxis{4} = []; thrusterOffAxis{5} = []; thrusterOffAxis{6} = [];
thrusterOffAxis{7} = []; thrusterOffAxis{8} = [];
thrusterRotation{1} = []; thrusterRotation{2} = []; thrusterRotation{3} = [];
thrusterRotation{4} = []; thrusterRotation{5} = []; thrusterRotation{6} = [];
thrusterRotation{7} = []; thrusterRotation{8} = [];

for i=1:nCase
    if type(i) == 1 || type(i) == 2
        for j=1:8
            if ~isempty(find(cell2mat(thrusterList{j}) == i))
                thrusterOffAxis{j}{length(thrusterOffAxis{j})+1} = dAccelOff(i);
                thrusterRotation{j}{length(thrusterRotation{j})+1} = angAccel(i);
            end
        end
    end
end
   


figure;hold all;
plot(find(type==1),dAccelOn(typeList{1}),'bo');
plot(find(type==2),dAccelOn(typeList{2}),'rx');
plot(find(type==3),dAccelOn(typeList{3}),'g+')
plot(1:nCase,2*nominalLinAccel*ones(nCase),'k',1:nCase,-2*nominalLinAccel*ones(nCase),'k')
xlabel('Test Case (-)');ylabel('Linear Acceleration (m/s^2)')
title('On-Axis Linear Acceleration During Firing')
legend('X Translation Test','Y Translation Test','Z Rotation Test','Assumed Nominal')

figure;hold all;
plot(find(type==1),dAccelOff(typeList{1}),'bo');
plot(find(type==2),dAccelOff(typeList{2}),'rx');
plot(find(type==3),dAccelOff(typeList{3}),'g+')
xlabel('Test Case (-)');ylabel('Linear Acceleration (m/s^2)')
title('Off-Axis Linear Acceleration During Firing')
legend('X Translation Test','Y Translation Test','Z Rotation Test')

figure;hold all;
plot(find(type==1),angAccel(typeList{1})./d2r,'bo');
plot(find(type==2),angAccel(typeList{2})./d2r,'rx');
plot(find(type==3),angAccel(typeList{3})./d2r,'g+')
plot(1:nCase,2*nominalAngAccel*ones(nCase)./d2r,'k',1:nCase,-2*nominalAngAccel*ones(nCase)./d2r,'k')
xlabel('Test Case (-)');ylabel('Angular Acceleration (deg/s^2)')
title('Angular Acceleration During Firing')
legend('X Translation Test','Y Translation Test','Z Rotation Test','Assumed Nominal')


figure;hold all;
plot(1*ones(length(thrusterOffAxis{1})),cell2mat(thrusterOffAxis{1}),'o')
plot(2*ones(length(thrusterOffAxis{2})),cell2mat(thrusterOffAxis{2}),'o')
plot(3*ones(length(thrusterOffAxis{3})),cell2mat(thrusterOffAxis{3}),'o')
plot(4*ones(length(thrusterOffAxis{4})),cell2mat(thrusterOffAxis{4}),'o')
plot(5*ones(length(thrusterOffAxis{5})),cell2mat(thrusterOffAxis{5}),'o')
plot(6*ones(length(thrusterOffAxis{6})),cell2mat(thrusterOffAxis{6}),'o')
plot(7*ones(length(thrusterOffAxis{7})),cell2mat(thrusterOffAxis{7}),'o')
plot(8*ones(length(thrusterOffAxis{8})),cell2mat(thrusterOffAxis{8}),'o')
xlabel('Thruster');ylabel('Linear Acceleration (m/s^2)')
title('Off-Axis Linear Acceleration During Translational Firings')
axis([0 9 -Inf Inf])

figure;hold all;
plot(1*ones(length(thrusterRotation{1})),cell2mat(thrusterRotation{1})./d2r,'o')
plot(2*ones(length(thrusterRotation{2})),cell2mat(thrusterRotation{2})./d2r,'o')
plot(3*ones(length(thrusterRotation{3})),cell2mat(thrusterRotation{3})./d2r,'o')
plot(4*ones(length(thrusterRotation{4})),cell2mat(thrusterRotation{4})./d2r,'o')
plot(5*ones(length(thrusterRotation{5})),cell2mat(thrusterRotation{5})./d2r,'o')
plot(6*ones(length(thrusterRotation{6})),cell2mat(thrusterRotation{6})./d2r,'o')
plot(7*ones(length(thrusterRotation{7})),cell2mat(thrusterRotation{7})./d2r,'o')
plot(8*ones(length(thrusterRotation{8})),cell2mat(thrusterRotation{8})./d2r,'o')
xlabel('Thruster');ylabel('Angular Acceleration (deg/s^2)')
title('Angular Acceleration During Translational Firings')
axis([0 9 -Inf Inf])
return
% npts = 2000;
% iAccel(1) = mean(data1.rt_yout.signals(2).values(1:npts/2,1));
% iAccel(2) = mean(data2.rt_yout.signals(2).values(1:npts/2,1));
% iAccel(3) = mean(data3.rt_yout.signals(2).values(1:npts/2,2));
% iAccel(4) = mean(data4.rt_yout.signals(2).values(1:npts/2,2));
% iRate(5) =  data5.rt_yout.signals(2).values(npts/2,6);
% iRate(6) =  data6.rt_yout.signals(2).values(npts/2,6);
% sPt = npts/2;
% ePt = sPt+npts/10;
% tAccel(1) = mean(data1.rt_yout.signals(2).values(sPt:ePt,1));
% tAccel(2) = mean(data2.rt_yout.signals(2).values(sPt:ePt,1));
% tAccel(3) = mean(data3.rt_yout.signals(2).values(sPt:ePt,2));
% tAccel(4) = mean(data4.rt_yout.signals(2).values(sPt:ePt,2));
% fRate(5) =  data5.rt_yout.signals(2).values(ePt,6);
% fRate(6) =  data6.rt_yout.signals(2).values(ePt,6);
% dAccel = tAccel-iAccel;
% dRate = fRate-iRate;

% thrust = dAccel*g2mpss*m;
% angAccel = dRate*d2r/1;
% moment = Izz*angAccel;
% force = moment/(width/2);

% return
% data=data6;
% thrusterCmds = squeeze(data.rt_yout.signals(1).values(1,:,:))';
% sensorData = data.rt_yout.signals(2).values


% figure;
% subplot(4,1,1);plot(data.rt_tout,thrusterCmds(:,1))
% title('Thruster 1');xlabel('Time (sec)');ylabel('Cmd (--)')
% subplot(4,1,2);plot(data.rt_tout,thrusterCmds(:,2))
% title('Thruster 2');xlabel('Time (sec)');ylabel('Cmd (--)')
% subplot(4,1,3);plot(data.rt_tout,thrusterCmds(:,3))
% title('Thruster 3');xlabel('Time (sec)');ylabel('Cmd (--)')
% subplot(4,1,4);plot(data.rt_tout,thrusterCmds(:,4))
% title('Thruster 4');xlabel('Time (sec)');ylabel('Cmd (--)')
% 
% figure;
% subplot(4,1,1);plot(data.rt_tout,thrusterCmds(:,5))
% title('Thruster 5');xlabel('Time (sec)');ylabel('Cmd (--)')
% subplot(4,1,2);plot(data.rt_tout,thrusterCmds(:,6))
% title('Thruster 6');xlabel('Time (sec)');ylabel('Cmd (--)')
% subplot(4,1,3);plot(data.rt_tout,thrusterCmds(:,7))
% title('Thruster 7');xlabel('Time (sec)');ylabel('Cmd (--)')
% subplot(4,1,4);plot(data.rt_tout,thrusterCmds(:,8))
% title('Thruster 8');xlabel('Time (sec)');ylabel('Cmd (--)')

% figure;
% subplot(3,1,1);plot(data.rt_tout,sensorData(:,1))
% 
% title('X Axis Acceleration');xlabel('Time (sec)');ylabel('Accel (g''s)');
% subplot(3,1,2);plot(data.rt_tout,sensorData(:,2))
% title('Y Axis Acceleration');xlabel('Time (sec)');ylabel('Accel (g''s)');
% subplot(3,1,3);plot(data.rt_tout,sensorData(:,3))
% title('Z Axis Acceleration');xlabel('Time (sec)');ylabel('Accel (g''s)');
% 
% figure;
% subplot(3,1,1);plot(data.rt_tout,sensorData(:,4))
% title('X Axis Angular Rate');xlabel('Time (sec)');ylabel('Rate (deg/s)');
% subplot(3,1,2);plot(data.rt_tout,sensorData(:,5))
% title('Y Axis Angular Rate');xlabel('Time (sec)');ylabel('Rate (deg/s)');
% subplot(3,1,3);plot(data.rt_tout,sensorData(:,6))
% title('Z Axis Angular Rate');xlabel('Time (sec)');ylabel('Rate (deg/s)');