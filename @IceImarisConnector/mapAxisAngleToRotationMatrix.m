function [R, x_axis, y_axis, z_axis] = mapAxisAngleToRotationMatrix(r_axis, r_angle)
% IceImarisConnector:  mapAxisAngleToRotationMatrix (static public method)
%
% DESCRIPTION
%
%   This method calculates the 3D rotation matrix for an angle and an
%   axis of rotatoin.
%
% SYNOPSIS
%
%   [R, x_axis, y_axis, z_axis] = mapAxisAngleToRotationMatrix(r_axis, r_angle)
%
% INPUT
%
%   r_axis  : axis of rotation, e.g. [0 1 0]
%   r_angle : angle in radians
%
% OUTPUT
%
%   R     : rotation in matrix form
%   x_axis: x axis of the rotation coordinate system
%   y_axis: y axis of the rotation coordinate system
%   z_axis: z axis of the rotation coordinate system
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

if numel(r_axis) ~= 3
    error('r_axis must be a 3-element vector.');
end

if ~isscalar(r_angle)
    error('r_angle must be a scalar.');
end

% Make sure the vector is normalized
r_axis = IceImarisConnector.normalize(r_axis);

% Pre-compute some values
ux = r_axis(1);
ux2 = ux * ux;
uy = r_axis(2);
uy2 = uy * uy;
uz = r_axis(3);
uz2 = uz * uz;
ca = cos(r_angle);
uca = 1 - ca;
sa = sin(r_angle);
ux_uy_uca = ux * uy * uca;
ux_uz_uca = ux * uz * uca;
uy_uz_uca = uy * uz * uca;

% Rotation  matrix by r_angle around the normal vector r_axis
R = [ca + ux2*uca, ux_uy_uca - uz*sa, ux_uz_uca + uy*sa;
    ux_uy_uca + uz*sa, ca + uy2*uca, uy_uz_uca - ux*sa;
    ux_uz_uca - uy*sa, uy_uz_uca + ux*sa, ca + uz2*uca];

R(4, 4) = 1;

x_axis = R(1:3, 1);
y_axis = R(1:3, 2);
z_axis = R(1:3, 3);

end
