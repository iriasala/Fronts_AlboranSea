close all
clear all
%==========================================================================

%==========================================================================  
%% Script to compute 7-day composite images for the study period
%--------------------------------------------------------------------------  
% Written by Iria Sala  
% Created on 20.02.2025  
% Last updated on 18.06.2025  
%==========================================================================

%==========================================================================  
%% Load mask data:  
%==========================================================================  
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\LandMask\LandMask_ROI.mat');  
%..........................................................................
mask = landMask;
%==========================================================================  

%==========================================================================  
%% Define the directory containing the NetCDF files  
%==========================================================================  
dataCHL  = 'G:\My Drive\RESEARCH\DATA\GLOBCOLOUR_CHL1\Daily\';  
CHLfiles = dir(fullfile(dataCHL,'L3m_*GSM*.nc'));  
%--------------------------------------------------------------------------  
dataCED  = 'G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\FrontsCHL\CEDCHL_MATFILES\';  
CEDfiles = dir(fullfile(dataCED,'L3m_*GSM*.mat'));  
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
dates = zeros(nFiles,1); % Preallocate an array to store file dates  
%--------------------------------------------------------------------------  
for i = 1:nFiles
    
    fname = CHLfiles(i).name;
    
    dateStr = regexp(fname, '\d{8}', 'match');
    
    if ~isempty(dateStr)
        dates(i) = datenum(dateStr{1}, 'yyyymmdd');
    else
        error('Filename %s does not contain a date in expected format.', fname);
    end
    
end
%==========================================================================  

%==========================================================================  
%% Extract longitude and latitude vectors:  
%==========================================================================  
firstFile = fullfile(dataCED,CEDfiles(1).name);  
load(firstFile);
%========================================================================== 

%==========================================================================  
%% Sort files by date  
%==========================================================================  
[sortedDates, idx] = sort(dates);  
CHLfiles = CHLfiles(idx);  
%==========================================================================  

%==========================================================================  
%% Initialise containers for composite maps and corresponding dates  
%==========================================================================  
iniDate = datetime(1998,1,1);  % or min(sortedDates)
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
compositeFG = NaN(size(X,1),size(Y,2),nWeeks);  
compositeFP = NaN(size(X,1),size(Y,2),nWeeks);  
%--------------------------------------------------------------------------  
% Loop through the files and compute 7-day composite maps  
for i = 1:nWeeks 
    i
    
    idxList = weeklyFileIndices{i};
    
    if isempty(idxList)
        continue  % skip weeks with no data
    end
    
    % Initialize a temporary matrix for the current 7-day period
    tempCHL = NaN(size(X,1),size(Y,2),length(idxList));  
    tempCED = NaN(size(X,1),size(Y,2),length(idxList));  

    % Loop through the files for the current 7-day period and read data
    for j = 1:length(idxList)
        
        % CED data
        filepath = fullfile(dataCED,CEDfiles(idxList(j)).name);
        load(filepath);
        
        % CHL data
        filepath = fullfile(dataCHL,CHLfiles(idxList(j)).name);  
        chlData = nc_varget(filepath,'CHL1_mean');
        CHLdata = interp2(LON,LAT,chlData,X,Y);

        % Store the data for the current day in tempData
        tempCED(:,:,j) = magnitude .* mask;
        tempCHL(:,:,j) = CHLdata .* mask;

    end  

    % Compute the mean Frontal Gradient for the current week
    compositeFG(:,:,i) = nanmean(tempCED,3);

    % Compute the mean Frontal Probability for the current week
    % First, convert data to binary: 1 for data, 0 for NaN
    binaryCHL = ~isnan(tempCHL); % Converts all non-NaN values to 1, NaN to 0
    binaryFRO = ~isnan(tempCED); % Converts all non-NaN values to 1, NaN to 0
    % Second, sum pixels:
    numCHLpix = nansum(binaryCHL,3); % Number of times the pixel was cloud-free (if cloud = NaN)
    numFROpix = nansum(binaryFRO,3); % Number of times the pixel was identified as a front
    % Third, avoid invalid divisions:
    numCHLpix(numCHLpix == 0) = NaN;
    numFROpix(numFROpix == 0) = NaN;
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
weeklyDates = datetime(wEdges(1:end-1), 'ConvertFrom', 'datenum') + days(3);  % middle of each week
save('CEDchl_WholeDomain_TimeSeries_07d.mat', '-v7.3', ...
     'compositeFG','compositeFP','X','Y','weeklyDates');
%==========================================================================  
return
