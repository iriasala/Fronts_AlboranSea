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
% Computes FPchl weekly time series for the three subregions of study.
%==========================================================================

%==========================================================================
%% Load cloud coverage vector
%==========================================================================
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\CHL_Vector_TimeSeries_07dMean.mat');
%==========================================================================

%==========================================================================
%% Load Zones masks
%==========================================================================
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Yearly\CHL_MaskZones.mat');
%==========================================================================

%==========================================================================
%% Load CED-CHL data
%==========================================================================
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\CEDCHL_WholeDomain_TimeSeries_07d.mat');
%==========================================================================

%==========================================================================
%% Compute time series with a moving average of 5 points:
%==========================================================================
CFPZ0v = squeeze(nanmean(nanmean(compositeFP,1),2)) .* M80'; % Simple average
CFPZ0m = movmean(CFPZ0v,3,'omitnan') .* M80';                % Moving average
%--------------------------------------------------------------------------
CFPZ1  = compositeFP .* ZONE1;
CFPZ1v = squeeze(nanmean(nanmean(CFPZ1,1),2)) .* M80';       % Simple average
CFPZ1m = movmean(CFPZ1v,3,'omitnan') .* M80';                % Moving average
%--------------------------------------------------------------------------
CFPZ2  = compositeFP .* ZONE2;
CFPZ2v = squeeze(nanmean(nanmean(CFPZ2,1),2)) .* M80';       % Simple average
CFPZ2m = movmean(CFPZ2v,3,'omitnan') .* M80';                % Moving average
%==========================================================================

%==========================================================================  
%% Save data:  
%==========================================================================  
save('FPchl_Vector_TimeSeries_07dMean.mat','-v7.3',...
     'CFPZ0v','CFPZ0m','CFPZ1v','CFPZ1m','CFPZ2v','CFPZ2m','weeklyDates',...
     'M80','invalidZ0','invalidZ1','invalidZ2','Z00nan','Z01nan','Z02nan');  
%==========================================================================  
return