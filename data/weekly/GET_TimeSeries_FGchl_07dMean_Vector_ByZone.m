close all
clear
format long g
%==========================================================================

%==========================================================================
%% Script to compute weekly time series:
%--------------------------------------------------------------------------
% Writen by Iria Sala
% Created on 05.03.2025
% Last updated on 18.06.2025 
%--------------------------------------------------------------------------
% Computes FGchl weekly time series for the three subregions of study.
%==========================================================================

%==========================================================================
%% Load CED-CHL data
%==========================================================================
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\CEDCHL_WholeDomain_TimeSeries_07d.mat');
%==========================================================================

%==========================================================================
%% Load cloud coverage vector
%==========================================================================
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\CHL_Vector_TimeSeries_07dMean.mat');
%==========================================================================

%==========================================================================
%% Remove weeks with cloud coverage > 80%
%==========================================================================
M80map = repmat(M80,[size(compositeFG,1),1,size(compositeFG,2)]);
M80map = permute(M80map,[1,3,2]);
FGmaps = compositeFG .* M80map;
%==========================================================================


%==========================================================================
%% Load Zones masks
%==========================================================================
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Yearly\CHL_MaskZones.mat');
%==========================================================================


%==========================================================================
%% Compute time series with a moving average of 5 points:
%==========================================================================
CFGZ0v = squeeze(nanmean(nanmean(compositeFG,1),2)) .* M80'; % Simple average
CFGZ0m = movmean(CFGZ0v,3,'omitnan') .* M80';                % Moving average
%--------------------------------------------------------------------------
CFGZ1  = compositeFG .* ZONE1;
CFGZ1v = squeeze(nanmean(nanmean(CFGZ1,1),2)) .* M80';       % Simple average
CFGZ1m = movmean(CFGZ1v,3,'omitnan') .* M80';                % Moving average
%--------------------------------------------------------------------------
CFGZ2  = compositeFG .* ZONE2;
CFGZ2v = squeeze(nanmean(nanmean(CFGZ2,1),2)) .* M80';       % Simple average
CFGZ2m = movmean(CFGZ2v,3,'omitnan') .* M80';                % Moving average
%==========================================================================

%==========================================================================  
%% Save data:  
%==========================================================================  
save('FGchl_Vector_TimeSeries_07dMean.mat','-v7.3',...
     'CFGZ0v','CFGZ0m','CFGZ1v','CFGZ1m','CFGZ2v','CFGZ2m','weeklyDates',...
     'M80','invalidZ0','invalidZ1','invalidZ2','Z00nan','Z01nan','Z02nan');
%==========================================================================  
return