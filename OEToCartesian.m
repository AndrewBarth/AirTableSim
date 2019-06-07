function [Position,Velocity] = OEToCartesian(t,Orbital_Elements,mu)
% Function to compute the classical orbital elements from
% the cartesian position and velocity vectors
%
% Inputs: Oribital_Elements classical orbital elements 6x1
%         Position  Inertial position vector 3x1
%         Velocity  inertial velocity vector 3x1
%         mu        Gravitaional parameter
%
% Output: Position  Inertial position vector 3x1
%         Velocity  inertial velocity vector 3x1
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
%    May 29 2019 - Initial version
%

% Create aliases for oribital elements
a     = Orbital_Elements(1);
e     = Orbital_Elements(2);
inc   = Orbital_Elements(3);
RAAN  = Orbital_Elements(4);
omega = Orbital_Elements(5);
nu    = Orbital_Elements(6);

% Compute radial position
p = a*(1-e^2);
r = p/(1+e*cos(nu));

% Compute position and velocity in perifocal coordinates
rP = [r*cos(nu); r*sin(nu); 0];
vP = [-sqrt(mu/p)*sin(nu); sqrt(mu/p)*(e+cos(nu)); 0];

% Compute transformation from perifocal coordinates to geocentric
% coordinates
M_Perifocal_To_ECI = formZRot(RAAN)*formXRot(inc)*formZRot(omega);

% Rotate the perifocal position and velocity to geocentric coordinates
Position = M_Perifocal_To_ECI*rP;
Velocity = M_Perifocal_To_ECI*vP;