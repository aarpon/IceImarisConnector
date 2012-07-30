function voxelSizes = getVoxelSizes( this )
% IceImarisConnector:  getVoxelSizes (public method)
%
% DESCRIPTION
% 
%   This method returns the X, Y, and Z voxel sizes of the dataset.
% 
% SYNOPSIS
% 
%   voxelSizes = conn.getVoxelSizes( )
% 
% INPUT
% 
%   None
% 
% OUTPUT
% 
%   voxelSizes : vector of voxel sizes, [ voxelX voxelY voxelZ ]  

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

% Initialize voxel sizes
voxelSizes = [ ];

% Is Imaris running?
if this.isAlive() == 0
    return
end

% Check whether we have a dataset at all
if this.mImarisApplication.GetDataSet.GetSizeX == 0
    return;
end

% We do, so let's calculate the voxel size
voxelSizes = [ 0 0 0 ];

% Voxel size X
voxelSizes( 1 ) = ...
    ( this.mImarisApplication.GetDataSet.GetExtendMaxX - ...
    this.mImarisApplication.GetDataSet.GetExtendMinX ) / ...
    this.mImarisApplication.GetDataSet.GetSizeX;

% Voxel size Y
voxelSizes( 2 ) = ...
    ( this.mImarisApplication.GetDataSet.GetExtendMaxY - ...
    this.mImarisApplication.GetDataSet.GetExtendMinY ) / ...
    this.mImarisApplication.GetDataSet.GetSizeY;

% Voxel size Z
voxelSizes( 3 ) = ...
    ( this.mImarisApplication.GetDataSet.GetExtendMaxZ - ...
    this.mImarisApplication.GetDataSet.GetExtendMinZ ) / ...
    this.mImarisApplication.GetDataSet.GetSizeZ;

end
