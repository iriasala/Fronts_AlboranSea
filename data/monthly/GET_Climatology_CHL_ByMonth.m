close all
clear all
%==========================================================================

%==========================================================================  
%% Script to compute monthly climatology composite images for the study period
%--------------------------------------------------------------------------  
% Written by Iria Sala  
% Created on 27.02.2025  
% Last updated on 21.07.2025  
%==========================================================================

%==========================================================================  
%% Load grid data:  
%==========================================================================  
load('G:\My Drive\RESEARCH\PROJECT CALYPSO\03_RESULTS\01_Map\GetLandMask\DATA_GRID.mat');  
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
% Convert dates to datetime explicitly if necessary
sortedDates = datetime(sortedDates);
%--------------------------------------------------------------------------  
% Get the unique months in the data
months = unique(month(sortedDates));  
nMonths = numel(months);  
%--------------------------------------------------------------------------  
compositeMaps = NaN(size(X,1),size(Y,2),nMonths);  
%--------------------------------------------------------------------------  
% Loop through the months and compute monthly composite maps  
for m = 1:nMonths
    m
    
    % Find the files that correspond to the current month
    monthIdx = find(month(sortedDates) == months(m));  
    
    % Initialize a temporary matrix for the current month
    tempData = NaN(size(X,1),size(Y,2),numel(monthIdx));  

    % Loop through the files for the current month and read data
    for j = 1:numel(monthIdx)
        
        filepath = fullfile(dataDir, files(monthIdx(j)).name);
        
        chlData = nc_varget(filepath, 'CHL1_mean');
        CHLdata = interp2(LON,LAT,chlData,X,Y);
        
        % Store the data for the current day in tempData
        tempData(:,:,j) = CHLdata;
        
    end  

    % Compute the mean for the current month
    % Using mean() with 'omitnan' to ignore NaN values
    compositeMaps(:,:,m) = mean(tempData, 3, 'omitnan');
    
end  
%==========================================================================   

%==========================================================================  
%% Save data:  
%..........................................................................  
save('CHL_WholeDomain_MonthlyClimatology.mat','-v7.3',...
     'compositeMaps','X','Y');  
%==========================================================================  
return
