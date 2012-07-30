function derivedType = autocast( this, IDataItem )
% IceImarisConnector:  autocast (private method)
% 
% DESCRIPTION
% 
%   This method casts IDataItems to their derived types
% 
% SYNOPSIS
% 
%   derivedType = conn.indexingStart( IDataItem )
% 
% INPUT
% 
%   IDataItem: one of ...
% 
% OUTPUT
% 
%   derivedType : one of...

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

if this.mImarisApplication.mFactory.IsSpots( IDataIem )
    derivedType = this.mImarisApplication.mFactory.ToSpots( IDataIem )
   
elseif this.mImarisApplication.mFactory.IsSurfaces( IDataIem )
    derivedType = this.mImarisApplication.mFactory.ToSurfaces( IDataIem )

elseif this.mImarisApplication.mFactory.IsVolume( IDataIem )
    derivedType = this.mImarisApplication.mFactory.ToVolume( IDataIem )

elseif this.mImarisApplication.mFactory.IsFrame( IDataIem )
    derivedType = this.mImarisApplication.mFactory.ToFrame( IDataIem )

elseif this.mImarisApplication.mFactory.IsLightSource( IDataIem )
    derivedType = this.mImarisApplication.mFactory.ToLightSource( IDataIem )

elseif this.mImarisApplication.mFactory.IsDataSet( IDataIem )
    derivedType = this.mImarisApplication.mFactory.ToDataSet( IDataIem )

elseif this.mImarisApplication.mFactory.IsSurpassCamera( IDataIem )
    derivedType = this.mImarisApplication.mFactory.ToSurpassCamera( IDataIem )

elseif this.mImarisApplication.mFactory.IsFilaments( IDataIem )
    derivedType = this.mImarisApplication.mFactory.ToFilaments( IDataIem )

elseif this.mImarisApplication.mFactory.IsClippingPlane( IDataIem )
    derivedType = this.mImarisApplication.mFactory.ToClippingPlane( IDataIem )

elseif this.mImarisApplication.mFactory.IsApplication( IDataIem )
    derivedType = this.mImarisApplication.mFactory.ToApplication( IDataIem )

elseif this.mImarisApplication.mFactory.IsMeasurementPoints( IDataIem )
    derivedType = this.mImarisApplication.mFactory.ToMeasurementPoints( IDataIem )

elseif this.mImarisApplication.mFactory.IsDataContainer( IDataIem )
    derivedType = this.mImarisApplication.mFactory.ToDataContainer( IDataIem )

elseif this.mImarisApplication.mFactory.IsCells( IDataIem )
    derivedType = this.mImarisApplication.mFactory.ToCells( IDataIem )

elseif this.mImarisApplication.mFactory.IsFactory( IDataIem )
    derivedType = this.mImarisApplication.mFactory.ToFactory( IDataIem )

elseif this.mImarisApplication.mFactory.IsImageProcessing( IDataIem )
    derivedType = this.mImarisApplication.mFactory.ToImageProcessing( IDataIem )
    
else
    derivedType = IDataItem;

end

% This check should be unnecessary
if isempty( derivedType )
    error( 'Type casting failed!' )
end
