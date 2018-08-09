function copyChannels(this, channelIndices)
% IceImarisConnector:  copyChannels (public method)
%
% DESCRIPTION
% 
%   This method copies one or more channels.
% 
% SYNOPSIS
% 
%   conn.copyChannels(channelIndices)
% 
% INPUT
% 
%   channelIndices: array of channel indices to be copied
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

% Is Imaris running?
if this.isAlive() == 0
    return
end

% Is there a Dataset?
iDataSet = this.mImarisApplication.GetDataSet();
if isempty(iDataSet)
    return
end

% Get dataset sizes
sz = this.getSizes();

% Some aliases
nChannels = sz(4);
nTimepoints = sz(5);

% Convert channel and timepoint to 0-based indexing
channelIndices = channelIndices - this.mIndexingStart;

if (any(channelIndices < 1 & (channelIndices > nChannels - 1)))
    error('Channel indices out of bound.');
end

% Collect channel names
channelNames = cell(1, nChannels);
for i = 1 : nChannels
    
    channelNames{i} = char(iDataSet.GetChannelName(i - 1));
    
end

% Copy the channels
for c = 1 : numel(channelIndices)

    % Add channel
    nChannels = nChannels + 1;
    iDataSet.SetSizeC(nChannels);

    % New channel index
    newChannelIndex = nChannels - 1;
        
    % Set the new channel name
    iDataSet.SetChannelName(newChannelIndex, ...
        ['Copy of ', channelNames{1 + channelIndices(c)}]);
    
    % Set the new channel color
    iDataSet.SetChannelColorRGBA(newChannelIndex, ...
        iDataSet.GetChannelColorRGBA(channelIndices(c)));


    for t = 1 : nTimepoints

        % Get stack
        stack = this.getDataVolume(channelIndices(c), t - 1);

        % Store channel
        this.setDataVolume(stack, newChannelIndex,  t - 1);

    
    end
    
end