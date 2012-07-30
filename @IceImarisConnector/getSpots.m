function spotStruct = getSpots( this )
% IceImarisConnector:  getSpots (public method)
% 
% DESCRIPTION
% 
%   This method returns all spots from the Surpass Scene.
% 
% SYNOPSIS
% 
%   spotStruct = conn.getSpots
% 
% INPUT
% 
%   none
% 
% OUTPUT
% 
%   spotStruct : k-by-1 array of structures with an entry for
%                each spots object. The structure has the following fields:
%          .coords : n-by-3 array of coordinates (xyz) in
%               the unit defined in Imaris' ImageProperties.
%          .t      : time index for the coordinates. Either a
%               scalar, or an n-by-1 array with timeIdx for every
%               coordinate. 0- or 1-based counting depending on
%               indexing start. 
%          .name   : string with the name of the spots object.
%          .radius : radius of the spots. Either a scalar, or an n-by-1
%               array with radius for every coordinate. 
%          .color  : [R G B A] array indicating (R)ed, (G)reen,
%               (B)lue, and (A)lpha (=transparency; 0 is opaque) of the
%               spots. 
%          .edges : n-by-2 array of spot indices (0 or 1-based, depending
%               on indexing start) that are connected by a line.

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


% Initialize output
spotStruct = struct('coords',[],'t',[],'name','','radius',[],'color',[]);

if this.isAlive( ) == 0
    return
end

% get all children of the surpass scene
children = this.getAllSurpassChildren;
nChildren = length(children);

if nChildren == 0
    return
end

% loop over children to identify spots, read their info

% pseudo-preassign
spotStruct(nChildren).coords = [];

spotCt = 0;

for iChild = 1:nChildren
    
    % try to convert to spot
    vSpot = this.mImarisApplication.GetFactory.ToSpots(children{iChild});
    
    if ~isempty(vSpot)
        spotCt = spotCt + 1;
        
        spotStruct(spotCt).coords = vSpot.GetPositionsXYZ;
        spotStruct(spotCt).t = double(vSpot.GetIndicesT + this.mIndexingStart);
        spotStruct(spotCt).name = vSpot.GetName;
        spotStruct(spotCt).name = char(spotStruct(spotCt).name);
        spotStruct(spotCt).radius = vSpot.GetRadii;
        spotStruct(spotCt).color = ...
            IceImarisConnector.mapRgbaScalarToVector(vSpot.GetColorRGBA);
        spotStruct(spotCt).edges = vSpot.GetTrackEdges;
        
    end
end

spotStruct(spotCt+1:end) = [];
