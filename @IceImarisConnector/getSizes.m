function sizes = getSizes( this )
% IceImarisConnector:  getSizes (public method)
%
% DESCRIPTION
% 
%   This method returns the dataset sizes.
% 
% SYNOPSIS
% 
%   sizes = conn.getSizes( )
% 
% INPUT
% 
%   None
% 
% OUTPUT
% 
%   sizes : vector of sizes, [ sizeX sizeY sizeZ sizeC sizeT ]  

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

% Is Imaris running?
if this.isAlive() == 0
    return
end

% Check whether we have some voxels in the dataset
if this.mImarisApplication.GetDataSet.GetSizeX == 0
    sizes = [ ];
    return
end

% Return the extends
sizes = [ 
    this.mImarisApplication.GetDataSet.GetSizeX, ...
    this.mImarisApplication.GetDataSet.GetSizeY, ...
    this.mImarisApplication.GetDataSet.GetSizeZ, ...
    this.mImarisApplication.GetDataSet.GetSizeC, ...
    this.mImarisApplication.GetDataSet.GetSizeT
    ];

end
