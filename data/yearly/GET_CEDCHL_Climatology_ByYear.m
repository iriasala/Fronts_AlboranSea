close all
clear all
%==========================================================================

%==========================================================================  
%% Script to compute monthly composite images for the study period
%--------------------------------------------------------------------------  
% Written by Iria Sala  
% Created on 27.02.2025  
% Last updated on 17.03.2025  
%==========================================================================

%==========================================================================  
%% Load mask data:  
%==========================================================================  
load('G:\My Drive\RESEARCH\PROJECT CALYPSO\03_RESULTS\01_Map\GetLandMask\LandMask_ROI.mat');  
%..........................................................................
mask = landMask;
%==========================================================================  

%==========================================================================  
%% Define the directory containing the NetCDF files  
%==========================================================================  
dataCHL  = 'G:\My Drive\RESEARCH\PROJECT CALYPSO\02_DATA\CHL1\Daily\';  
CHLfiles = dir(fullfile(dataCHL,'L3m_*GSM*.nc'));  
%--------------------------------------------------------------------------  
dataDir  = 'G:\My Drive\RESEARCH\PROJECT CALYPSO\03_RESULTS\04_CED-CHL\MATFILES\';  
CEDfiles = dir(fullfile(dataDir,'L3m_*GSM*.mat'));  
nFiles   = length(CEDfiles);  
%==========================================================================  

%==========================================================================  
%% Extract longitude and latitude vectors:  
%==========================================================================  
firstFile = fullfile(dataCHL,CHLfiles(1).name);  
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
%% Extract longitude and latitude vectors:  
%==========================================================================  
firstFile = fullfile(dataDir, CEDfiles(1).name);  
load(firstFile);
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
compositeFG = NaN(size(X,1),size(Y,2),nYears);
compositeFP = NaN(size(X,1),size(Y,2),nYears);
%--------------------------------------------------------------------------  
% Loop through the years and compute yearly composite maps  
for y = 1:nYears  
    y
    
    % Find the files that correspond to the current year
    yearIdx = find(year(sortedDates) == years(y));  
    
    % Initialize a temporary matrix for the current year
    tempCED = NaN(size(X,1),size(Y,2),numel(yearIdx));  
    tempCHL = NaN(size(X,1),size(Y,2),numel(yearIdx));  

    % Loop through the files for the current year and read data
    for j = 1:numel(yearIdx)  
        
        % CED data
        filepath = fullfile(dataDir,CEDfiles(yearIdx(j)).name);  
        load(filepath);  
        
        % CHL data
        filepath = fullfile(dataCHL,CHLfiles(yearIdx(j)).name);  
        chlData = nc_varget(filepath,'CHL1_mean');
        CHLdata = interp2(LON,LAT,chlData,X,Y);

        % Store the data for the current day in tempData
        tempCED(:,:,j) = magnitude .* mask;
        tempCHL(:,:,j) = CHLdata .* mask;
        
    end  

    % Compute the mean Frontal Probability for the current week
    % Firts, convert data to binary: 1 for data, 0 for NaN
    binaryCHL = ~isnan(tempCHL); % Converts all non-NaN values to 1, NaN to 0
    binaryFRO = ~isnan(tempCED); % Converts all non-NaN values to 1, NaN to 0
    % Second, sum pixels:
    numCHLpix = nansum(binaryCHL,3); % Number of times the pixel was cloud-free (if cloud = NaN)
    numFROpix = nansum(binaryFRO,3); % Number of times the pixel was identified as a front
    %----------------------------------------------------------------------
    compositeFP(:,:,i) = (numFROpix ./ numCHLpix) * 100; % FP = N / C *100;
    % N = number of images in which a pixel was detected as a front
    % C = number of images in which the same pixel was cloud-free
    %----------------------------------------------------------------------

end  
%==========================================================================  


%==========================================================================  
%% Save data:  
%..........................................................................  
save('CEDCHL_WholeDomain_YearlyClimatology.mat','-v7.3',...
     'compositeFG','compositeFP','X','Y');  
%==========================================================================  
return
