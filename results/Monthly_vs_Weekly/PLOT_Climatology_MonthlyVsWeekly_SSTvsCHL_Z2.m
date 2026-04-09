close all
clear all
format long g
%==========================================================================

%==========================================================================
%% Script to plot monthly climatology vs weekly mean vectors:
%--------------------------------------------------------------------------
% Writen by Iria Sala
% Created on 21.07.2025
% Last updated on 29.07.2025 
%--------------------------------------------------------------------------
% This plot gives us an idea on how monthly climatolgy masks the bloom timing.
%==========================================================================


%==========================================================================
%% Load zones mask for climatology data:
%==========================================================================
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Yearly\CHL_MaskZones.mat');
%==========================================================================


%==========================================================================
% ---------------------------------- SST ---------------------------------%
%==========================================================================

%==========================================================================
%% Load monthly climatoloty data: CHL, FGchl, FPchl
%==========================================================================
% SST
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Monthly\SST_WholeDomain_TimeSeries_30d.mat');
%..........................................................................
% Reorganise matrix by year:
SSTmat = reshape(compositeMaps,350,601,12,[]);
%..........................................................................
SSTZ2    = SSTmat .* ZONE2;
SSTZ2vec = squeeze(mean(SSTZ2,[1 2],'omitnan')); % 12×27
SSTZ2avg = mean(SSTZ2vec,2,'omitnan');
SSTZ2std = std(SSTZ2vec,0,2,'omitnan');
%--------------------------------------------------------------------------
% FGsst +  FPsst
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Monthly\CEDsst_WholeDomain_TimeSeries_30d.mat');
%..........................................................................
% Reorganise matrix by year:
FGSSTmat = reshape(compositeFG,350,601,12,[]);
%..........................................................................
FGSSTZ2    = FGSSTmat .* ZONE2;
FGSSTZ2vec = squeeze(mean(FGSSTZ2,[1 2],'omitnan'));  % 12×27
FGSSTZ2avg = mean(FGSSTZ2vec,2,'omitnan');
FGSSTZ2std = std(FGSSTZ2vec,0,2,'omitnan');
%..........................................................................
% Reorganise matrix by year:
FPSSTmat = reshape(compositeFP,350,601,12,[]);
%..........................................................................
FPSSTZ2    = FPSSTmat .* ZONE2;
FPSSTZ2vec = squeeze(mean(FPSSTZ2,[1 2],'omitnan'));  % 12×27
FPSSTZ2avg = mean(FPSSTZ2vec,2,'omitnan');
FPSSTZ2std = std(FPSSTZ2vec,0,2,'omitnan');
%--------------------------------------------------------------------------
% Time: Julian days
monthlyDates = datetime(2000,1:12,15);
monthlyDates = day(monthlyDates,'dayofyear');
%==========================================================================


%==========================================================================
%% Load weekly data: SST, FGsst, FPsst
%==========================================================================
% SST
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\SST_Vector_TimeSeries_07dMean.mat');
%..........................................................................
SSTZ2we = SSTZ2m;
%--------------------------------------------------------------------------
% FGsst
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\FGsst_Vector_TimeSeries_07dMean.mat');
%..........................................................................
FGSSTZ2we = CFGZ2m;
%--------------------------------------------------------------------------
% FPsst
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\FPsst_Vector_TimeSeries_07dMean.mat');
%..........................................................................
FPSSTZ2we = CFPZ2m;
%--------------------------------------------------------------------------
% Time: Julian days
weekSSTDates = day(weeklyDates,'dayofyear');
%==========================================================================



%==========================================================================
% ---------------------------------- CHL ---------------------------------%
%==========================================================================

%==========================================================================
%% Load monthly climatoloty data: CHL, FGchl, FPchl
%==========================================================================
% CHL
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Monthly\CHL_WholeDomain_TimeSeries_30d.mat');
%..........................................................................
% Reorganise matrix by year:
CHLmat = reshape(compositeMaps,350,601,12,[]);
%..........................................................................
CHLZ2    = CHLmat .* ZONE2;
CHLZ2vec = squeeze(mean(CHLZ2,[1 2],'omitnan')); % 12×27
CHLZ2avg = mean(CHLZ2vec,2,'omitnan');
CHLZ2std = std(CHLZ2vec,0,2,'omitnan');
%--------------------------------------------------------------------------
% FGchl +  FPchl
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Monthly\CEDchl_WholeDomain_TimeSeries_30d.mat');
%..........................................................................
% Reorganise matrix by year:
FGCHLmat = reshape(compositeFG,350,601,12,[]);
%..........................................................................
FGCHLZ2    = FGCHLmat .* ZONE2;
FGCHLZ2vec = squeeze(mean(FGCHLZ2,[1 2],'omitnan'));  % 12×27
FGCHLZ2avg = mean(FGCHLZ2vec,2,'omitnan');
FGCHLZ2std = std(FGCHLZ2vec,0,2,'omitnan');
%..........................................................................
% Reorganise matrix by year:
FPCHLmat = reshape(compositeFP,350,601,12,[]);
%..........................................................................
FPCHLZ2    = FPCHLmat .* ZONE2;
FPCHLZ2vec = squeeze(mean(FPCHLZ2,[1 2],'omitnan'));  % 12×27
FPCHLZ2avg = mean(FPCHLZ2vec,2,'omitnan');
FPCHLZ2std = std(FPCHLZ2vec,0,2,'omitnan');
%--------------------------------------------------------------------------
% Time: Julian days
monthlyDates = datetime(2000,1:12,15);
monthlyDates = day(monthlyDates,'dayofyear');
%==========================================================================


%==========================================================================
%% Load weekly data: CHL, FGchl, FPchl
%==========================================================================
% CHL
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\CHL_Vector_TimeSeries_07dMean.mat');
%..........................................................................
CHLZ2we = CHLZ2m;
%--------------------------------------------------------------------------
% FGchl
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\FGchl_Vector_TimeSeries_07dMean.mat');
%..........................................................................
FGCHLZ2we = CFGZ2m;
%--------------------------------------------------------------------------
% FPchl
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\FPchl_Vector_TimeSeries_07dMean.mat');
%..........................................................................
FPCHLZ2we = CFPZ2m;
%--------------------------------------------------------------------------
% Time: Julian days
weekCHLDates = day(weeklyDates,'dayofyear');
%==========================================================================

%==========================================================================
% Plot config:
%==========================================================================
% Time vector:
Tvec = [1 32 60 91 121 152 182 213 244 274 305 335];       % Time ticks
Tout = {'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'};  % Time labels
%==========================================================================


%==========================================================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIGURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
make_it_tight = true;
% m = distancia entre subplots
% n = distancia a los bordes inferior y superior
% p = distancia a los bordes derecho e izqierdo
subplot = @(m,n,p) subtightplot (m, n, p, [0.04 0.06], [0.12 0.03], [0.06 0.02]);
if ~make_it_tight,  clear subplot;  end
%..........................................................................
Fig = figure;
set(gcf, 'Color','white');
set(Fig, 'Position',[860, 60,1100,450]);
%==========================================================================
subplot(2,3,1);
hold on; grid on; box on;
%..........................................................................
plot(weekSSTDates,SSTZ2we,'.','Color',[0.6 0 0]);
%..........................................................................
fill([monthlyDates fliplr(monthlyDates)],...
     [(SSTZ2avg + SSTZ2std)' fliplr((SSTZ2avg - SSTZ2std)')],...
     [0.5 1.0 0.5],'EdgeColor','none','FaceAlpha',0.15);
plot(monthlyDates,SSTZ2avg,'.-','color',[0.2 0.2 0.2],'LineWidth',2);
%..........................................................................
% xlabel('Time (months)'); 
xlim([1 365]);
set(gca,'XTick',Tvec,'XTickLabel',[])
%..........................................................................
ylabel('SST (ºC)')
ylim([14 26]);
%..........................................................................
str = {'a'};
text(31,25,str,'LineStyle','none','HorizontalAlignment','center',...
                      'FontWeight','bold','Color','k','FontSize',12);
%..........................................................................
hold off
%--------------------------------------------------------------------------
set(gca,'FontSize',11,'FontName','Times');
%==========================================================================
subplot(2,3,2);
hold on; grid on; box on;
%..........................................................................
plot(weekSSTDates,FGSSTZ2we,'.','Color',[0.6 0 0]);
%..........................................................................
fill([monthlyDates fliplr(monthlyDates)],...
     [(FGSSTZ2avg + FGSSTZ2std)' fliplr((FGSSTZ2avg - FGSSTZ2std)')],...
     [0.5 1.0 0.5],'EdgeColor','none','FaceAlpha',0.25); 
plot(monthlyDates,FGSSTZ2avg,'.-','color',[0.2 0.2 0.2],'LineWidth',2);
%..........................................................................
% xlabel('Time (months)'); 
xlim([1 365]);
set(gca,'XTick',Tvec,'XTickLabel',[])
%..........................................................................
ylabel('FGsst (ºC km^{-1})')
ylim([0 1]);
%..........................................................................
str = {'b'};
text(31,0.9,str,'LineStyle','none','HorizontalAlignment','center',...
                      'FontWeight','bold','Color','k','FontSize',12);
%..........................................................................
hold off
%--------------------------------------------------------------------------
set(gca,'FontSize',11,'FontName','Times');
%==========================================================================
subplot(2,3,3);
hold on; grid on; box on;
%..........................................................................
plot(weekSSTDates,FPSSTZ2we,'.','Color',[0.6 0 0]);
%..........................................................................
fill([monthlyDates fliplr(monthlyDates)],...
     [(FPSSTZ2avg + FPSSTZ2std)' fliplr((FPSSTZ2avg - FPSSTZ2std)')],...
     [0.5 1.0 0.5],'EdgeColor','none','FaceAlpha',0.25); 
plot(monthlyDates,FPSSTZ2avg,'.-','color',[0.2 0.2 0.2],'LineWidth',2);
%..........................................................................
% xlabel('Time (months)'); 
xlim([1 365]);
set(gca,'XTick',Tvec,'XTickLabel',[])
%..........................................................................
ylabel('FPsst (%)')
ylim([50 100]);
%..........................................................................
str = {'c'};
text(31,95,str,'LineStyle','none','HorizontalAlignment','center',...
                      'FontWeight','bold','Color','k','FontSize',12);
%..........................................................................
hold off
%--------------------------------------------------------------------------
set(gca,'FontSize',11,'FontName','Times');
%==========================================================================
subplot(2,3,4);
hold on; grid on; box on;
%..........................................................................
plot(weekCHLDates,CHLZ2we,'.','Color',[0.6 0 0]);
%..........................................................................
fill([monthlyDates fliplr(monthlyDates)],...
     [(CHLZ2avg + CHLZ2std)' fliplr((CHLZ2avg - CHLZ2std)')],...
     [0.5 1.0 0.5],'EdgeColor','none','FaceAlpha',0.25); 
plot(monthlyDates,CHLZ2avg,'.-','color',[0.2 0.2 0.2],'LineWidth',2);
%..........................................................................
xlabel('Time (months)'); 
xlim([1 365]);
set(gca,'XTick',Tvec,'XTickLabel',Tout)
%..........................................................................
ylabel('Chl-a (mg m^{-3})')
ylim([0 1.8]);
yticks(0:0.4:1.8);  % or whatever makes sense for your data range
%..........................................................................
str = {'d'};
text(31,1.65,str,'LineStyle','none','HorizontalAlignment','center',...
                      'FontWeight','bold','Color','k','FontSize',12);
%..........................................................................
hold off
%--------------------------------------------------------------------------
set(gca,'FontSize',11,'FontName','Times');
%==========================================================================
subplot(2,3,5);
hold on; grid on; box on;
%..........................................................................
plot(weekCHLDates,FGCHLZ2we,'.','Color',[0.6 0 0]);
%..........................................................................
fill([monthlyDates fliplr(monthlyDates)],...
     [(FGCHLZ2avg + FGCHLZ2std)' fliplr((FGCHLZ2avg - FGCHLZ2std)')],...
     [0.5 1.0 0.5],'EdgeColor','none','FaceAlpha',0.25); 
plot(monthlyDates,FGCHLZ2avg,'.-','color',[0.2 0.2 0.2],'LineWidth',2);
%..........................................................................
xlabel('Time (months)'); 
xlim([1 365]);
set(gca,'XTick',Tvec,'XTickLabel',Tout)
%..........................................................................
ylabel('FGchl (mg m^{-3} km^{-1})')
ylim([0.05 0.35]);
%..........................................................................
str = {'e'};
text(31,0.325,str,'LineStyle','none','HorizontalAlignment','center',...
                      'FontWeight','bold','Color','k','FontSize',12);
%..........................................................................
hold off
%--------------------------------------------------------------------------
set(gca,'FontSize',11,'FontName','Times');
%==========================================================================
subplot(2,3,6);
hold on; grid on; box on;
%..........................................................................
plot(weekCHLDates,FPCHLZ2we,'.','Color',[0.6 0 0]);
%..........................................................................
fill([monthlyDates fliplr(monthlyDates)],...
     [(FPCHLZ2avg + FPCHLZ2std)' fliplr((FPCHLZ2avg - FPCHLZ2std)')],...
     [0.5 1.0 0.5],'EdgeColor','none','FaceAlpha',0.25); 
plot(monthlyDates,FPCHLZ2avg,'.-','color',[0.2 0.2 0.2],'LineWidth',2);
%..........................................................................
xlabel('Time (months)'); 
xlim([1 365]);
set(gca,'XTick',Tvec,'XTickLabel',Tout)
%..........................................................................
ylabel('FPchl (%)')
ylim([50 100]);
%..........................................................................
str = {'f'};
text(31,95,str,'LineStyle','none','HorizontalAlignment','center',...
                      'FontWeight','bold','Color','k','FontSize',12);
%..........................................................................
hold off
%--------------------------------------------------------------------------
set(gca,'FontSize',11,'FontName','Times');
%==========================================================================
%% Save the figure:
%==========================================================================
set(gcf,'PaperPositionMode','auto');
print(gcf, '-dpng', 'FIGURE_MOvsWE_SSTvsCHL_Z2.png');
%==========================================================================
return
