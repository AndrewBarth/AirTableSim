


nThruster = 8;
% nominalThrust = 1.0;   % N
% nominalThrust = 0.65;   % N
nominalThrust = 0.65;   % N  trial
% nominalThrust = 0.15;   % N

thrusterData.minOnTime = 0.1;
thrusterData.minOnTime = 0.05;
% thrusterData.minOnTime = 0.025;
% C1 = combnk(1:nThruster,1);
% C2 = combnk(1:nThruster,2);
% C3 = combnk(1:nThruster,3);
% C = [ [C1 zeros(size(C1,1),2)]; [C2 zeros(size(C2,1),1)]; C3];
% clear C1 C2 C3


C3 = combnk(1:nThruster,3);
C = [ C3];
clear C1 C2 C3

thrusterData.thrusterCombinations = C;


platformWidth  = 18*0.0254;   % m
platformLength = 18*0.0254;  % m

%   Thruster Layout
%     3       2   
%    4         1
%
%
%    5         8       
%     6       7          ^
%                        | 
%  + X -->             + Y 
                   
thrusterLocation  = [ platformWidth/2  platformLength/2 0;  ...
                      platformWidth/2  platformLength/2 0;  ...
                     -platformWidth/2  platformLength/2 0;  ...
                     -platformWidth/2  platformLength/2 0;  ...
                     -platformWidth/2 -platformLength/2 0;  ...
                     -platformWidth/2 -platformLength/2 0;  ...
                      platformWidth/2 -platformLength/2 0;  ...
                      platformWidth/2 -platformLength/2 0  ];
thrusterDirection  = [-1   0  0; ...
                       0  -1  0; ...
                       0  -1  0; ...
                       1   0  0; ...
                       1   0  0; ...
                       0   1  0; ...
                       0   1  0; ...
                      -1   0  0  ];
                   
thrusterForce = nominalThrust.*thrusterDirection;
thrusterMoment=zeros(nThruster,3);
for i = 1:nThruster      
    thrusterMoment(i,:) = cross(thrusterLocation(i,:),thrusterForce(i,:));
end

thrusterData.nThruster = nThruster;
thrusterData.nominalThrust = nominalThrust;
thrusterData.thrusterLocation = thrusterLocation;
thrusterData.thrusterDirection = thrusterDirection;
thrusterData.thrusterForce = thrusterForce;
thrusterData.thrusterMoment = thrusterMoment;

[cog,FM,ulambda,AjInv] = COGInit(thrusterData,nThruster);
thrusterData.cog = cog;
thrusterData.FM = FM;
thrusterData.ulambda = ulambda;
thrusterData.AjInv = AjInv;

clear platformWidth platformLength
clear thrusterLocation thrusterDirection thrusterForce thrusterMoment