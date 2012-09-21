function extends = getExtends(this)
% IceImarisConnector:  getExtends (public method)
%
% DESCRIPTION
% 
%   This method returns the dataset extends.
% 
% SYNOPSIS
% 
%   extends = conn.getExtends()
% 
% INPUT
% 
%   None
% 
% OUTPUT
% 
%   extends : vector of extends, [minX maxX minY maxY minZ maxZ]  

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

extends = [];

% Is Imaris running?
if this.isAlive() == 0
    return
end

% Check whether we have some voxels in the dataset
if this.mImarisApplication.GetDataSet.GetSizeX() == 0
    return
end

% Return the extends
extends = [
    this.mImarisApplication.GetDataSet.GetExtendMinX(), ...
    this.mImarisApplication.GetDataSet.GetExtendMaxX(), ...
    this.mImarisApplication.GetDataSet.GetExtendMinY(), ...
    this.mImarisApplication.GetDataSet.GetExtendMaxY(), ...
    this.mImarisApplication.GetDataSet.GetExtendMinZ(), ...
    this.mImarisApplication.GetDataSet.GetExtendMaxZ()
   ];

end
