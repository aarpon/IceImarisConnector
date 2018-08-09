function v = normalize(v, epsilon)
% IceImarisConnector:  normalize (static public method)
%
% DESCRIPTION
%
%   This method normalizes a vector (to length 1).
%
%   However, if the length of the vector is approximately zero,
%   a zero-vector of the length of the original vector will be returned.
%
% SYNOPSIS
%
%   v = normalize(v, epsilon)
%
% INPUT
%
%   v      : vector of length n
%   epsilon: (optional, default = 1e-8 min length to consider the vector 
%            of zero length. 
%
% OUTPUT
%
%   v : normalized vector (to length 1); or zero-vector if origianl 
%       length was approximately zero.
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
if nargin < 1 || nargin > 2
    error('Bad number of input arguments.');
end

if nargin == 1
    epsilon = 1e-8;
end

% Make sure v is a row vector
v = v(:)';

% Normalize
n_v = norm(v, 2);
if n_v < epsilon
    v = zeros(1, numel(v));
else
    v = v ./ n_v;
end

end

