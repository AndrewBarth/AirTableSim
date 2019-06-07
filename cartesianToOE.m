function [Orbital_Elements] = cartesianToOE(t,Position,Velocity,mu)
% Function to compute the classical orbital elements from
% the cartesian position and velocity vectors
%
% Inputs: Position  Inertial position vector 3x1
%         Velocity  inertial velocity vector 3x1
%         mu        Gravitaional parameter
%
% Output: Oribital_Elements classical orbital elements 6x1
%
% Assumptions and Limitations:
%
% Dependencies:
%
% References:
%    Larson, Wiley J., and James Richard Wertz. Space mission analysis and design. 
%    No. DOE/NE/32145-T1. Torrance, CA (United States); Microcosm, Inc., 1992.
%
%    Wie, Bong. Space vehicle dynamics and control. 
%    American Institute of Aeronautics and Astronautics, 2008.
%
% Author: Andrew Barth
%
% Modification History:
%    May 27 2019 - Initial version
%

% Compute scalar radius and speed
r = norm(Position);
v = norm(Velocity);

% Compute angular moment vector
hVec = cross(Position,Velocity);
h = norm(hVec);

% Compute the eccentricity vector
eVec = ((v^2 - (mu/r))*Position - dot(Position,Velocity)*Velocity)/mu;
e = norm(eVec);

% Compute energy
Energy = v^2/2 - mu/r;

% Compute semi-major axis
a = -mu/(2*Energy);

% Compute the nodal vector
kVec = [0 0 1];
nVec = cross(kVec,hVec);
n = norm(nVec);

% Compute the RAAN
RAAN = acos(nVec(1)/n);
if nVec(2) < 0
    RAAN = 2*pi - RAAN;
end

% Compute the inclination
inc = acos(dot(kVec,(hVec/h)));

omega = acos(dot(nVec,eVec)/(n*e));
if eVec(3) < 0
    omega = 2*pi - omega;
end

% Compute true anomaly at to
thetaT0 = acos(dot(Position,eVec)/(r*e));
if dot(Position,Velocity) < 0
    thetaT0 = thetaT0 + pi;
end

% Compute eccentric anomaly at to
ET0 = 2*atan(sqrt((1-e)/(1+e))*tan(thetaT0/2));

% Compute mean anomaly 
M = ET0 - e*sin(ET0);

% Comptue the true anomaly
nu = acos(dot(eVec,Position)/(e*r));
if dot(Position,Velocity) < 0
    nu = 2*pi - nu;
end

% Compute eccectric anomaly 
E = 2*atan(sqrt((1-e)/(1+e))*tan(nu/2));
if E < 0
    E = E + 2*pi;
end

% Compute mean anomaly
M = E - e*sin(E);

% Compute mean motion
mean_motion = sqrt(mu/a^3);

% Compute orbital period
period = 2*pi/mean_motion;

% Compute time since perigee passage
tp = M/mean_motion;

Orbital_Elements = [a e inc RAAN omega nu];

