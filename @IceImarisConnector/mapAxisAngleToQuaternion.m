function q = mapAxisAngleToQuaternion(r_axis, r_angle)
% IceImarisConnector:  mapAxisAngleToQuaternion (static public method)
%
% DESCRIPTION
% 
%   This method converts axis–angle representation to quaternion.
% 
% SYNOPSIS
% 
%   q = conn.mapAngleAxisToVector(r_axis, r_angle)
% 
% INPUT
% 
%   r_axis  : axis of rotation, e.g. [0 1 0]
%   r_angle : angle in radians
% 
% OUTPUT
% 
%   q       : quaternion
%
% AUTHORS
%
% Author: Aaron Ponti

% LICENSE
%
% ImarisConnector is a simple commodity class that eases communication between 
% Imaris and MATLAB using the Imaris XT interface.
% Copyright (C) 2011  Aaron Ponti
% 
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

% Number of inputs (without the IceImarisConnector object)
if nargin ~= 2
    error('Bad number of input arguments.');
end

if ~isscalar(r_angle)
    error('r_angle must be a scalar.');
end

if numel(r_axis) ~= 3
    error('r_axis must be a 3-element vector.');
end

% Normalize
r_axis = IceImarisConnector.normalize(r_axis);

s = sin(r_angle/2);
x = r_axis(1) * s;
y = r_axis(2) * s;
z = r_axis(3) * s;
w = cos(r_angle/2);
q = [x y z w];

end
