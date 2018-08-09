function [tracks, startTimes] = getTracks(this, iObject)
% IceImarisConnector:  getTracks (public method)
% 
% DESCRIPTION
% 
%   This method returns the tracks associated to an ISpots or an ISurfaces
%   object. If no object is passed as argument, the function will try with
%   the currently selected object in the Surpass Scene. If this is not an
%   ISpots nor an ISurfaces object, an empty result set will be returned.
% 
% SYNOPSIS
% 
%   (1) [tracks, startTimes] = getTracks(iObject)
%   (2) [tracks, startTimes] = getTracks()
% 
% INPUT
% 
%   iObject : (optional) either an ISpots or an ISurfaces object. If not
%             passed, the function will try with the currently selected
%             object in the Surpass Scene.
% 
% OUTPUT
% 
%   tracks    : cell array with tracks. Empty if no tracks exist for the
%               object or if the argument is not an ISpots or an 
%               ISurfaces object.
%               Each track is in the form [x y z]n, were n is the length 
%               of the track.
%   startTimes: time index of the beginning of each track: please notice
%               that the indexing is either 0- or 1- based depending on
%               the value of the indexingStart argument passed to the 
%               IceImarisConnector. Default is 0-based.
%
% SEE
%
%   help IceImarisConnector (for indexingStart)

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

if nargin > 2
    % The this parameter is hidden
    error('0 or 1 input parameters expected.');
end

% Initialize tracks and timeIndices
tracks = {};
startTimes = [];

% Do we have an open connection?
if this.isAlive() == 0
    return
end

% No input parameter passed, we get current selection
if nargin == 1
    
    % Try to get the currently selected object in the Surpass Scene. We
    % do not cast it, otherwise we cannot use the Is...() Factory()
    % methods.
    iObject = this.mImarisApplication.GetSurpassSelection();
    if isempty(iObject)
        error(['If no object is passed to the function, then either ', ...
            'an ISpots or an ISurfaces object must be selected in ', ...
            'the Surpass Scene.']);
    end       

end

% Now we check the type of the iObject

% If we got a base Imaris.IDataItemPrxHelper object we cast it.
if isa(iObject, 'Imaris.IDataItemPrxHelper')
    iObject = this.autocast(iObject);
    if isempty(iObject)
        error('Expected ISpots or ISurfaces object.');
    end
end

% Now we check the class of the specialized type.
if ~isa(iObject, 'Imaris.ISurfacesPrxHelper') && ...
        ~isa(iObject, 'Imaris.ISpotsPrxHelper')
    error('Expected ISpots or ISurfaces object.');
end    


% Now extract the tracks

% Get the IDs of the tracks
ids = iObject.GetTrackIds();
if isempty(ids)
    return;
end
uids = unique(ids);
nTracks = numel(uids);

% Get all spot positions and the track edges
positions = getPositions(iObject);
timeIndices = getTimeIndices(iObject);
trackEdges = iObject.GetTrackEdges();

% Now extract one track after the other and store them into a cell array
tracks = cell(1, nTracks);
startTimes = zeros(1, nTracks);
for i = 1 : nTracks
    
    % Get the positions and edges for current track (id) (1-based)
    edges = trackEdges(ids == uids(i), :) + 1;
    edges = unique(edges(:));

    % Extract and store the track and the initial time index
    tracks{i} = positions(edges, :);
    startTimes(i) = this.indexingStart + timeIndices(edges(1));
   
end

% = Functions =============================================================

function positions = getPositions(iObject)   

% Get the positions for the object. Depending on the type, different
% methods will be needed.

if isa(iObject, 'Imaris.ISurfacesPrxHelper')
    
    % This is an ISurfaces object. We query each contained surface for its 
    % center of mass.
    nSurfaces = iObject.GetNumberOfSurfaces();
    positions = zeros(nSurfaces, 3);
    for i = 1 : nSurfaces
        positions(i, :) = iObject.GetCenterOfMass(i - 1);
    end
    
elseif isa(iObject, 'Imaris.ISpotsPrxHelper')
    
    % This is an ISPots object. We can get all positions in one shot.
    positions = iObject.GetPositionsXYZ();
    
else
    
    % Invalid object
    error('Either Spots or Surfaces object required.');

end

% -------------------------------------------------------------------------

function timeIndices = getTimeIndices(iObject)   

% Get the time indices for the object. Depending on the type, different
% methods will be needed.

if isa(iObject, 'Imaris.ISurfacesPrxHelper')

    % This is an ISurfaces object. We query each contained surface for its 
    % time indices.    
    nSufaces = iObject.GetNumberOfSurfaces();
    timeIndices = zeros(nSufaces, 1);
    for i = 1 : nSufaces
        timeIndices(i, :) = iObject.GetTimeIndex(i - 1);
    end
    
elseif isa(iObject, 'Imaris.ISpotsPrxHelper')
    
    % This is an ISPots object. We can get all time indices in one shot.
    timeIndices = iObject.GetIndicesT();
    
else
    
    % Invalid object
    error('Either Spots or Surfaces object required.');

end
    

