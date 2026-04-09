close all
clear all
%==========================================================================

%==========================================================================  
%% Script to compute monthly composite images for the study period
%--------------------------------------------------------------------------  
% Written by Iria Sala  
% Created on 27.02.2025  
% Last updated on 15.05.2025  
%==========================================================================

%==========================================================================  
%% Load mask data:  
%==========================================================================  
load('G:\My Drive\RESEARCH\PROJECT CALYPSO\03_RESULTS\01_Map\GetLandMask\LandMask_ROI.mat');  
%..........................................................................
mask = landMask;
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
%% Define the directory containing the NetCDF files  
%==========================================================================  
dataSST  = 'G:\My Drive\RESEARCH\PROJECT CALYPSO\02_DATA\SST1\';  
SSTfiles = dir(fullfile(dataSST,'*.nc'));  
%--------------------------------------------------------------------------  
dataDir  = 'G:\My Drive\RESEARCH\PROJECT CALYPSO\03_RESULTS\05_CED-SST\MATFILES\';  
CEDfiles = dir(fullfile(dataDir,'*.mat'));  
nFiles   = length(CEDfiles);  
%==========================================================================  

%==========================================================================  
%% Extract longitude and latitude vectors:  
%==========================================================================  
firstFile = fullfile(dataDir,CEDfiles(1).name);  
load(firstFile);
%==========================================================================  

%==========================================================================  
%% Extract date from filenames assuming pattern '...YYYYMMDD.nc'  
%==========================================================================  
dates = datetime.empty(nFiles,0); % Preallocate a datetime array  
%--------------------------------------------------------------------------  
for i = 1:nFiles
    
    fname = CEDfiles(i).name;  
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
CEDfiles = CEDfiles(idx);  
%==========================================================================  

%==========================================================================  
%% Initialise containers for composite maps and corresponding dates  
%==========================================================================  
% Get the unique years in the data
years = unique(year(sortedDates));  
nYears = numel(years);  
%--------------------------------------------------------------------------  
compositeFG = NaN(length(lat),length(lon),nYears);
compositeFP = NaN(length(lat),length(lon),nYears);
%--------------------------------------------------------------------------  
% Loop through the years and compute yearly composite maps  
for y = 1:nYears  
    y
    
    % Find the files that correspond to the current year
    yearIdx = find(year(sortedDates) == years(y));  
    
    % Initialize a temporary matrix for the current year
    tempCED = NaN(length(lat),length(lon),numel(yearIdx));  
    tempSST = NaN(length(lat),length(lon),numel(yearIdx));  

    % Loop through the files for the current year and read data
    for j = 1:numel(yearIdx)  
        
        % CED data
        filepath = fullfile(dataDir,CEDfiles(yearIdx(j)).name);  
        load(filepath);  
        
        % SST data
        filepath = fullfile(dataSST,SSTfiles(yearIdx(j)).name);
        sst1     = double(nc_varget(filepath, 'sea_surface_temperature'));
        sstData  = squeeze(sst1(1,minLAT:maxLAT,minLON:maxLON));

        % Store the data for the current day in tempData
        tempCED(:,:,j) = magnitude .* mask;
        tempSST(:,:,j) = sstData .* mask;

    end  

    % Compute the mean Frontal Gradient for the current month
    compositeFG(:,:,y) = mean(tempCED,3,'omitnan');

    % Compute the mean Frontal Probability for the current week
    % Firts, convert data to binary: 1 for data, 0 for NaN
    binarySST = ~isnan(tempSST); % Converts all non-NaN values to 1, NaN to 0
    binaryFRO = ~isnan(tempCED); % Converts all non-NaN values to 1, NaN to 0
    % Second, sum pixels:
    numSSTpix = nansum(binarySST,3); % Number of times the pixel was cloud-free (if cloud = NaN)
    numFROpix = nansum(binaryFRO,3); % Number of times the pixel was identified as a front
    %----------------------------------------------------------------------
    compositeFP(:,:,i) = (numFROpix ./ numSSTpix) * 100; % FP = N / C *100;
    % N = number of images in which a pixel was detected as a front
    % C = number of images in which the same pixel was cloud-free
    %----------------------------------------------------------------------

end  
%==========================================================================  


%==========================================================================  
%% Save data:  
%..........................................................................  
save('CEDSST_WholeDomain_YearlyClimatology.mat','-v7.3',...
     'compositeFG','compositeFP','lon','lat');  
%==========================================================================  
return
