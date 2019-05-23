function [refTraj] = referenceTrajectory(IC_ECEF)

dtr = pi/180;
cmd = zeros(4,12);
IC       = [0.0 0.0 0.0  0.0 0.0 0.0     0.0 0.0 0.0  0.0 0.0 0.0];
cmd(1,:) = [0.0 0.0 0.0  0.0 0.0 0.0     0.0 0.0 0.0  0.0 0.0 0.0];
cmd(2,:) = [2.0 1.5 0.0  0.0 0.0 45*dtr  0.0 0.0 0.0  0.0 0.0 0.0];
cmd(3,:) = [2.0 1.5 0.0  0.0 0.0 45*dtr  0.0 0.0 0.0  0.0 0.0 0.0];
cmd(4,:) = [2.0 1.5 0.0  0.0 0.0 90*dtr  0.0 0.0 0.0  0.0 0.0 0.0];
% cmd(5,:) = [2.0 1.5 0.0  0.0 0.0 90*dtr  0.0 0.0 0.0  0.0 0.0 0.0];

timeline = [0 20 25 45];

refTraj = [timeline(1) IC_ECEF'; ...
           timeline(2) cmd(2,:); ...
           timeline(3) cmd(3,:); ...
           timeline(4) cmd(4,:)];



