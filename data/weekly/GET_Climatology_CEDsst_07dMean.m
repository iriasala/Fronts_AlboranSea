close all
clear all
%==========================================================================

%==========================================================================  
%% Script to compute 7-day composite images for the study period
%--------------------------------------------------------------------------  
% Written by Iria Sala  
% Created on 20.02.2025  
% Last updated on 05.06.2025  
%==========================================================================

%==========================================================================  
%% Load mask data:  
%==========================================================================  
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\LandMask\LandMask_ROI.mat');  
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
dataSST  = 'G:\My Drive\RESEARCH\DATA\CMEMS_SST1\';  
SSTfiles = dir(fullfile(dataSST,'*.nc'));  
%--------------------------------------------------------------------------  
dataCED  = 'G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\FrontsSST\';  
CEDfiles = dir(fullfile(dataCED,'*.mat'));  
nFiles   = length(CEDfiles);  
%==========================================================================  

%==========================================================================  
%% Extract longitude and latitude vectors:  
%==========================================================================  
firstFile = fullfile(dataCED,CEDfiles(1).name);  
load(firstFile);
%==========================================================================  

%==========================================================================  
%% Extract date from filenames assuming pattern '...YYYYMMDD.nc'  
%==========================================================================  
dates = zeros(nFiles,1); % Preallocate an array to store file dates  
%--------------------------------------------------------------------------  
for i = 1:nFiles
    
    fname = SSTfiles(i).name;
    
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
SSTfiles = SSTfiles(idx);  
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
compositeFG = NaN(length(lat),length(lon),nWeeks);  
compositeFP = NaN(length(lat),length(lon),nWeeks);
%--------------------------------------------------------------------------  
% Loop through the files and compute 7-day composite maps  
for i = 1:nWeeks
    i
    
    idxList = weeklyFileIndices{i};
    
    if isempty(idxList)
        continue  % skip weeks with no data
    end
    
    % Initialize a temporary matrix for the current 7-day period
    tempCED = NaN(length(lat),length(lon),length(idxList));
    tempSST = NaN(length(lat),length(lon),length(idxList));

    % Loop through the files for the current 7-day period and read data
    for j = 1:length(idxList)

        % CED data
        filepath = fullfile(dataCED,CEDfiles(idxList(j)).name);
        load(filepath);
        
        % SST data
        filepath = fullfile(dataSST,SSTfiles(idxList(j)).name);
        sst1     = double(nc_varget(filepath,'sea_surface_temperature'));
        sstData  = squeeze(sst1(1,minLAT:maxLAT,minLON:maxLON));

        % Store the data for the current day in tempData
        tempCED(:,:,j) = magnitude .* mask;
        tempSST(:,:,j) = sstData   .* mask;

    end 

    % Compute the mean Frontal Gradient for the current week
    compositeFG(:,:,i) = nanmean(tempCED,3);

    % Compute the mean Frontal Probability for the current week
    % First, convert data to binary: 1 for data, 0 for NaN
    binarySST = ~isnan(tempSST); % Converts all non-NaN values to 1, NaN to 0
    binaryFRO = ~isnan(tempCED); % Converts all non-NaN values to 1, NaN to 0
    % Second, sum pixels:
    numSSTpix = nansum(binarySST,3); % Number of times the pixel was cloud-free (if cloud = NaN)
    numFROpix = nansum(binaryFRO,3); % Number of times the pixel was identified as a front
    % Third, avoid invalid divisions:
    numSSTpix(numSSTpix == 0) = NaN;
    numFROpix(numFROpix == 0) = NaN;
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
weeklyDates = datetime(wEdges(1:end-1), 'ConvertFrom', 'datenum') + days(3);  % middle of each week
save('CEDsst_WholeDomain_TimeSeries_07d.mat', '-v7.3', ...
     'compositeFG','compositeFP','lon','lat','weeklyDates');
%==========================================================================  
return
