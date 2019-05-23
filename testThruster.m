
time = 1;
timeStep = 0.025;

controlForce = [0 -1 0];
controlMoment = [0 0 0];

[m Izz] = planarMassProperties;
loadThrusterData

M=[m 0 0;0 m 0;0 0 Izz];
Minv = M\eye(size(M));

[thrusterForce,thrusterMoment,thrusterOnTimes] = thrusterModel(time,controlForce,controlMoment,thrusterData);


[cog,FM,ulambda,AjInv] = COGInit(thrusterData,nThruster);
ncog = size(cog,1);
    
%     b = [-.1 .1 .3].*[m m Izz];
%     b = [-11.0000   -5.5000    0.0396];
     b = [-19.1302  -11.7413   -0.1934]*timeStep;
%    b = [-2 -2 -2];
    maxVal = 0;
    % Find the optimal COG for this command
    tbtime = NaN*ones(ncog,1);
    for i = 1:ncog
        dotResult = dot(ulambda(i,:),b);
        if dotResult > maxVal
            optCOG = i;
            maxVal = dotResult;
        end
        Ajinv = squeeze(AjInv(i,:,:));
        btime(i,:) = Ajinv*b';
        xx=sum(btime(i,:) >= 0);
        if xx == 3
            % All positive or zero burn times
            tbtime(i) = sum(btime(i,:));
        end
        
    end
    [val optCOG] = min(tbtime);
    
    FM1 = FM(cog(optCOG,1),:);
    FM2 = FM(cog(optCOG,2),:);
    FM3 = FM(cog(optCOG,3),:);
    ontime(1:3) = btime(optCOG,:); 
%     Aj = [FM1 FM2 FM3];
%     Ajinv = Aj\size(Ajinv);
%     ontime = Ajinv*b;

%     c12 = cross(FM1,FM2);
%     c13 = cross(FM1,FM3);
%     c23 = cross(FM2,FM3);
%     s = dot(FM3,c12);
%     ontime(3) = dot(b,c12);
%     ontime(3) = abs(ontime(3)/s);
%     ontime(2) = dot(b,c13);
%     ontime(2) = abs(ontime(2)/s);
%     ontime(1) = dot(b,c23);
%     ontime(1) = abs(ontime(1)/s);
    
    totalFM=FM1+FM2+FM3;
    
    
    
    %