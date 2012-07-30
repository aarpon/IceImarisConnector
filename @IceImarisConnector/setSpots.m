function setSpots( this, spotStruct )
% IceImarisConnector:  setSpots (public method)
%
% DESCRIPTION
%
%   This method adds spot objects to Imaris
%
% SYNOPSIS
%
%   conn.setSpots( spotStruct )
%
% INPUT
%
%   spotStruct : structure, or array of structures, defining the
%          spots object(s) to be added to the Imaris scene.
%          spotStruct supports the following fields:
%          .coords : n-by-3 array of coordinates (xyz) in
%               the unit defined in Imaris' ImageProperties.
%               Mandatory field. Can be empty.
%          .t      : time index for the coordinates. Either a
%               scalar, or an n-by-1 array with timeIdx for every
%               coordinate. 0- or 1-based counting depending on
%               indexing start. Optional field. Default: 0/1
%          .name   : string with the name of the spots object.
%               Optional field. Default: "spots #", where # is replaced by
%               the element number of the struct in the spotStruct array.
%          .radius : radius of the spots. Either a scalar, or an n-by-1
%               array with radius for every coordinate. Optional field.
%               Default: 1
%          .color  : [R G B] or [R G B A] array indicating (R)ed, (G)reen,
%               (B)lue, and (A)lpha (=transparency; 0 is opaque) of the
%               spots. All values must be between 0 and 1. Optional field.
%               Default: [1 0 0 0] (red spots)
%          .edges : n-by-2 array of spot indices (0 or 1-based, depending
%               on indexing start) that should be connected by a
%               line.
%
%
% OUTPUT
%
%   none

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

% define defaults
def.coords = [];
def.t = this.mIndexingStart;
def.radius = 1;
def.color = [1 0 0 0];
def.name = [];
def.edges = [];

if nargin < 2 || isempty(spotStruct) || ~isfield(spotStruct,'coords')...
        % The this parameter is hidden
    error( 'Please supply a structure with field "coords" as input' );
end

if this.isAlive( ) == 0
    return
end

% find number of spots objects, number of spots
nSpotObj = length(spotStruct);
nSpots = arrayfun(@(x)size(x.coords,1),spotStruct);


% parse spotStruct, and add fields if necessary
defNames = fieldnames(def);
for fn = defNames'
    for iSpotObj = 1:nSpotObj
        if ~isfield(spotStruct(iSpotObj),fn{1}) || isempty(spotStruct(iSpotObj).(fn{1}))
            spotStruct(iSpotObj).(fn{1}) = def.(fn{1});
        end
        % perform additional checks
        switch fn{1}
            case 't'
                if isscalar(spotStruct(iSpotObj).t)
                    spotStruct(iSpotObj).t = repmat(spotStruct(iSpotObj).t,nSpots(iSpotObj),1);
                elseif length(spotStruct(iSpotObj).t) ~= nSpots(iSpotObj)
                    error('unequal number of spot coordinates and timepoints (#%i: %i vs %i)',...
                        iSpotObj,nSpots(iSpotObj),length(spotStruct(iSpotObj).t))
                end
                
                % convert t to zero-based indexing
                spotStruct(iSpotObj).t = spotStruct(iSpotObj).t - this.mIndexingStart;
                
            case 'radius'
                if isscalar(spotStruct(iSpotObj).radius)
                    spotStruct(iSpotObj).radius = repmat(spotStruct(iSpotObj).radius,nSpots(iSpotObj),1);
                elseif length(spotStruct(iSpotObj).radius) ~= nSpots(iSpotObj)
                    error('unequal number of spot coordinates and radii (#%i: %i vs %i)',...
                        iSpotObj,nSpots(iSpotObj),length(spotStruct(iSpotObj).radius))
                end
            case 'color'
                switch length(spotStruct(iSpotObj).color)
                    case 3
                        spotStruct(iSpotObj).color(end+1) = 1;
                    case 4
                        % all is well
                    otherwise
                        error('color must be a 3 or 4 element vector')
                end
            case 'name'
                if isempty(spotStruct(iSpotObj).name)
                    spotStruct(iSpotObj.name) = sprintf('Spots %i',iSpotObj);
                end
            case 'edges'
                if ~isempty(spotStruct(iSpotObj).edges)
                    if size(spotStruct(iSpotObj).edges)  ~= 2
                        error('edges needs to be an arra with two columns')
                    end
                    % convert to 0-based indexing
                    spotStruct(iSpotObj).edges = ....
                        spotStruct(iSpotObj).edges - this.mIndexingStart;
                end
        end
        
    end
end


% write spots to Imaris
vSurpassScene = this.getSurpassScene('create');

for iSpotObj = 1:nSpotObj
    vSpots = this.mImarisApplication.GetFactory.CreateSpots;
    vSpots.Set(spotStruct(iSpotObj).coords, ...
        spotStruct(iSpotObj).t, spotStruct(iSpotObj).radius)
    vSpots.SetName(spotStruct(iSpotObj).name);
    
    % color has to be set as single number
    vRGBA = IceImarisConnector.mapRgbaVectorToScalar(...
        spotStruct(iSpotObj).color);
    vSpots.SetColorRGBA(vRGBA);
    
    % add edges
    vSpots.SetTrackEdges(spotStruct(iSpotObj).edges);
    
    % add to scene
    vSurpassScene.AddChild(vSpots,-1);
end

end
