function channelNames = getChannelNames(this)
% IceImarisConnector:  getChannelNames (public method)
%
% DESCRIPTION
% 
%   This method returns the channel names.
% 
% SYNOPSIS
% 
%   channelNames = conn.getChannelNames()
% 
% INPUT
% 
%   None
% 
% OUTPUT
% 
%   channelNames: cell array of channels names

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

% Initialize output
channelNames = {};

% Is Imaris running?
if this.isAlive() == 0
    return
end

% Is there a Dataset?
iDataSet = this.mImarisApplication.GetDataSet();
if isempty(iDataSet)
    return
end

% Number of channels
nChannels = iDataSet.GetSizeC();

% Initialize channelNames cell array
channelNames = cell(1, nChannels);

% Return the channel names
for c = 1 : nChannels
    
    channelNames{c} = char(iDataSet.GetChannelName(c - 1));
    
end
