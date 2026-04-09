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
% Computes SST weekly time series for the three subregions of study.
%==========================================================================

%==========================================================================
%% Load SST data
%==========================================================================
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\SST_WholeDomain_TimeSeries_07d.mat');
%==========================================================================

%==========================================================================
%% Load Zones masks
%==========================================================================
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Yearly\CHL_MaskZones.mat');
%==========================================================================

%==========================================================================
%% Identify and remove maps with a cloud coverage > 80%
%==========================================================================
SSTZ0 = nan(size(compositeMaps));
SSTZ1 = nan(size(compositeMaps));
SSTZ2 = nan(size(compositeMaps));
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

    SSTZ0(:,:,i) = DATA .* outPer;

    SSTZ1(:,:,i) = DATA .* ZONE1 .* outPer;
    SSTZ2(:,:,i) = DATA .* ZONE2 .* outPer;

end
%==========================================================================

%==========================================================================
%% Compute time series with a moving average of 5 points:
%==========================================================================
SSTZ0v = squeeze(nanmean(nanmean(SSTZ0,1),2));
SSTZ0m = movmean(SSTZ0v,5,'omitnan'); % Moving average
%..........................................................................
SSTZ1v = squeeze(nanmean(nanmean(SSTZ1,1),2));
SSTZ1m = movmean(SSTZ1v,5,'omitnan'); % Moving average
%..........................................................................
SSTZ2v = squeeze(nanmean(nanmean(SSTZ2,1),2));
SSTZ2m = movmean(SSTZ2v,5,'omitnan'); % Moving average
%--------------------------------------------------------------------------
% Data points lost due to cloud coverage
Z00nan    = sum(isnan(SSTZ0v)); 
validMap  = ~isnan(SSTZ0v);
invalidZ0 = weeklyDates(~validMap);
%..........................................................................
Z01nan    = sum(isnan(SSTZ1v)); 
validMap  = ~isnan(SSTZ1v);
invalidZ1 = weeklyDates(~validMap);
%..........................................................................
Z02nan    = sum(isnan(SSTZ2v)); 
validMap  = ~isnan(SSTZ2v);
invalidZ2 = weeklyDates(~validMap);
%==========================================================================

%==========================================================================  
%% Save data:  
%==========================================================================  
save('SST_Vector_TimeSeries_07dMean.mat','-v7.3',...
     'SSTZ0v','SSTZ0m','SSTZ1v','SSTZ1m','SSTZ2v','SSTZ2m','weeklyDates',...
     'M80','invalidZ0','invalidZ1','invalidZ2','Z00nan','Z01nan','Z02nan');  
%==========================================================================  
return