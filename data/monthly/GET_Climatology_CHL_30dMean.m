close all
clear all
%==========================================================================

%==========================================================================  
%% Script to compute monthly average time series for the study period
%--------------------------------------------------------------------------  
% Written by Iria Sala  
% Created on 21.03.2025  
% Last updated on 15.05.2025  
%==========================================================================

%==========================================================================  
%% Load grid data:  
%==========================================================================  
load('G:\My Drive\RESEARCH\PROJECT CALYPSO\03_RESULTS\01_Map\GetLandMask\DATA_GRID.mat');  
%==========================================================================  

%==========================================================================
%% Load land mask:
%==========================================================================
load('G:\My Drive\RESEARCH\PROJECT CALYPSO\03_RESULTS\01_Map\GetLandMask\LandMask_ROI.mat');
%--------------------------------------------------------------------------
mask = landMask;
%==========================================================================

%==========================================================================  
%% Define the directory containing the NetCDF files  
%==========================================================================  
dataDir = 'G:\My Drive\RESEARCH\PROJECT CALYPSO\02_DATA\CHL1\Daily\';  
files   = dir(fullfile(dataDir, 'L3m_*GSM*.nc'));  
nFiles  = length(files);  
%==========================================================================  

%==========================================================================  
%% Extract longitude and latitude vectors:  
%==========================================================================  
firstFile = fullfile(dataDir, files(1).name);  
%--------------------------------------------------------------------------  
try  
    lon = double(nc_varget(firstFile,'lon'));  
    lat = double(nc_varget(firstFile,'lat'));  
catch ME  
    error('Could not read "lon" and/or "lat" from %s: %s', files(1).name, ME.message);  
end  
%--------------------------------------------------------------------------  
[LON,LAT] = meshgrid(lon,lat);
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
compositeMaps  = NaN(size(X,1),size(Y,2),nYears * nMonths);  
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
        tempData = NaN(size(X,1),size(Y,2),numel(yearMonthIdx));  

        % Loop through the files for the current year and month and read data
        for j = 1:numel(yearMonthIdx)  
            
            filepath = fullfile(dataDir, files(yearMonthIdx(j)).name);  
            
            chlData = nc_varget(filepath, 'CHL1_mean');
            CHLdata = interp2(LON,LAT,chlData,X,Y);
            CHLdata = CHLdata .* mask;
            
            tempData(:,:,j) = CHLdata;
            
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
save('CHL_WholeDomain_TimeSeries_30d.mat','-v7.3',...
     'compositeMaps','X','Y');  
%==========================================================================  
return