function [newrefTraj] = referenceTrajectory(IC_State,refIdx,controlType,PositionData,rawPosition,RotationData)
% Function to compute a reference trajectory for the vehicle, which will be
% used as the commanded position, orientation, velocity, angular rates.
% The output reference trajectory contains the elements of:
% element 1     time
% element 2:4   position vector (x, y, z)
% element 5:7   Euler angles (roll, pitch, yaw)
% element 8:10  velocity vector (vx, vy, vz)
% element 11:13 angular rates (wx, wy, wz)
% element 14    flag to indicate if approach control is to be used
%               A 0 value will make elements 15 and 16 unused
% element 15    range sensor indx (this value represents the range sensor
%               that will be facing the target
% element 16    desired range
%
% Inputs: IC_State      Inital state of the vehicle
%         refIdx        Index for which reference trajectory to uss
%         controlType   Type of controller being used
%         PositionData  Current position of the vehicle from Navigation
%         rawPosition   Current position of the vehicle
%         RotationData  Current orientation of the vehicle
%
% Output: newrefTraj    Output reference trajectory
%
% Assumptions and Limitations:
%
% Dependencies:
%
% References:
%
% Author: Andrew Barth
%
% Modification History:
%    May    2019 - Initial version
%    Dec 13 2021 - Re-formatted how ref traj is setup


dtr = pi/180;

IC_ECEFpos = IC_State.TranState_ECEF.R_Sys_ECEF;
IC_ECEFvel = IC_State.TranState_ECEF.V_Sys_ECEF;
IC_EulerA = IC_State.RotState_Body_ECEF.ECEF_To_Body_Euler;
IC_Rates = IC_State.RotState_Body_ECEF.BodyRates_wrt_ECEF_In_Body;
IC       = [IC_ECEFpos' IC_EulerA' IC_ECEFvel' IC_Rates' 0 1 0];

if norm(rawPosition) > eps
    nav_ECEFpos = PositionData;
else
    nav_ECEFpos = IC_ECEFpos;
end

if norm(RotationData) > eps
    nav_EulerA = RotationData;
else
    nav_EulerA = IC_EulerA;
end

timeline = [0 3.0 40 45 70 90];

% All trajectories are initialized with the vehicle remaining in place
% Note that the time value is prepended at the end of this function
nTrajPts = 6; 
cmd = zeros(nTrajPts,length(IC));
for i=1:nTrajPts
    cmd(i,:) = IC;
end
disp(cmd)
if refIdx == 0
    % Hold Initial Position
    position_0 = [nav_ECEFpos(1:2)'];
    angle_0 = nav_EulerA(3);
    cmd(1,[1:2 6]) = [position_0 angle_0];
    cmd(2,[1:2 6]) = [position_0 angle_0];
    cmd(3,[1:2 6]) = [position_0 angle_0];
    cmd(4,[1:2 6]) = [position_0 angle_0];
    cmd(5,[1:2 6]) = [position_0 angle_0];
    cmd(6,[1:2 6]) = [position_0 angle_0];

elseif refIdx == 1
    % +X translation
    position_0 = [nav_ECEFpos(1:2)'];
    position_1 = [nav_ECEFpos(1) + 0.5  nav_ECEFpos(2)];
    angle_0 = nav_EulerA(3);
    
    cmd(1,[1:2 6]) = [position_0 angle_0];
    cmd(2,[1:2 6]) = [position_0 angle_0];
    cmd(3,[1:2 6]) = [position_1 angle_0];
    cmd(4,[1:2 6]) = [position_1 angle_0];
    cmd(5,[1:2 6]) = [position_1 angle_0];
    cmd(6,[1:2 6]) = [position_1 angle_0];
elseif refIdx == 2
    % -X translation
    position_0 = [nav_ECEFpos(1:2)'];
    position_1 = [nav_ECEFpos(1) - 0.5  nav_ECEFpos(2)];
    angle_0 = nav_EulerA(3);
    cmd(1,[1:2 6]) = [position_0 angle_0];
    cmd(2,[1:2 6]) = [position_0 angle_0];
    cmd(3,[1:2 6]) = [position_1 angle_0];
    cmd(4,[1:2 6]) = [position_1 angle_0];
    cmd(5,[1:2 6]) = [position_1 angle_0];
    cmd(6,[1:2 6]) = [position_1 angle_0];
elseif refIdx == 3
    % +Y translation
    position_0 = [nav_ECEFpos(1:2)'];
    position_1 = [nav_ECEFpos(1) nav_ECEFpos(2)+0.5];
    angle_0 = nav_EulerA(3);
    cmd(1,[1:2 6]) = [position_0 angle_0];
    cmd(2,[1:2 6]) = [position_0 angle_0];
    cmd(3,[1:2 6]) = [position_1 angle_0];
    cmd(4,[1:2 6]) = [position_1 angle_0];
    cmd(5,[1:2 6]) = [position_1 angle_0];
    cmd(6,[1:2 6]) = [position_1 angle_0];
elseif refIdx == 4
    % -Y translation
    position_0 = [nav_ECEFpos(1:2)'];
    position_1 = [nav_ECEFpos(1) nav_ECEFpos(2)-0.5];
    angle_0 = nav_EulerA(3);
    cmd(1,[1:2 6]) = [position_0 angle_0];
    cmd(2,[1:2 6]) = [position_0 angle_0];
    cmd(3,[1:2 6]) = [position_1 angle_0];
    cmd(4,[1:2 6]) = [position_1 angle_0];
    cmd(5,[1:2 6]) = [position_1 angle_0];
    cmd(6,[1:2 6]) = [position_1 angle_0];
elseif refIdx == 5
    % +Z Rotation
    position_0 = [nav_ECEFpos(1:2)'];
    angle_0 = nav_EulerA(3);
    angle_1 = nav_EulerA(3)+90*dtr;
    cmd(1,[1:2 6]) = [position_0 angle_0];
    cmd(2,[1:2 6]) = [position_0 angle_0];
    cmd(3,[1:2 6]) = [position_0 angle_1];
    cmd(4,[1:2 6]) = [position_0 angle_1];
    cmd(5,[1:2 6]) = [position_0 angle_1];
    cmd(6,[1:2 6]) = [position_0 angle_1];
elseif refIdx == 6
    % -Z Rotation
    position_0 = [nav_ECEFpos(1:2)'];
    angle_0 = nav_EulerA(3);
    angle_1 = nav_EulerA(3)-90*dtr;
    cmd(1,[1:2 6]) = [position_0 angle_0];
    cmd(2,[1:2 6]) = [position_0 angle_0];
    cmd(3,[1:2 6]) = [position_0 angle_1];
    cmd(4,[1:2 6]) = [position_0 angle_1];
    cmd(5,[1:2 6]) = [position_0 angle_1];
    cmd(6,[1:2 6]) = [position_0 angle_1];
elseif refIdx == 7
    % IC Position, then simulataneous translation and rotation, then rotate and
    % start approach control
    position_1 = [1.0 1.5];
    angle_1 = 30*dtr;
    angle_2 = 90*dtr;
    cmd(1,:) = IC;
    cmd(2,:) = IC;
    cmd(3,[1:2 6]) = [position_1 angle_1];  % New position and angle
    cmd(4,[1:2 6]) = [position_1 angle_1];  
    cmd(5,[6 13:15]) = [angle_2 0 1 1.5-0.45];  % New angle (disabled approach contol)
    cmd(6,[6 13:15]) = [angle_2 0 1 0.25];  % New angle (disabled approach control)
end

% Add dummy points to the trajectory so that the command transitions are
% crisp rather than interpolated
newtimeline = zeros(1,2*size(timeline,2)-2);
newcmd = zeros(2*size(timeline,2)-2,15);
newtimeline(1) = timeline(1);
newcmd(1,:) = cmd(1,:);
for i = 2:size(timeline,2)-1
    newtimeline(2*(i-1))     = timeline(i);
    newtimeline(2*(i-1) + 1) = timeline(i)+0.01;
    newcmd(2*(i-1),:)   = cmd(i,:);
    newcmd(2*(i-1) + 1,:) = cmd(i,:);
    
    % Phase plane controller should not have a velocity and rate command
    if controlType ~= 3
        % Form a velocity command based on the requested change in position
         newcmd(2*(i-1),7:8) = (cmd(i,1:2) - cmd(i-1,1:2)) / (timeline(i) - timeline(i-1));
         newcmd(2*(i-1) + 1,7:8) = (cmd(i+1,1:2) - cmd(i,1:2)) / (timeline(i+1) - timeline(i));

        % Form an angular rate command based on the requested change in angle
         newcmd(2*(i-1),12) = (cmd(i,6) - cmd(i-1,6)) / (timeline(i) - timeline(i-1));
         newcmd(2*(i-1) + 1,12) = (cmd(i+1,6) - cmd(i,6)) / (timeline(i+1) - timeline(i));
    end
    
end
newtimeline(end) = timeline(end);
newcmd(end,:) = cmd(end,:);

newrefTraj = zeros(size(newtimeline,2),16);
for i = 1:size(newtimeline,2)
    newrefTraj(i,:) = [newtimeline(i) newcmd(i,:)]; 
end




