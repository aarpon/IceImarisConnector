function [R, x_axis, y_axis, z_axis] = mapQuaternionToRotationMatrix(quaternion)
% IceImarisConnector:  mapQuaternionToRotationMatrix (static public method)
%
% DESCRIPTION
% 
%   This method converts a quaternion to a rotation matrix.
% 
% SYNOPSIS
% 
%   [R, x_axis, y_axis, z_axis] = mapQuaternionToRotationMatrix(quaternion)
% 
% INPUT
% 
%   q : quaternion
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
if nargin ~= 1
    error('Bad number of input arguments.');
end

if numel(quaternion) ~= 4
    error('quaternion must be a 4-element vector.');
end

% Normalize
quaternion = IceImarisConnector.normalize(quaternion);

% Build the rotation matrix
R = zeros(4, 4);

% Alias
X = quaternion(1);
Y = quaternion(2);
Z = quaternion(3);
W = quaternion(4);

x2 = X + X;    y2 = Y + Y;    z2 = Z + Z;
xx = X * x2;   xy = X * y2;   xz = X * z2;
yy = Y * y2;   yz = Y * z2;   zz = Z * z2;
wx = W * x2;   wy = W * y2;   wz = W * z2;

R(1, 1) = 1.0 - (yy + zz);
R(1, 2) = xy - wz;
R(1, 3) = xz + wy;

R(2, 1) = xy + wz;
R(2, 2) = 1.0 - (xx + zz);
R(2, 3) = yz - wx;

R(3, 1) = xz - wy;
R(3, 2) = yz + wx;
R(3, 3) = 1.0 - (xx + yy);

R(4, 4) = 1;

x_axis = R(1:3, 1)';
y_axis = R(1:3, 2)';
z_axis = R(1:3, 3)';

end
