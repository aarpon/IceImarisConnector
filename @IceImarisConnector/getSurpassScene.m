function vSurpassScene = getSurpassScene( this, mode, checkVolume )
% IceImarisConnector:  getSurpassScene (public method)
%
% DESCRIPTION
%
%   This method returns the surpass scene, or creates a new one if none
%   exists
%
% SYNOPSIS
%
%   vSurpassScene = conn.getSurpassScene( mode, checkVolume )
%
% INPUT
%
%   mode : (Optional) behavior in case no surpass scene currently exists
%       'create' : create surpass scene if none exists yet. The default.
%                  This will also start a new Imaris session, if needed.
%       'empty'  : getSurpassScene returns empty if no scene exists
%       'error'  : getSurpassScene throws an error if no scene exists
%   checkVolume : (Optional) if 1, a test is also made for whether the
%       volume exists. If there is no volume, 'create' adds it, 'empty'
%       does nothing, and 'error' throws an error. Default: 1
%
% OUTPUT
%
%   vSurpassScene: surpass-scene object

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

if nargin < 2 || isempty(mode)
    mode = 'create';
end
if nargin < 3 || isempty(checkVolume)
    checkVolume = true;
end

switch lower(mode)
    case 'create'
        if ~this.isAlive
            this.startImaris;
        end
        
        vSurpassScene = this.mImarisApplication.GetSurpassScene;
        
        if isempty(vSurpassScene)
            
            vSurpassScene = this.mImarisApplication.GetFactory.CreateDataContainer;
            % Add a light source
            vLightSource = this.mImarisApplication.GetFactory.CreateLightSource;
            % Add a frame
            vFrame = this.mImarisApplication.GetFactory.CreateFrame;
            
            % Set up the surpass scene
            this.mImarisApplication.SetSurpassScene(vSurpassScene);
            vSurpassScene.AddChild(vLightSource, -1);
            vSurpassScene.AddChild(vFrame, -1);
            
        end
        
    case 'empty'
        
        % this is the default Imaris behavior
        if ~this.isAlive
            vSurpassScene = [];
        else
            vSurpassScene = this.mImarisApplication.GetSurpassScene;
        end
        
    case 'error'
        
        vSurpassScene = this.getSurpassScene('empty');
        if isempty(vSurpassScene)
            error('no surpass scene found')
        end
        
    otherwise
        error('mode %s is not recognized',mode)
end

% check for volume
if checkVolume && ~isempty(vSurpassScene)
    
    children = this.getAllSurpassChildren;
    
    foundVolume = false;
    iChild = 1;
    
    while iChild <= length(children) && ~foundVolume
        
        % try and convert child to volume
        vol = this.mImarisApplication.GetFactory.ToVolume(children{iChild});
        
        if ~isempty(vol)
            foundVolume = true;
        else
            iChild = iChild + 1;
        end
    end
    
    if ~foundVolume
        switch lower(mode)
            case 'create'
                % add volume
                vVolume = this.mImarisApplication.GetFactory.CreateVolume;
                vSurpassScene.AddChild(vVolume,-1);
                
            case 'empty'
                
                % do nothing
                
            case 'error'
                
                % fail
                error('no volume present')
                
        end
    end
end
