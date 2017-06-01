function q = multiplyQuaternions(q1, q2)
% IceImarisConnector:  multiplyQuaternions (static public method)
%
% DESCRIPTION
% 
%   This method multiplies two quaternions.
% 
% SYNOPSIS
% 
%   q = multiplyQuaternions(q1, q2)
% 
% INPUT
% 
%   q1 : first quaternion
%   q2 : second quaternion
% 
% OUTPUT
% 
%   q  : resulting quaternion
%
% AUTHORS
%
% Author: Igor Beati
% Contributor: Aaron Ponti

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

if numel(q1) ~= 4
    error('q1 must be a 4-element vector.');
end

if numel(q2) ~= 4
    error('q2 must be a 4-element vector.');
end

% Normalize
q1 = IceImarisConnector.normalize(q1);
q2 = IceImarisConnector.normalize(q2);

% Multiply the quaternions
q = [ q1(1) * q2(4) + q1(2) * q2(3) - q1(3) * q2(2) + q1(4) * q2(1), ...
     -q1(1) * q2(3) + q1(2) * q2(4) + q1(3) * q2(1) + q1(4) * q2(2), ...
      q1(1) * q2(2) - q1(2) * q2(1) + q1(3) * q2(4) + q1(4) * q2(3), ...
     -q1(1) * q2(1) - q1(2) * q2(2) - q1(3) * q2(3) + q1(4) * q2(4) ];
   
end
