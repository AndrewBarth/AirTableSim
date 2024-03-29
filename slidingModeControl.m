function [controlSignal,controlErrorECEF,controlErrorBody] = slidingModeControl(t,state,refValues,mass,inertia,SMGains)
% 
% The state vector consists of 2 - 3x1 vectors. [q qdot]
%
% Inputs: t                 current time step

% Output: controlSignal    
%         controlErrorECEF 
%         controlErrorBody
%
% Assumptions and Limitations:
%    Calculations performed about body-fixed principal axes
%
% Dependencies:
%
% References:
%    Wie, Bong. Space vehicle dynamics and control. 
%    American Institute of Aeronautics and Astronautics, 2008.
%
%    Newton equations of motion
%    F = m*(vdot + w X v)
%    Fx = m*(vdotx + wy*vz - wz*vy)
%    Fy = m*(vdoty + wz*vx - wx*vz)
%    Fz = m*(vdotz + wx*vy - wy*vx)
%
%    Euler equations of motion
%    M = I*wDot + w X Iw
%    Mx = I1*wxDot + (I3-I2)*wy*wz
%    My = I2*wyDot + (I1-I3)*wz*wx
%    Mz = I3*wzDot + (I2-I1)*wx*wy
%
% Author: Andrew Barth
%
% Modification History:
%    Jun 30 2019 - Initial version
%

% a = 2;
% b = 2;
% c = 2;
% gammaA = 2;
% gammaB = 2;
% gammaC = 4;
% epsilon = 1.0;
a = SMGains(1);
b = SMGains(2);
c = SMGains(3);
gammaA = SMGains(4);
gammaB = SMGains(5);
gammaC = SMGains(6);
epsilonA = SMGains(7);
epsilonB = SMGains(8);
epsilonC = SMGains(9);

error = state - refValues;
controlErrorECEF = error;

M_ECEF_To_Body = EulerToDCM_321(state(4:6))';
ePosBody = M_ECEF_To_Body*error(1:3);
eVelBody = M_ECEF_To_Body*error(7:9);

error(1:3) = ePosBody;
error(7:9) = eVelBody;
controlErrorBody = [ePosBody; error(4:6); eVelBody; error(10:12)];

% Translational
% s1 = a*2*error(1) + error(7);
% s2 = b*2*error(2) + error(8);
s1 = a*error(1) + error(7);
s2 = b*error(2) + error(8);
angular_rate = state(12);


ratio1 = abs(s1/epsilonA);
ratio2 = abs(s2/epsilonB);
if ratio1 <= 1
    satS1 = s1;
else
    satS1 = sign(s1);
end
if ratio2 <= 1
    satS2 = s2;
else
    satS2 = sign(s2);
end

% u1 = mass*(-a*4*error(7) - angular_rate*state(8) - gammaA*satS1);
% u2 = mass*(-b*4*error(8) + angular_rate*state(7) - gammaB*satS2);
% u1 = mass*(-a*error(7) - angular_rate*state(8) - gammaA*satS1);
% u2 = mass*(-b*error(8) + angular_rate*state(7) - gammaB*satS2);
u1 = mass*(-a*error(7)  - gammaA*satS1);
u2 = mass*(-b*error(8)  - gammaB*satS2);
% Rotational
% s3 = c*error(6) + error(12);
% s3 = c/4*error(6) + error(12);
s3 = c*error(6) + error(12);
ratio3 = abs(s3/epsilonC);
if ratio3 <= 1
    satS3 = s3;
else
    satS3 = sign(s3);
end

% u3 = inertia*(-4*c*error(12) - gammaC*satS3);
% u3 = inertia*(-12*c*error(12) - gammaC*satS3);
% u3 = inertia*(-4*c*error(12) - gammaC*satS3);
u3 = inertia*(-c*error(12) - gammaC*satS3);
controlSignal = [u1 u2 0 0 0 u3]';
