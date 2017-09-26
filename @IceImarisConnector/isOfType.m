function b = isOfType(this, object, type)
% IceImarisConnector:  isOfType (private method)
%
% DESCRIPTION
% 
%   This method checks that a passed object is of a given type.
% 
% SYNOPSIS
% 
%   b = conn.isOfType(object, type)
% 
% INPUT
% 
%   object : any surpass scene object
%
%   type   : one of:
%
%               'Cells'
%               'ClippingPlane'
%               'Dataset'
%               'Filaments'
%               'Frame'
%               'LightSource'
%               'MeasurementPoints'
%               'Spots'
%               'Surfaces'
%               'SurpassCamera'
%               'Volume'
% 
% OUTPUT
% 
%   b : 1 if the object is of the type specified, 0 otherwise

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

% Check input parameters number and values
if nargin ~= 3
    error('2 input parameters expected.');
end

% Check type
typeValues = {'Cells', 'ClippingPlane', 'Dataset', 'Filaments', ...
    'Frame', 'LightSource', 'MeasurementPoints', 'ReferenceFrames', ...
    'Spots', 'Surfaces', 'SurpassCamera', 'Volume'};
if ~ismember(type, typeValues)
    error('Bad value for input parameter ''type''.');
end

% Test the object
factory = this.mImarisApplication.GetFactory();

switch type
    case 'Cells'
        b = factory.IsCells(object);
    case 'ClippingPlane'
        b = factory.IsClippingPlane(object);
    case 'Dataset'
        b = factory.IsDataset(object);
    case 'Filaments'
        b = factory.IsFilaments(object);
    case 'Frame'
        b = factory.IsFrame(object);
    case 'LightSource'
        b = factory.IsLightSource(object);
    case 'MeasurementPoints'
        b = factory.IsMeasurementPoints(object);
    case 'Spots'
        b = factory.IsSpots(object);
    case 'Surfaces'
        b = factory.IsSurfaces(object);
    case 'SurpassCamera'
        b = factory.IsSurpassCamera(object);
    case 'Volume'
        b = factory.IsVolume(object);
    case 'ReferenceFrames'
        % The factory does not have a Is...() method for reference frames
        b = ~isempty(factory.ToReferenceFrames(object));
    otherwise
        error('Bad value for ''type''.');
end

end
