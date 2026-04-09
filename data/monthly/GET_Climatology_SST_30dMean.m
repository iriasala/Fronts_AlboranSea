close all
clear all
%==========================================================================

%==========================================================================  
%% Script to compute monthly average time series for the study period
%--------------------------------------------------------------------------  
% Written by Iria Sala  
% Created on 27.02.2025  
% Last updated on 04.06.2025  
%==========================================================================

%==========================================================================  
%% Load grid data:  
%==========================================================================  
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\LandMask\LandMask_ROI.mat');  
%--------------------------------------------------------------------------
mask = landMask;
%==========================================================================

%==========================================================================  
%% Define the directory containing the NetCDF files  
%==========================================================================  
dataDir = 'G:\My Drive\RESEARCH\DATA\CMEMS_SST1\';  
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
% Get the unique years and months in the data
years   = unique(year(sortedDates));  
months  = unique(month(sortedDates));  
nYears  = numel(years);  
nMonths = numel(months);
%--------------------------------------------------------------------------  
% Initialize a 3D matrix to store monthly average maps (lat x lon x time)
compositeMaps = NaN(length(lat),length(lon),nYears * nMonths);  
%--------------------------------------------------------------------------  
% Loop through each year and each month to compute the monthly average time series  
timeIndex = 1; % Initialize the time index for the 3D matrix
for y = 1:nYears
    y
    
    for m = 1:nMonths
        m
        
        % Find the files that correspond to the current year and month
        yearMonthIdx = find(year(sortedDates) == years(y) & month(sortedDates) == months(m));  
        
        % Initialize a temporary matrix for the current month
        tempData = NaN(length(lat),length(lon),numel(yearMonthIdx));  

        % Loop through the files for the current year and month and read data
        for j = 1:numel(yearMonthIdx)  
            
            filepath = fullfile(dataDir, files(yearMonthIdx(j)).name);
            
            sst1    = nc_varget(filepath, 'sea_surface_temperature');
            SST1    = squeeze(sst1);
            sstData = SST1(minLAT:maxLAT,minLON:maxLON) .* mask;
            sstData = sstData - 273.15; % [degree C]
        
            tempData(:,:,j) = sstData;
 
        end  

        % Compute the mean for the current year and month
        % Using mean() with 'omitnan' to ignore NaN values
        compositeMaps(:,:,timeIndex) = mean(tempData, 3, 'omitnan');  

        % Increment the time index for the next month
        timeIndex = timeIndex + 1;
        
    end  
end  
%==========================================================================  

%==========================================================================  
%% Save data:  
%..........................................................................  
save('SST_WholeDomain_TimeSeries_30d.mat','-v7.3',...
     'compositeMaps','lon','lat');  
%==========================================================================  
return