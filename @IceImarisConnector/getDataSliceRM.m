function slice = getDataSliceRM(this, plane, channel, timepoint, iDataset)
% IceImarisConnector:  getDataSliceRM (public method)
% 
% DESCRIPTION
% 
%   This method returns a data slice from Imaris in row-major order.
%
% SYNOPSIS
% 
%   (1) stack = conn.getDataSliceRM(plane, channel, timepoint)
%   (2) stack = conn.getDataSliceRM(plane, channel, timepoint, iDataSet)
% 
% INPUT
% 
%   plane    : slice number (0/1-based depending on indexing start)
%   channel  : channel number (0/1-based depending on indexing start)
%   timepoint: timepoint number (0/1-based depending on indexing start)
%   iDataSet : (optional) get the data volume from the passed IDataset
%              object instead of current one; if omitted, current dataset
%              (i.e. this.mImarisApplication.GetDataSet()) will be used.
%              This is useful for instance when masking channels.
% 
% OUTPUT
% 
%   slice    : data slice (2D matrix)
%
% REMARK
%
%   This function gets the slice as a 1D array and reshapes it in place.
%   It also performs a type cast to take care of the signed/unsigned int
%   mismatch when transferring data over Ice.
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

if nargin < 4 || nargin > 5
    % The this parameter is hidden
    error('3 or 4 input parameters expected.');
end

% Initialize slice
slice = [];

if this.isAlive() == 0
    return
end

% We let getDataVolume do the parameter checking
if nargin == 4
    slice = this.getDataSlice(plane, channel, timepoint);
else
    slice = this.getDataSlice(plane, channel, timepoint, iDataset);
end

% Now we permute the stack
slice = permute(slice, [2 1]);

end