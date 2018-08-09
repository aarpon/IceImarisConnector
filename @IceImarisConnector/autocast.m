function derivedType = autocast(this, IDataItem)
% IceImarisConnector:  autocast (public method)
% 
% DESCRIPTION
% 
%   This method casts IDataItems to their derived types
% 
% SYNOPSIS
% 
%   derivedType = conn.autocast(IDataItem)
% 
% INPUT
% 
%   IDataItem: an Imaris::IDataItem object
% 
% OUTPUT
% 
%   derivedType : one of the Imaris::IDataItem subclasses:
%                                 - Imaris::IClippingPlane
%                                 - Imaris::IDataContainer
%                                 - Imaris::IFilaments
%                                 - Imaris::IFrame
%                                 - Imaris::IDataSet
%                                 - Imaris::IICells
%                                 - Imaris::ILightSource
%                                 - Imaris::IMeasurementPoints
%                                 - Imaris::ISpots
%                                 - Imaris::ISurfaces
%                                 - Imaris::IVolume
%                                 - Imaris::IReferenceFrames
%                                 - Imaris::ISurpassCamera
%                                 - Imaris::IImageProcessing
%                                 - Imaris::IFactory

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

% Check for type and cast (types expected to be used more frequently are
% checked first)

derivedType = [];

factory = this.mImarisApplication.GetFactory();

if isempty(IDataItem)
	return;

elseif factory.IsLightSource(IDataItem)
    derivedType = factory.ToLightSource(IDataItem);

elseif factory.IsFrame(IDataItem)
    derivedType = factory.ToFrame(IDataItem);

elseif factory.IsVolume(IDataItem)
    derivedType = factory.ToVolume(IDataItem);
    
elseif factory.IsSpots(IDataItem)
    derivedType = factory.ToSpots(IDataItem);
   
elseif factory.IsSurfaces(IDataItem)
    derivedType = factory.ToSurfaces(IDataItem);

elseif factory.IsDataSet(IDataItem)
    derivedType = factory.ToDataSet(IDataItem);

elseif factory.IsSurpassCamera(IDataItem)
    derivedType = factory.ToSurpassCamera(IDataItem);

elseif factory.IsFilaments(IDataItem)
    derivedType = factory.ToFilaments(IDataItem);

elseif factory.IsClippingPlane(IDataItem)
    derivedType = factory.ToClippingPlane(IDataItem);

elseif factory.IsApplication(IDataItem)
    derivedType = factory.ToApplication(IDataItem);

elseif factory.IsMeasurementPoints(IDataItem)
    derivedType = factory.ToMeasurementPoints(IDataItem);

elseif factory.IsDataContainer(IDataItem)
    derivedType = factory.ToDataContainer(IDataItem);

elseif factory.IsCells(IDataItem)
    derivedType = factory.ToCells(IDataItem);

elseif factory.IsFactory(IDataItem)
    derivedType = factory.ToFactory(IDataItem);

elseif factory.IsImageProcessing(IDataItem)
    derivedType = factory.ToImageProcessing(IDataItem);
    
else
    
    % The Reference Frame object does not have an Is...() method
    if ~isempty(factory.ToReferenceFrames(IDataItem))
        derivedType = factory.ToReferenceFrames(IDataItem);
    else
        derivedType = IDataItem;
    end

end
