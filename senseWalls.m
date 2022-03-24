function [range,rangeArray] = senseWalls(state,rangeSensorLocBody,rangeSensorAngBody,rangeSensorFOV,wallBounds)
% Compute the distance to the each wall
% 
% Inputs: state              state data structure
%         rangeSensorLocBody center point of each sensor in body frame nx1     
%         rangeSensorAngBody angle of center vector of each sensor relative
%                            to body frame nx1
%         rangeSensorFOV     field of view of each sensor
%         wallBounds         end points of each wall in ECEF frame mx4
%
% Output: range              minimum distances from each sensor nx1
%         rangeArray         minimum distances to each wall
%
% Assumptions and Limitations:
%    Arrays are sized for 4 walls
%
% Dependencies:
%    quatrotate
%    quatmult
%    quatconj
%
% References:
%
% Author: Andrew Barth
%
% Modification History:
%    Jun 17 2019 - Initial version
%    Mar 23 2022 - Corrected comments
%

range = zeros(4,1);
rangeArray = zeros(4,4);

% Extract required state data
R_Sys_ECEF     = state.TranState_ECEF.R_Sys_ECEF;
Q_ECEF_To_Body = state.RotState_Body_ECEF.ECEF_To_Body_Quat;
% Q_Body_To_ECEF = quatconj(Q_ECEF_To_Body');
Q_Body_To_ECEF = Q_ECEF_To_Body';

sensorAngMinBody = zeros(4,1);
sensorAngMaxBody = zeros(4,1);
sensorVecBody    = zeros(4,3);
sensorVecMinBody = zeros(4,3);
sensorVecMaxBody = zeros(4,3);
sensorLocECEF    = zeros(4,3);
sensorVecCenECEF = zeros(4,3);
sensorVecMinECEF = zeros(4,3);
sensorVecMaxECEF = zeros(4,3);
distanceCen  = zeros(4,4);
distanceMin  = zeros(4,4);
distanceMax  = zeros(4,4);
for isens = 1:4
    % Compute min max angles based on field of view
    sensorAngMinBody(isens) = rangeSensorAngBody(isens) - 0.5*rangeSensorFOV(isens);
    sensorAngMaxBody(isens) = rangeSensorAngBody(isens) + 0.5*rangeSensorFOV(isens);
    sensorVecBody(isens,:) = [cos(rangeSensorAngBody(isens)) sin(rangeSensorAngBody(isens)) 0];
    sensorVecMinBody(isens,:) = [cos(sensorAngMinBody(isens)) sin(sensorAngMinBody(isens)) 0];
    sensorVecMaxBody(isens,:) = [cos(sensorAngMaxBody(isens)) sin(sensorAngMaxBody(isens)) 0];
    
    % Compute the sensor information in the ECEF frame
    sensorLocECEF(isens,:) = R_Sys_ECEF' + quatrotate(rangeSensorLocBody(isens,:)',Q_Body_To_ECEF);
    sensorVecCenECEF(isens,:) = quatrotate(sensorVecBody(isens,:)',Q_Body_To_ECEF);
    sensorVecMinECEF(isens,:) = quatrotate(sensorVecMinBody(isens,:)',Q_Body_To_ECEF);
    sensorVecMaxECEF(isens,:) = quatrotate(sensorVecMaxBody(isens,:)',Q_Body_To_ECEF);
end

% Find which walls are in view of each sensor
for isens = 1:4
    for iwall = 1:4
        [distanceCen(isens,iwall)] = raySegmentIntersect(wallBounds(iwall,:),sensorLocECEF(isens,:),sensorVecCenECEF(isens,:));
        [distanceMin(isens,iwall)] = raySegmentIntersect(wallBounds(iwall,:),sensorLocECEF(isens,:),sensorVecMinECEF(isens,:));
        [distanceMax(isens,iwall)] = raySegmentIntersect(wallBounds(iwall,:),sensorLocECEF(isens,:),sensorVecMaxECEF(isens,:));
    end
end

% Compute the minimum distance for each sensor
val = zeros(3,1);
idx = zeros(3,1);
for isens = 1:4
    [val(1), idx(1)] = min(distanceCen(isens,:));
    [val(2), idx(2)] = min(distanceMin(isens,:));
    [val(3), idx(3)] = min(distanceMax(isens,:));
    
    [valT, idxT] = min(val);
    rangeArray(isens,idx(idxT)) = val(idxT);
    range(isens) = val(idxT);
   
end


end

function [distance] = raySegmentIntersect(line,ray,rayVec)
    % https://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect/565282#565282
    % https://stackoverflow.com/questions/14307158/how-do-you-check-for-intersection-between-a-line-segment-and-a-line-ray-emanatin
    
    % Endpoints of line segment
    segPt1 = line(1:2);   % q
    segPt2 = line(3:4);   % q+s
    segDir = segPt2 - segPt1;   % s
    
    % Start point and unit vector of the ray
    rayStart = ray(1:2); % p
    angle = atan2(rayVec(2),rayVec(1));
    rayDir = [cos(angle) sin(angle)];  % r
    % p + tr = q + us
     
    % t = (q-p)x s / (r x s)
    rxs = rayDir(1)*segDir(2) - rayDir(2)*segDir(1);
    qmp = segPt1 - rayStart;
    qmpxs = qmp(1)*segDir(2) - qmp(2)*segDir(1);
    t = qmpxs / rxs;
    
    % u = (q-p)xr / (rxs)
    qmpxr = qmp(1)*rayDir(2) - qmp(2)*rayDir(1);
    u = qmpxr / rxs;
    
    if rxs ~= 0 && t >= 0 && u >= 0 && u <= 1
%         intersect = 1;
        distance = norm(t*rayDir);
    else
%         intersect = 0;
        distance = 999;
    end
        
end


