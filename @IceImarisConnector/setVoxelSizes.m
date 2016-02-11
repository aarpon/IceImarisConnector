function setVoxelSizes(this, voxelSizes)
% IceImarisConnector:  setVoxelSizes (public method)
%
% DESCRIPTION
% 
%   This method sets the X, Y, and Z voxel sizes of the dataset. It does 
%   not move the min extends.
% 
% SYNOPSIS
%
%   conn.setVoxelSizes(voxelSizex)
% 
% INPUT
% 
%   voxelSizes : voxel sizes in dataset units: [voxelSizeX voxelSizeY voxelSizeZ]
% 
% OUTPUT
%
%   None

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

if nargin ~=2
    error('One input parameter expected.');
end

if any(size(voxelSizes) ~= [1 3])
    error('voxelSizes must be in the form [voxelSizeX voxelSizeY voxelSizeZ].');
end

% Is Imaris running?
if this.isAlive() == 0
    return
end

% Check whether we have a dataset at all
aDataSet = this.mImarisApplication.GetDataSet();
if isempty(aDataSet)
    return;
end

% Voxel size X
aDataSet.SetExtendMaxX(...
    voxelSizes(1) * aDataSet.GetSizeX() + aDataSet.GetExtendMinX());

% Voxel size Y
aDataSet.SetExtendMaxY(...
    voxelSizes(2) * aDataSet.GetSizeY() + aDataSet.GetExtendMinY());

% Voxel size Z
aDataSet.SetExtendMaxZ(...
    voxelSizes(3) * aDataSet.GetSizeZ() + aDataSet.GetExtendMinZ());
