function rgbaVector = mapRgbaScalarToVector( rgbaScalar )
% IceImarisConnector:  mapRgbaScalarToVector (static public method)
%
% DESCRIPTION
%
%   This method maps an RGBA vector to a scalar
%
% SYNOPSIS
%
%   rgbaScalar = mapRgbaVectorToScalar( rgbaScalar )
%
% INPUT
%
%   rgbaScalar: int32 scalar number coding for RGBA (for Imaris use)
%
% OUTPUT
%
%   rgbaVector: 1-by-4 array with [R G B A] indicating (R)ed, (G)reen,
%               (B)lue, and (A)lpha (=transparency; 0 is opaque)

% AUTHORS
%
% Author: Jonas Dorn

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

% check input
if ~isscalar(rgbaScalar) || isa(rgbaScalar,'uint32')
    error('RGBA-scalar has to be a scalar of class uint32')
end

rgbaVector = zeros(1,4);
for i=1:4
    % use bit-operators to extract information
    rgbaVector(i) = double(bitget(rgbaScalar,8:-1:1)) * 2.^(7:-1:0)';
    % shift the scalar by 8 bits
    rgbaScalar = bitshift(rgbaScalar,-8);
end

rgbaVector = rgbaVector / 255;
