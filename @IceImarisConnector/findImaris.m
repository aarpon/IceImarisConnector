function [status, errorMessage] = findImaris(this)
% IceImarisConnector:  findImaris (private method)
%
% DESCRIPTION
%
%   This methods gets the Imaris path to the Imaris executable and
%   to the ImarisLib.jar library from the environment variable IMARISPATH
%
% SYNOPSIS
%
%   [status, errorMessage] = imarisPath = conn.findImaris()
%
% INPUT
%
%   None
%
% OUTPUT
%
%   status       : 1 if the paths could be set successfully, 0 otherwise
%   errorMessage : if the paths could not be found, a message is returned
%                  in errorMessage

% AUTHORS
%
% Author: Aaron Ponti
% Contributor: Igor Beati

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

% Initialize the status to failure
status = 0;

% Initialize the error messgae
errorMessage = '';

% Try to get the environment variable IMARISPATH
imarisPath = getenv('IMARISPATH');

% Set the paths
this.mImarisExePath = '';
this.mImarisServerExePath = '';
this.mImarisLibPath = '';

% Is the variable defined?
if isempty(imarisPath)
    % jonas - 4/2012 be a little more robust
    % installation defaults to C: on Windows, /Applications on Mac
    if ispc
        tmp = 'C:\Program Files\Bitplane\';
    elseif ismac
        tmp = '/Applications';
    else
        errorMessage = ...
            'IceImarisConnector can only work on Windows and Mac OS X';
        return
    end
    
    if exist(tmp,'dir')
        d = dir(fullfile(tmp,'Imaris*'));
        % Make sure to ignore the Scene Viewer
        svi = strfind({d.name}, 'Scene Viewer');
        d(~cellfun(@isempty, svi)) = [];
        % Use latest version
        switch length(d)
            case 0
                errorMessage = sprintf(...
                    ['No Imaris installation found in %s.',...
                    ' Please define an environment variable IMARISPATH'],...
                    tmp);
            case 1
                imarisPath = fullfile(tmp,d.name);
            otherwise
                % take most recent installation
                installDates = cat(1,d.datenum);
                dirIdx = find(cat(1,d.isdir));
                [~,idx] = max(installDates(dirIdx));
                imarisPath = fullfile(tmp,d(dirIdx(idx)).name);
        end
    else
        errorMessage = sprintf(...
            ['No Imaris installation found in %s.',...
            ' Please define an environment variable IMARISPATH'],...
            tmp);
    end
    
    
    if isempty(imarisPath) && ~isempty(errorMessage)
        errorMessage = 'Please define the environment variable IMARISPATH.';
        return;
    end
end

% Does it point to an existing directory?
if ~exist(imarisPath, 'dir')
    errorMessage = ['The content of the IMARISPATH environment ', ...
        'variable does not point to a valid directory.'];
    return;
end

% Set the path to the Imaris executable
if strfind(computer, 'PCWIN')
    exePath = fullfile(imarisPath, 'Imaris.exe');
elseif strfind(computer, 'MAC')
    exePath = fullfile(imarisPath, 'Contents', 'MacOS', 'Imaris');
else
    errorMessage = ['IceImarisConnector can only be used on Windows ', ...
        'and Mac OS X.'];
    return
end

% Set the path to the ImarisServer executable
if strfind(computer, 'PCWIN')
    serverExePath = fullfile(imarisPath, 'ImarisServerIce.exe');
elseif strfind(computer, 'MAC')
    serverExePath = fullfile(imarisPath, 'Contents', 'MacOS', 'ImarisServerIce');
else
    errorMessage = ['IceImarisConnector can only be used on Windows ', ...
        'and Mac OS X.'];
    return
end

% Check whether the exectable Imaris file exists
if ~exist(exePath, 'file')
    errorMessage = 'Could not find the Imaris executable.';
    return;
end

% Set the path to the ImarisLib library
if strfind(computer, 'PCWIN')
    libPath = fullfile(imarisPath, 'XT', 'matlab', 'ImarisLib.jar');
elseif strfind(computer, 'MAC')
    libPath = fullfile(imarisPath, 'Contents', 'SharedSupport', ...
        'XT', 'matlab', 'ImarisLib.jar');
else
    errorMessage = ['IceImarisConnector can only be used on Windows ', ...
        'and Mac OS X.'];
    return
end

% Check whether the ImarisLib jar package exists
if ~exist(libPath, 'file')
    errorMessage = 'Could not find the Imaris executable.';
    return;
end

% Now we can store the information and return success
this.mImarisExePath = exePath;
this.mImarisServerExePath = serverExePath;
this.mImarisLibPath = libPath;

status = 1;

end
