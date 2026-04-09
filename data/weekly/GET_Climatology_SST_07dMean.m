close all
clear all
%==========================================================================

%==========================================================================  
%% Script to compute 7-day composite images for the study period
%--------------------------------------------------------------------------  
% Written by Iria Sala  
% Created on 20.02.2025  
% Last updated on 14.05.2025  
%==========================================================================

%==========================================================================  
%% Load grid data:  
%==========================================================================  
load('G:\My Drive\RESEARCH\PROJECT CALYPSO\03_RESULTS\01_Map\GetLandMask\LandMask_ROI.mat');  
%--------------------------------------------------------------------------
mask = landMask;
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
dates = zeros(nFiles,1); % Preallocate an array to store file dates  
%--------------------------------------------------------------------------  
for i = 1:nFiles
    
    fname = files(i).name;
    
    dateStr = regexp(fname, '\d{8}', 'match');
    
    if ~isempty(dateStr)
        dates(i) = datenum(dateStr{1}, 'yyyymmdd');
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
iniDate = datetime(2008,1,1);  % or min(sortedDates)
endDate = datetime(2024,12,31); % or max(sortedDates)
wEdges  = datenum(iniDate:7:endDate+7);  % bin edges in datenum
nWeeks  = length(wEdges) - 1;
%==========================================================================  
weeklyFileIndices = cell(nWeeks, 1);
%..........................................................................
for i = 1:nWeeks

    inBin = sortedDates >= wEdges(i) & sortedDates < wEdges(i+1);

    weeklyFileIndices{i} = find(inBin);

end
%--------------------------------------------------------------------------  
compositeMaps = NaN(length(lat),length(lon),nWeeks);  
%--------------------------------------------------------------------------  
% Loop through the files and compute 7-day composite maps  
for i = 1:nWeeks
    
    idxList = weeklyFileIndices{i};
    
    if isempty(idxList)
        continue  % skip weeks with no data
    end
    
    % Initialize a temporary matrix for the current 7-day period
    % This matrix will store data for each day of the 7-day period
    tempData = NaN(length(lat),length(lon),length(idxList));

    % Loop through the files for the current 7-day period and read data
    for j = 1:length(idxList)
        
        filepath = fullfile(dataDir, files(idxList(j)).name);

        sst1    = nc_varget(filepath, 'sea_surface_temperature');
        SST1    = squeeze(sst1);
        sstData = SST1(minLAT:maxLAT,minLON:maxLON) .* mask;
        sstData = sstData - 273.15; % [degree C]
        
        tempData(:,:,j) = sstData;

    end 

    % Compute the mean for the current 7-day period
    % Using mean() with 'omitnan' to ignore NaN values
    compositeMaps(:,:,i) = nanmean(tempData,3);  
    
end  
%==========================================================================  

%==========================================================================  
%% Save data:  
%..........................................................................  
weeklyDates = datetime(wEdges(1:end-1), 'ConvertFrom', 'datenum') + days(3);  % middle of each week
save('SST_WholeDomain_TimeSeries_07d.mat', '-v7.3', ...
     'compositeMaps','lon','lat','weeklyDates');
%==========================================================================  
return
