function q = calcRotationBetweenVectors3D(start, dest)
% IceImarisConnector:  calcRotationBetweenVectors3D (static public method)
%
% DESCRIPTION
%
%   This method calculates the rotation needed to bring a 3D vector on
%   top of another.
%
%   Re-implemented with variations from:
%   http://www.opengl-tutorial.org/intermediate-tutorials/tutorial-17-quaternions/
%
% SYNOPSIS
%
%   q = calcRotationBetweenVectors3D(start, dest)
%
% INPUT
%
%   start : starting 3D vector
%   dest  : target 3D vector
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

if numel(start) ~= 3
    error('start must be a 3-element vector.');
end

if numel(dest) ~= 3
    error('start must be a 3-element vector.');
end

% Normalize
start = IceImarisConnector.normalize(start);
dest = IceImarisConnector.normalize(dest);

% Calculate angle
cosTheta = dot(start, dest);

% Make sure to handle extreme cases
if cosTheta < (-1 + 0.001)
    % Special case when vectors in opposite directions:
    % there is no "ideal" rotation axis
    % So guess one; any will do as long as it's perpendicular to start
    rotationAxis = cross([0, 0, 1], start);
    
    if norm(rotationAxis, 2) < 0.1
        % The vector where parallel; try again
        rotationAxis = cross([1, 0, 0], start);
    end
    
    rotationAxis = IceImarisConnector.normalize(rotationAxis);
    
    q = IceImarisConnector.mapAxisAngleToQuaternion(rotationAxis, pi);
   
    return;
    
end

% The angle should not give problems
rotationAxis = cross(start, dest);

% Build the quaternion
s = sqrt((1 + cosTheta) * 2);
invs = 1 / s;
q = [ ...
    rotationAxis(1) * invs, ...
    rotationAxis(2) * invs, ...
    rotationAxis(3) * invs, ...
    s * 0.5];

end

