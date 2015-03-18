function slice = getDataSlice(this, plane, channel, timepoint, iDataSet)
% IceImarisConnector:  getDataVolume (public method)
% 
% DESCRIPTION
% 
%   This method returns a data slice from Imaris.
% 
% SYNOPSIS
% 
%   (1) slice = conn.getDataSlice(plane, channel, timepoint)
%   (2) slice = conn.getDataSlice(plane, channel, timepoint, iDataSet)
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

% Make sure that there is no mismatch with indexingStart
if plane < 1 && this.mIndexingStart == 1
    error('Plane cannot be < 1 if indexingStart is 1.');
end
if channel < 1 && this.mIndexingStart == 1
    error('Channel cannot be < 1 if indexingStart is 1.');
end
if timepoint < 1 && this.mIndexingStart == 1
    error('Timepoint cannot be < 1 if indexingStart is 1.');
end
    
% Initialize slice
slice = [];

if this.isAlive() == 0
    return
end

if nargin == 4
    iDataSet = this.mImarisApplication.GetDataSet();
else
    % Is the passed dataset a valid DataSet?
    if ~this.mImarisApplication.GetFactory().IsDataSet(iDataSet)
        error('Invalid IDataSet object.');
    end
end

% Check whether we have some voxels in the dataset
if isempty(iDataSet) || iDataSet.GetSizeX() == 0
    return
end

% Convert plane, channel and timepoint to 0-based indexing
plane = plane - this.mIndexingStart;
channel = channel - this.mIndexingStart;
timepoint = timepoint - this.mIndexingStart;

% Check that the requested plane, channel and timepoint exist
if plane > (iDataSet.GetSizeZ() - 1)
    error('The requested plane is out of bounds.');
end
if channel > (iDataSet.GetSizeC() - 1)
    error('The requested channel index is out of bounds.');
end
if timepoint > (iDataSet.GetSizeT() - 1)
    error('The requested time index is out of bounds.');
end

% Get the dataset class
switch char(iDataSet.GetType())
    case 'eTypeUInt8',   datatype = 'uint8';
    case 'eTypeUInt16',  datatype = 'uint16';
    case 'eTypeFloat',   datatype = 'single';
    otherwise,
        error('Bad value for IDataSet::GetType().');
end

% Allocate memory
slice = zeros([iDataSet.GetSizeX(), iDataSet.GetSizeY(), 1], datatype);

% Get the slice
switch char(iDataSet.GetType())
    case 'eTypeUInt8',   
        % Java does not have unsigned ints
        arr = iDataSet.GetDataSliceBytes(plane, channel, timepoint);
        slice(:) = typecast(arr(:), 'uint8');
    case 'eTypeUInt16',
        % Java does not have unsigned ints
        arr = iDataSet.GetDataVolumeShorts(plane, channel, timepoint);
        slice(:) = typecast(arr(:), 'uint16');
    case 'eTypeFloat',
        slice(:) = ...
            iDataSet.GetDataVolumeFloats(plane, channel, timepoint);
    otherwise,
        error('Bad value for iDataSet.GetType().');
end

end
