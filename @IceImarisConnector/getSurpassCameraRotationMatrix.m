function [R, isI] = getSurpassCameraRotationMatrix(this)
% IceImarisConnector:  getSurpassCameraRotationMatrix (public method)
%
% DESCRIPTION
%
%   This method calculates the rotation matrix that corresponds to current
%   view in the Surpass Scene (from the Camera Quaternion) for the axes
%   with "Origin Bottom Left". 
%
% TO DO
%
%   Verify the correctness for the other axes orientations.
%
% SYNOPSIS
%
%   [R, isI] = conn.getSurpassCameraRotationMatrix()
%
% INPUT
%
%   None
%
% OUTPUT
%
%   R   : (4 x 4) rotation matrix
%   isI : true if the rotation matrix is the Identity matrix, i.e. the
%         camera is perpendicular to the dataset

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

% Initialize R
R = [];

% Get the camera
vCamera = this.mImarisApplication.GetSurpassCamera();
if isempty(vCamera)
    return
end

% Get the camera position quaternion
q = vCamera.GetOrientationQuaternion();

% Calculate the rotation matrix R from the quaternion
R = IceImarisConnector.mapQuaternionToRotationMatrix(q);

% Is R the Identity matrix?
T = R == eye(4);
isI = all(T(:));

end
