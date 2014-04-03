function [tracks, startTimes] = getTracks(this, iSpots)
% Imaris Connector:  getTracks (public method)
% 
% DESCRIPTION
% 
%   This method returns the tracks associated to an iSpots object. If no
%   iSpots objects is passed as argument, the function will try with the
%   currently selected object in the Surpass Scene. If this is not an
%   iSpots object, an empty result set will be returned.
% 
% SYNOPSIS
% 
%   (1) [tracks, startTimes] = getTracks(iSpots)
%   (2) [tracks, startTimes] = getTracks()
% 
% INPUT
% 
%   iSpots   : (optional) an iSpots object. If not passed, the function
%              will try with the currently selected object in the Surpass 
%              Scene.
% 
% OUTPUT
% 
%   tracks    : cell array with tracks. Empty if no tracks exist for the
%               iSpots object or if the argument is not an iSpots object.
%               Each track is in the form [x y z]n, were n is the length 
%               of the track.
%   startTimes: time index of the beginning of each track: please notice
%               that the indexing is either 0- or 1- based depending on
%               the value of the indexingStart argument passed to the 
%               IceImarisConnector. Default is 0-based.
%
% SEE
%
%   help IceImarisConnector

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

if this.isAlive() == 0
    return
end

% Check the input parameter
if nargin == 1
    
    % Try to get the currently selected object in the Surpass Scene
    iSpots = this.getSurpassSelection('Spots');

end

% Check that we have a valid iSpots object
try
    if this.mImarisApplication.GetFactory().IsSpots(iSpots) == 0
        error('Spots object required.');
    end
catch
    error('Spots object required.');
end

% Now extract the tracks
% Get the IDs of the tracks
ids     = iSpots.GetTrackIds;
uids    = unique(ids);
nTracks = numel(uids);

% Get all spot positions and the track edges
positions  = iSpots.GetPositionsXYZ;
timeIndices = iSpots.GetIndicesT;
trackEdges = iSpots.GetTrackEdges;

% Now extract one track after the other and store them into a cell array
tracks = cell(1, nTracks);
startTimes = zeros(1, nTracks);
for i = 1 : nTracks
    
    % Get the positions and edges for current track (id) (1-based)
    edges = (trackEdges(ids == uids(i), :) + 1)';
    edges = unique(edges(:));

    % Extract and store the track and the initial time index
    tracks{i} = positions(edges, :);
    startTimes(i) = this.indexingStart + timeIndices(edges(1));
   
end


end
