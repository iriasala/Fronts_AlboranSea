close all
clear all
format long g
%==========================================================================

%==========================================================================
%% Script to compute weekly time series:
%--------------------------------------------------------------------------
% Writen by Iria Sala
% Created on 05.03.2025
% Last updated on 18.06.2025 
%--------------------------------------------------------------------------
% Computes CHL weekly time series for the three subregions of study.
%==========================================================================

%==========================================================================
%% Load CHL data
%==========================================================================
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\CHL_WholeDomain_TimeSeries_07d.mat');
%==========================================================================

%==========================================================================
%% Load Zones masks
%==========================================================================
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Yearly\CHL_MaskZones.mat');
%==========================================================================

%==========================================================================
%% Identify and remove maps with a cloud coverage > 80%
%==========================================================================
CHLZ0 = nan(size(compositeMaps));
CHLZ1 = nan(size(compositeMaps));
CHLZ2 = nan(size(compositeMaps));
%--------------------------------------------------------------------------
TPIX = nansum(ZONE1,[1 2]) + nansum(ZONE2,[1 2]);
%==========================================================================
for i = 1:size(compositeMaps,3)

    DATA = compositeMaps(:,:,i);
    
    CPIX = DATA; 
    CPIX(~isnan(CPIX)) = 1;
    CPIX = nansum(CPIX,[1 2]); % Count the number of data pixels
    
    PERC = CPIX / TPIX;        % Percentage of pixels with data
    
    if PERC < 0.2              % Cloud coverage > 80%  
        outPer = NaN;
    else
        outPer = 1;
    end
    
    M80(i) = outPer;

    CHLZ0(:,:,i) = DATA .* outPer;

    CHLZ1(:,:,i) = DATA .* ZONE1 .* outPer;
    CHLZ2(:,:,i) = DATA .* ZONE2 .* outPer;

end
%==========================================================================

%==========================================================================
%% Compute time series with a moving average of 5 points:
%==========================================================================
CHLZ0v = squeeze(nanmean(nanmean(CHLZ0,1),2));
CHLZ0m = movmean(CHLZ0v,5,'omitnan'); % Moving average
%..........................................................................
CHLZ1v = squeeze(nanmean(nanmean(CHLZ1,1),2));
CHLZ1m = movmean(CHLZ1v,5,'omitnan'); % Moving average
%..........................................................................
CHLZ2v = squeeze(nanmean(nanmean(CHLZ2,1),2));
CHLZ2m = movmean(CHLZ2v,5,'omitnan'); % Moving average
%--------------------------------------------------------------------------
% Data points lost due to cloud coverage
Z00nan    = sum(isnan(CHLZ0v)); 
validMap  = ~isnan(CHLZ0v);
invalidZ0 = weeklyDates(~validMap);
%..........................................................................
Z01nan    = sum(isnan(CHLZ1v)); 
validMap  = ~isnan(CHLZ1v);
invalidZ1 = weeklyDates(~validMap);
%..........................................................................
Z02nan    = sum(isnan(CHLZ2v)); 
validMap  = ~isnan(CHLZ2v);
invalidZ2 = weeklyDates(~validMap);
%==========================================================================

%==========================================================================  
%% Save data:  
%==========================================================================  
save('CHL_Vector_TimeSeries_07dMean.mat','-v7.3',...
     'CHLZ0v','CHLZ0m','CHLZ1v','CHLZ1m','CHLZ2v','CHLZ2m','weeklyDates',...
     'M80','invalidZ0','invalidZ1','invalidZ2','Z00nan','Z01nan','Z02nan');  
%==========================================================================  
return