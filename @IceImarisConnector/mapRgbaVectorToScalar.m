function rgbaScalar = mapRgbaVectorToScalar( rgbaVector )
% IceImarisConnector:  mapRgbaVectorToScalar (static public method)
%
% DESCRIPTION
%
%   This method maps an RGBA vector to a scalar
%
% SYNOPSIS
%
%   rgbaScalar = mapRgbaVectorToScalar( rgbaVector )
%
% INPUT
%
%   rgbaVector: 1-by-4 array with [R G B A] indicating (R)ed, (G)reen,
%               (B)lue, and (A)lpha (=transparency; 0 is opaque)
%
% OUTPUT
%
%   rgbaScalar: int32 scalar number coding for RGBA (for Imaris use)

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
if ~isvector(rgbaVector) || length(rgbaVector)~=4 || any(rgbaVector<0)...
        || any(rgbaVector) > 1
    error('RGBA-vector has to be 1-by-4 with all elements between 0 and 1')
end

rgbaVector = round(rgbaVector * 255); % need integer values scaled to range 0-255
rgbaScalar = uint32(rgbaVector * 256.^(0:3)' ); % combine different components (four bytes) into one integer
