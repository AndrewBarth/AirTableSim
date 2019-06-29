function [estPos,fullRange,fullAngle,thirdSide,area]  = estimatePosition(rangeData,rangeSensorLocBody,rangeSensorAngBody,wallBounds)
% Estimate the current position based on sensed range data
% 
% Inputs: rangeData          sensed range data 4x1
%         rangeSensorLocBody center point of each sensor in body frame nx1     
%         rangeSensorAngBody angle of center vector of each sensor relative
%                            to body frame nx1
%         wallBounds         end points of each wall in ECEF frame mx4
%
% Output: estPos             position estimate in ECEF frame 3x1
%
% Assumptions and Limitations:
%    assumes range sensors are placed 90 deg around platform
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
%

estPos = [0 0 0];
npts = size(rangeData,1);

% Extend each range measurement to the center of the platform, 
% forming 2 sides of a right triangle
for i = 1:npts
    fullRange(i) = rangeData(i) + norm(rangeSensorLocBody(i,:));
end

% Compute the length of the third side of this triangle and the angles of
% each triangle
for i = 1:npts-1
    thirdSide(i) = sqrt(fullRange(i)^2 + fullRange(i+1)^2);
    ang1(i) = atan2(fullRange(i+1),fullRange(i));
    ang2(i) = pi/2 - ang1(i);
end
thirdSide(npts) = sqrt(fullRange(npts)^2 + fullRange(1)^2);
ang1(npts) = atan2(fullRange(1),fullRange(npts));
ang2(npts) = pi/2 - ang1(npts);

% Compute the angles of each triangle
for i = 1:npts-1
    fullAngle(i) = ang2(i) + ang1(i+1);
end
fullAngle(npts) = ang2(npts) + ang1(1);

area = 0.5*thirdSide(1)*thirdSide(2)*sin(fullAngle(1)) + ...
       0.5*thirdSide(3)*thirdSide(4)*sin(fullAngle(3));
