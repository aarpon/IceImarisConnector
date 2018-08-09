function qc = quaternionConjugate(q)
% IceImarisConnector:  quaternionConjugate (static public method)
%
% DESCRIPTION
% 
%   This method returns the conjugate of a quanternion.
% 
% SYNOPSIS
% 
%   qc = quaternionConjugate(q)
% 
% INPUT
% 
%   q : quaternion [a b c d], or list of quaternions [a_i b_i c_i d_i]n
%       If q is an Nx4 matrix, it will be assumed that each row represent 
%       a quaternion (e.g. all quaternions for a time series). If the
%       quaternions are not normalized, they will be before the conjugate
%       is calculated.
% 
% OUTPUT
% 
%   qc  : conjugate quaternion(s)
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

% Prepare the output
qc = zeros(size(q));

% Calculate the conjugate (normalize if needed)
for i = 1 : size(q, 1)
    tmp = IceImarisConnector.normalize(q(i, :));
    qc(i, :) = [tmp(1), -tmp(2), -tmp(3), -tmp(4)]; 
end
