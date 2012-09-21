function stack = getDataVolume(this, channel, timepoint, iDataset)
% IceImarisConnector:  getDataVolume (public method)
% 
% DESCRIPTION
% 
%   This method returns the data volume from Imaris.
% 
% SYNOPSIS
% 
%   (1) stack = conn.getDataVolume(channel, timepoint)
%   (2) stack = conn.getDataVolume(channel, timepoint, iDataset)
% 
% INPUT
% 
%   channel  : channel number (0/1-based depending on indexing start)
%   timepoint: timepoint number (0/1-based depending on indexing start)
%   dataset  : (optional) get the data volume from the passed IDataset
%               object instead of current one; if omitted, current dataset
%               (i.e. this.mImarisApplication.GetDataSet()) will be used.
%               This is useful for instance when masking channels.
% 
% OUTPUT
% 
%   stack    : data volume (3D matrix)
%
% REMARK
%
%   This function gets the volume as a 1D array and reshapes it in place.
%   It also performs a type cast to take care of the signed/unsigned int
%   mismatch when transferring data over Ice. The spped-up compared to
%   calling the ImarisXT GetDataVolumeBytes() or GetDataVolumeWords() 
%   methods is of the order of 20x.

% AUTHORS
%
% Author: Aaron Ponti
% Contributor: Jonas Dorn

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

if nargin < 3 || nargin > 4
    % The this parameter is hidden
    error('2 or 3 input parameters expected.');
end

% Initialize stack
stack = [];

if this.isAlive() == 0
    return
end

if nargin == 3
    iDataset = this.mImarisApplication.GetDataSet();
else
    % Is the passed dataset a valid DataSet?
    if ~this.mImarisApplication.GetFactory.IsDataSet(iDataset)
        error('Invalid IDataset object.');
    end
end

% Check whether we have some voxels in the dataset
if isempty(iDataset) || iDataset.GetSizeX() == 0
    return
end

% Get the dataset class
switch char(iDataset.GetType())
    case 'eTypeUInt8',   datatype = 'uint8';
    case 'eTypeUInt16',  datatype = 'uint16';
    case 'eTypeFloat',   datatype = 'single';
    otherwise,
        error('Bad value for IDataSet::GetType().');
end

% Allocate memory
stack = zeros([iDataset.GetSizeX(), iDataset.GetSizeY(), ...
    iDataset.GetSizeZ()], datatype);

% Get the stack
switch char(iDataset.GetType())
    case 'eTypeUInt8',   
        % Java does not have unsigned ints
        arr = iDataset.GetDataVolumeAs1DArrayBytes(...
            channel - this.mIndexingStart, ...
            timepoint - this.mIndexingStart);
        stack(:) = typecast(arr, 'uint8');
    case 'eTypeUInt16',
        % Java does not have unsigned ints
        arr = iDataset.GetDataVolumeAs1DArrayShorts(...
            channel - this.mIndexingStart, ...
            timepoint - this.mIndexingStart);
        stack(:) = typecast(arr, 'uint16');
    case 'eTypeFloat',
        stack(:) = iDataset.GetDataVolumeAs1DArrayFloats(...
            channel - this.mIndexingStart, ...
            timepoint - this.mIndexingStart);
    otherwise,
        error('Bad value for iDataset.GetType().');
end

end
