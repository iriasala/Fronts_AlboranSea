close all
clear all
%==========================================================================

%==========================================================================  
%% Script to compute yearly climatologies along the study period
%--------------------------------------------------------------------------  
% Written by Iria Sala  
% Created on 27.02.2025  
% Last updated on 14.05.2025  
%==========================================================================

%==========================================================================  
%% Define the directory containing the NetCDF files  
%==========================================================================  
dataDir = 'G:\My Drive\RESEARCH\PROJECT CALYPSO\02_DATA\SST1\';  
files   = dir(fullfile(dataDir, '*.nc'));  
nFiles  = length(files);  
%==========================================================================  

%==========================================================================
%% Define the study area:
%==========================================================================
% minLon = -6.00; maxLon = -1.00;
minLON = 1455; maxLON = 2055;
%--------------------------------------------------------------------------
% minLat = 34.90; maxLat = 37.80;
minLAT =  558; maxLAT =  907;
%==========================================================================

%==========================================================================  
%% Extract longitude and latitude vectors:  
%==========================================================================  
firstFile = fullfile(dataDir, files(1).name);  
%--------------------------------------------------------------------------  
try  
    lon = double(nc_varget(firstFile,'lon'));
    lon = squeeze(lon);
    lon = lon(minLON:maxLON);

    lat = double(nc_varget(firstFile,'lat'));  
    lat = squeeze(lat);
    lat = lat(minLAT:maxLAT);    
catch ME  
    error('Could not read "lon" and/or "lat" from %s: %s', files(1).name, ME.message);  
end  
%==========================================================================  

%==========================================================================  
%% Extract date from filenames assuming pattern '...YYYYMMDD.nc'  
%==========================================================================  
dates = datetime.empty(nFiles, 0); % Preallocate a datetime array  
%--------------------------------------------------------------------------  
for i = 1:nFiles  

    fname = files(i).name;  
    dateStr = regexp(fname, '\d{8}', 'match');  
    
    if ~isempty(dateStr)  
        dates(i) = datetime(dateStr{1}, 'InputFormat', 'yyyyMMdd'); % Directly store as datetime  
    else  
        error('Filename %s does not contain a date in expected format.', fname);  
    end
    
end
%==========================================================================  

%==========================================================================  
%% Sort files by date  
%==========================================================================  
[sortedDates, idx] = sort(dates);  
files = files(idx);  
%==========================================================================  

%==========================================================================  
%% Initialise containers for composite maps and corresponding dates  
%==========================================================================  
% Get the unique years in the data
years = unique(year(sortedDates));  
nYears = numel(years);  
%--------------------------------------------------------------------------  
compositeMaps = NaN(length(lat),length(lon),nYears);  
%--------------------------------------------------------------------------  
% Loop through the years and compute yearly composite maps  
for y = 1:nYears  
    y
    
    % Find the files that correspond to the current year
    yearIdx = find(year(sortedDates) == years(y));  
    
    % Initialize a temporary matrix for the current year
    tempData = NaN(length(lat), length(lon), numel(yearIdx));  

    % Loop through the files for the current year and read data
    for j = 1:numel(yearIdx)
        
        filepath = fullfile(dataDir, files(yearIdx(j)).name);
        
        sst1    = nc_varget(filepath, 'sea_surface_temperature');
        SST1    = squeeze(sst1);
        sstData = SST1(minLAT:maxLAT,minLON:maxLON);
        sstData = sstData - 273.15; % [degree C]
        
        % Store the data for the current day in tempData
        tempData(:,:,j) = sstData;
        
    end  

    % Compute the mean for the current year
    % Using mean() with 'omitnan' to ignore NaN values
    compositeMaps(:,:,y) = nanmean(tempData,3);

end  
%==========================================================================  

%==========================================================================  
%% Save data:  
%..........................................................................  
save('SST_WholeDomain_YearlyClimatology.mat','-v7.3',...
     'compositeMaps','lon','lat');  
%==========================================================================  
return
