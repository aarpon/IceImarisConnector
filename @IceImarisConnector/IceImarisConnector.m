% IceImarisConnector constructor
%
% DESCRIPTION
%
%   IceImarisConnector is a simple commodity class that eases communication
%   between Imaris and MATLAB using the ImarisXT interface.
%
% SYNOPSIS
%
%   conn = IceImarisConnector(imarisApplication, indexingStart)
%
% INPUT
%
%   imarisApplication : (optional) if omitted (or set to []), an 
%                        IceImarisConnector object is created that is 
%                        not connected to any Imaris instance.
%
%                        Imaris can then be started (and connected) using
%                        the startImaris() method, i.e.
%
%                            conn.startImaris()
%
%                        Alternatively, imarisApplication can be:
%
%                        - an Imaris Application ID as provided by Imaris
%                        - an IceImarisConnector reference
%                        - an Imaris Application ICE object.
%
%   indexingStart      : (optional, default is 0) either 0 or 1, depending
%                        on whether you prefer to index arrays in 
%                        IceImarisConnector starting at 0 or 1. 
%                        
%                        All indexing in ICE starts at 0; in contrast, 
%                        MATLAB indexing starts at 1.
%                        To keep consistency, indexing in IceImarisConnector
%                        is also 0-based (i.e. indexingStart defaults to 0).
%                        This means that to get the data volume for the 
%                        first channel and first time point of the dataset
%                        you will use conn.GetDataVolume(0, 0).
%                        It you are come confortable with 1-based indexing,
%                        i.e. you prefer using conn.GetDataVolume(1, 1), 
%                        you can set indexingStart to 1.
%
%                        Whatever you choose, be consistent!
%
% REMARK
%
%   The Imaris Application ICE object is stored in the read-only property
%   mImarisApplication. The mImarisApplication property gives access to
%   the entire Imaris ICE API. Example:
%
%   conn.mImarisApplication.GetSurpassSelection()
%
%   returns the currently selected object in the Imaris surpass scene.
%
% OUTPUT
%
%   conn    :  an object of class IceImarisConnector

% AUTHORS
%
% Author: Aaron Ponti
% Contributor: Jonas Dorn

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

classdef IceImarisConnector < handle
        
    properties (SetAccess = private, GetAccess = public)
        mImarisApplication = [];
    end
    
    properties (Access = private)
        mImarisPath;
        mImarisLib;
        mImarisExePath;
        mImarisServerExePath;
        mImarisLibPath;
        mImarisObjectID;
        mIndexingStart = 0; % default is zero-based
        mUserControl = 0;   % default is zero
    end
    
    % Methods
    methods
        
        % Constructor
        function this = IceImarisConnector(imarisApplication, indexingStart)
            % IceImarisConnector constructor

            % First, we prepare everything we need
            % Store the Imaris and ImarisLib path
            [success, errorMessage] = this.findImaris;
            if ~success
                error(errorMessage);
            end
            
            % Add the ImarisLib.jar package to the java class path
            % (if not there yet). Make sure that the version already 
            % in the path is the same as the one returned by
            % findImaris. A discrepancy could occur if
            % IMARISPATH is set manually from the MATLAB
            % console using setenv().
            jcp = javaclasspath();
            indxJcp = find(contains(jcp, 'ImarisLib.jar'));
            if isempty(indxJcp)
                javaaddpath(this.mImarisLibPath);
            else
                % Do we have the same version? It it is the case,
                % we do not need to do anything. % If not, we try to 
                % replace the old with the new.
                if strcmp(jcp{indxJcp}, this.mImarisLibPath) == 0
                    fprintf(1, ['Switching to %s.\n\n   If you get a ', ...
                        '''not clearing java'' warning, please make ', ...
                        'sure to clear() any\n   IceImarisConnector ', ...
                        'object before recreating it.\n\n', ...
                        '  For example:\n', ...
                        '      >> clear(''conn'');\n', ...
                        '      >> conn = IceImarisConnector();\n\n'], ...
                        strrep(this.mImarisLibPath, '\', '/'));
                    javarmpath(jcp{indxJcp});
                    javaaddpath(this.mImarisLibPath);
                end
            end
            
            % Create and store an ImarisLib instance
            this.mImarisLib = ImarisLib();

            % Assign a random id. We reserve the first 1000 to manually
            % started Imaris instances.
            this.mImarisObjectID = 1000 + randi(100000);

            % Now we check the (optional) input parameter.
            % If the constructor is called without parameters, we just
            % create an IceImarisConnector object that does nothing.
            % If we get one input parameter, we have to distinguish between
            % three cases: 
            % - we get an Imaris Application ID as provided by Imaris and
            %      thus we query the Imaris Server for the application
            % - we get an IceImarisConnector reference and thus we just
            %      return it
            % - we get an Imaris Application ICE object (rare) and thus
            %      we simply assign it to the mImarisApplication property.
            
            if nargin == 0
                
                % We already did everything
                return

            end
                
            if nargin > 0 && ~isempty(imarisApplication)
                
                if isa(imarisApplication, 'IceImarisConnector')
                    
                    % If the input parameter is an IceImarisConnector
                    % object we return the reference. This way, an
                    % XTension class can take a reference to an 
                    % IceImarisConnector object as input parameter
                    this = imarisApplication;
                    
                elseif isa(imarisApplication, ...
                        'Imaris.IApplicationPrxHelper')
                    
                    % This is an Imaris application object - we store it.
                    % We leave the ID to the randomly generated one.
                    this.mImarisApplication = imarisApplication;
                    
                elseif isscalar(imarisApplication)
                   
                    % Check if the application is registered
                    server = this.mImarisLib.GetServer();
                    if isempty(server)
                        error('Could not connect to Imaris Server.');
                    end
                    nApps = server.GetNumberOfObjects();
                    if nApps == 0
                        error('There are no registered Imaris applications.');
                    end
                    
                    % Does the passed ID match the ID of any of the
                    % registered (running) Imaris application?
                    found = 0;
                    for i = 0 : nApps - 1
                        if server.GetObjectID(i) == imarisApplication
                            found = 1;
                            break;
                        end
                    end
                    if found == 0
                        error('Invalid Imaris application ID.');
                    end

                    % Now we can get the application object and store it
                    imarisApplicationObj = ...
                        this.mImarisLib.GetApplication(imarisApplication);
                    if isempty(imarisApplicationObj)
                        error('Cannot access Imaris application.');
                    else
                        this.mImarisApplication = imarisApplicationObj;
                    end
                    
                    % We also update the id
                    this.mImarisObjectID = imarisApplication;
                
                else
                
                    error(['The passed object is not a Imaris ', ...
                        'Application ID.']);
   
                end
                
            end
            
            if nargin > 1 && ~isempty(indexingStart)
                
                this.mIndexingStart = indexingStart;
                
            end
            
            if nargin > 2
                
                error('Wrong number of input arguments!');
                
            end
            
        end
       
        % Destructor
        function delete(this)
        
            if this.mUserControl == 1
                if ~isempty(this.mImarisApplication)
                    % Force close
                    this.closeImaris(1);
                end
            end

        end
        
    end
    
    % External public and static methods
    % =====================================================================
    
    methods (Access = public)
        
        % autocast
        castObject = autocast(this, obj)
                    
        % createAndSetSpots
        newSpots = createAndSetSpots(this, coords, timeIndices, radii, ...
            name, color, container)

        % createDataset
        iDataset = createDataset(this, datatype, sizeX, sizeY, ...
            sizeZ, sizeC, sizeT, voxelSizeX, voxelSizeY, voxelSizeZ, ...
            deltaTime, addToImaris)
 

        % cloneDataset
        dataset = cloneDataset(this, iDataSet)

        % closeImaris
        success = closeImaris(this, varargin)

        % copyChannels
        copyChannels(this, channelIndices)
        
        % display
        display(this)        

        % getAllSurpassChildren
        children = getAllSurpassChildren(this, recursive, filter)

        % getChannelNames
        channelNames = getChannelNames(this)

        % getDataSlice
        slice = getDataSlice(this, plane, channel, timepoint, iDataset)

        % getDataSliceRM
        slice = getDataSliceRM(this, plane, channel, timepoint, iDataset)

        % getDataSubVolume
        stack = getDataSubVolume(this, x0, y0, z0, channel, timepoint, ...
            dX, dY, dZ, iDataSet)
        
        % getDataSubVolumeRM
        stack = getDataSubVolumeRM(this, x0, y0, z0, channel, ...
            timepoint, dX, dY, dZ, iDataSet)
        
        % getDataVolume
        stack = getDataVolume(this, channel, timepoint, iDataset)

        % getDataVolumeRM
        stack = getDataVolumeRM(this, channel, timepoint, iDataset)
        
        % getExtends
        [minX, maxX, minY, maxY, minZ, maxZ] = getExtends(this)

        % getImarisVersionAsInteger
        version = getImarisVersionAsInteger(this)
        
        % getMatlabDatatype
        type = getMatlabDatatype(this)
        
        % getSizes
        [sizeX, sizeY, sizeZ, sizeC, sizeT] = getSizes(this)
        
        % getVoxelSizes
        [voxelSizesX, voxelSizesY, voxelSizesZ] = getVoxelSizes(this)
        
        % getSurpassCameraRotationMatrix
        [R, isI] = getSurpassCameraRotationMatrix(this)
        
        % getTracks
        [tracks, startTimes] = getTracks(this, iSpots)
        
        % indexingStart
        n = indexingStart(this)
        
        % info
        info(this)

        % isAlive
        alive = isAlive(this)
        
        % mapPositionsUnitsToVoxels
        varargout = mapPositionsUnitsToVoxels(this, varargin)
        
        % mapPositionsVoxelsToUnits
        varargout = mapPositionsVoxelsToUnits(this, varargin)
        
        % setDataVolume
        setDataVolume(this, stack, channel, timepoint)
        
        % setVoxelSizes
        setVoxelSizes(this, voxelSizes)
        
        % startImaris
        success = startImaris(this, userControl)

    end

    methods (Access = public, Static = true)

        % calcRotationBetweenVectors3D
        q = calcRotationBetweenVectors3D(start, dest)
        
        % isSupportedPlatform
        b = isSupportedPlatform()

        % mapRgbaScalarToVector
        rgbaVector = mapRgbaScalarToVector(rgbaScalar)

        % mapRgbaVectorToScalar
        rgbaScalar = mapRgbaVectorToScalar(rgbaVector)

        % mapAxisAngleToQuaternion
        q = mapAxisAngleToQuaternion(r_axis, r_angle)

        % mapAxisAngleToRotationMatrix
        [R, x_axis, y_axis, z_axis] = mapAxisAngleToRotationMatrix(r_axis, r_angle)
        
        % mapQuaternionToRotationMatrix
        [R, x_axis, y_axis, z_axis] = mapQuaternionToRotationMatrix(quaternion)
        
        % multiplyQuaternions
        q = multiplyQuaternions(q1, q2)
        
        % normalize
        v = normalize(v, epsilon)

        % quaternionConjugate
        qc = quaternionConjugate(q)
        
        % version
        v = version();

    end
    
    methods (Access = private)
        
        % findImaris
        [imarisPath, errorMessage] = findImaris(this)
        
        % isOfType
        b = isOfType(this, object, type)
        
        % startImarisServer
        [success, errorMessage] = startImarisServer(this)
        
    end
    
end
