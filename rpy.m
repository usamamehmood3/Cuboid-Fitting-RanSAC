function [xyz] = rpy(R)
%RPY  returns the X-Y-Z fixed angles of rotation matrix R
%
%	[ROLL PITCH YAW] = RPY(R)
%
% R is a rotation matrix. xyz is of the form [roll pitch yaw]'
%
% See also: .

% $Id: rpy.m,v 1.1 2009-03-17 16:40:18 bradleyk Exp $
% Copyright (C) 2005, by Brad Kratochvil

if ~isrot(R)
  error('R is not a rotation matrix');
end

beta = atan2(-R(3,1), sqrt(R(1,1)^2 + R(2,1)^2));
if isequalf(beta, pi/2)
  alpha = 0;
  gamma = atan2(R(1,2), R(2,2));
elseif isequalf(beta, -pi/2)
  alpha = 0;
  gamma = -atan2(R(1,2), R(2,2));
else
  alpha = atan2(R(2,1)/cos(beta), R(1,1)/cos(beta));
  gamma = atan2(R(3,2)/cos(beta), R(3,3)/cos(beta));
end

roll = gamma;
pitch = beta;
yaw = alpha;

xyz = [roll pitch yaw]';