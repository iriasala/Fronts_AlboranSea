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
SSTZ1    = SSTmat .* ZONE1;
SSTZ1vec = squeeze(mean(SSTZ1,[1 2],'omitnan')); % 12×27
SSTZ1avg = mean(SSTZ1vec,2,'omitnan');
SSTZ1std = std(SSTZ1vec,0,2,'omitnan');
%--------------------------------------------------------------------------
% FGsst +  FPsst
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Monthly\CEDsst_WholeDomain_TimeSeries_30d.mat');
%..........................................................................
% Reorganise matrix by year:
FGSSTmat = reshape(compositeFG,350,601,12,[]);
%..........................................................................
FGSSTZ1    = FGSSTmat .* ZONE1;
FGSSTZ1vec = squeeze(mean(FGSSTZ1,[1 2],'omitnan'));  % 12×27
FGSSTZ1avg = mean(FGSSTZ1vec,2,'omitnan');
FGSSTZ1std = std(FGSSTZ1vec,0,2,'omitnan');
%..........................................................................
% Reorganise matrix by year:
FPSSTmat = reshape(compositeFP,350,601,12,[]);
%..........................................................................
FPSSTZ1    = FPSSTmat .* ZONE1;
FPSSTZ1vec = squeeze(mean(FPSSTZ1,[1 2],'omitnan'));  % 12×27
FPSSTZ1avg = mean(FPSSTZ1vec,2,'omitnan');
FPSSTZ1std = std(FPSSTZ1vec,0,2,'omitnan');
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
SSTZ1we = SSTZ1m;
%--------------------------------------------------------------------------
% FGsst
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\FGsst_Vector_TimeSeries_07dMean.mat');
%..........................................................................
FGSSTZ1we = CFGZ1m;
%--------------------------------------------------------------------------
% FPsst
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\FPsst_Vector_TimeSeries_07dMean.mat');
%..........................................................................
FPSSTZ1we = CFPZ1m;
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
CHLZ1    = CHLmat .* ZONE1;
CHLZ1vec = squeeze(mean(CHLZ1,[1 2],'omitnan')); % 12×27
CHLZ1avg = mean(CHLZ1vec,2,'omitnan');
CHLZ1std = std(CHLZ1vec,0,2,'omitnan');
%--------------------------------------------------------------------------
% FGchl +  FPchl
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Monthly\CEDchl_WholeDomain_TimeSeries_30d.mat');
%..........................................................................
% Reorganise matrix by year:
FGCHLmat = reshape(compositeFG,350,601,12,[]);
%..........................................................................
FGCHLZ1    = FGCHLmat .* ZONE1;
FGCHLZ1vec = squeeze(mean(FGCHLZ1,[1 2],'omitnan'));  % 12×27
FGCHLZ1avg = mean(FGCHLZ1vec,2,'omitnan');
FGCHLZ1std = std(FGCHLZ1vec,0,2,'omitnan');
%..........................................................................
% Reorganise matrix by year:
FPCHLmat = reshape(compositeFP,350,601,12,[]);
%..........................................................................
FPCHLZ1    = FPCHLmat .* ZONE1;
FPCHLZ1vec = squeeze(mean(FPCHLZ1,[1 2],'omitnan'));  % 12×27
FPCHLZ1avg = mean(FPCHLZ1vec,2,'omitnan');
FPCHLZ1std = std(FPCHLZ1vec,0,2,'omitnan');
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
CHLZ1we = CHLZ1m;
%--------------------------------------------------------------------------
% FGchl
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\FGchl_Vector_TimeSeries_07dMean.mat');
%..........................................................................
FGCHLZ1we = CFGZ1m;
%--------------------------------------------------------------------------
% FPchl
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\FPchl_Vector_TimeSeries_07dMean.mat');
%..........................................................................
FPCHLZ1we = CFPZ1m;
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
plot(weekSSTDates,SSTZ1we,'.','Color',[0.6 0 0]);
%..........................................................................
fill([monthlyDates fliplr(monthlyDates)],...
     [(SSTZ1avg + SSTZ1std)' fliplr((SSTZ1avg - SSTZ1std)')],...
     [0.5 1.0 0.5],'EdgeColor','none','FaceAlpha',0.15);
plot(monthlyDates,SSTZ1avg,'.-','color',[0.2 0.2 0.2],'LineWidth',2);
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
plot(weekSSTDates,FGSSTZ1we,'.','Color',[0.6 0 0]);
%..........................................................................
fill([monthlyDates fliplr(monthlyDates)],...
     [(FGSSTZ1avg + FGSSTZ1std)' fliplr((FGSSTZ1avg - FGSSTZ1std)')],...
     [0.5 1.0 0.5],'EdgeColor','none','FaceAlpha',0.25); 
plot(monthlyDates,FGSSTZ1avg,'.-','color',[0.2 0.2 0.2],'LineWidth',2);
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
plot(weekSSTDates,FPSSTZ1we,'.','Color',[0.6 0 0]);
%..........................................................................
fill([monthlyDates fliplr(monthlyDates)],...
     [(FPSSTZ1avg + FPSSTZ1std)' fliplr((FPSSTZ1avg - FPSSTZ1std)')],...
     [0.5 1.0 0.5],'EdgeColor','none','FaceAlpha',0.25); 
plot(monthlyDates,FPSSTZ1avg,'.-','color',[0.2 0.2 0.2],'LineWidth',2);
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
plot(weekCHLDates,CHLZ1we,'.','Color',[0.6 0 0]);
%..........................................................................
fill([monthlyDates fliplr(monthlyDates)],...
     [(CHLZ1avg + CHLZ1std)' fliplr((CHLZ1avg - CHLZ1std)')],...
     [0.5 1.0 0.5],'EdgeColor','none','FaceAlpha',0.25); 
plot(monthlyDates,CHLZ1avg,'.-','color',[0.2 0.2 0.2],'LineWidth',2);
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
plot(weekCHLDates,FGCHLZ1we,'.','Color',[0.6 0 0]);
%..........................................................................
fill([monthlyDates fliplr(monthlyDates)],...
     [(FGCHLZ1avg + FGCHLZ1std)' fliplr((FGCHLZ1avg - FGCHLZ1std)')],...
     [0.5 1.0 0.5],'EdgeColor','none','FaceAlpha',0.25); 
plot(monthlyDates,FGCHLZ1avg,'.-','color',[0.2 0.2 0.2],'LineWidth',2);
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
plot(weekCHLDates,FPCHLZ1we,'.','Color',[0.6 0 0]);
%..........................................................................
fill([monthlyDates fliplr(monthlyDates)],...
     [(FPCHLZ1avg + FPCHLZ1std)' fliplr((FPCHLZ1avg - FPCHLZ1std)')],...
     [0.5 1.0 0.5],'EdgeColor','none','FaceAlpha',0.25); 
plot(monthlyDates,FPCHLZ1avg,'.-','color',[0.2 0.2 0.2],'LineWidth',2);
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
print(gcf, '-dpng', 'FIGURE_MOvsWE_SSTvsCHL_Z1.png');
%==========================================================================
return
