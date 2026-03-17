close all
clear all
%==========================================================================

%==========================================================================
%% Script to plot bloom phenology using weekly mean daya:
%--------------------------------------------------------------------------
% Writen by Iria Sala
% Created on 25.07.2025
% Last updated on 25.07.2025 
%==========================================================================


%==========================================================================
% ---------------------------------- SST ---------------------------------%
%==========================================================================
% SST
%--------------------------------------------------------------------------
load WPS_SST_ZONE2_07d.mat
%..........................................................................
SST_Z2_SSTm      = DATAint;
SST_Z2_mSST      = DATAave;
SST_Z2_Time      = TIME;
SST_Z2_coi       = coi;
SST_Z2_cor       = cor;
SST_Z2_global_ws = global_ws;
SST_Z2_gm_ws     = gm_ws;
SST_Z2_period    = period;
SST_Z2_power     = power;
SST_Z2_puis      = puis;
SST_Z2_pvalue    = pvalue;
SST_Z2_pvp       = pvp;
%..........................................................................
clear DATAint DATAave TIME coi cor global_ws gm_ws period power puis pvalue pvp
%==========================================================================
% FGsst
%--------------------------------------------------------------------------
load WPS_FGsst_ZONE2_07d.mat
%..........................................................................
FGsst_Z2_SSTm      = DATAint;
FGsst_Z2_mSST      = DATAave;
FGsst_Z2_Time      = TIME;
FGsst_Z2_coi       = coi;
FGsst_Z2_cor       = cor;
FGsst_Z2_global_ws = global_ws;
FGsst_Z2_gm_ws     = gm_ws;
FGsst_Z2_period    = period;
FGsst_Z2_power     = power;
FGsst_Z2_puis      = puis;
FGsst_Z2_pvalue    = pvalue;
FGsst_Z2_pvp       = pvp;
%..........................................................................
clear DATAint DATAave TIME coi cor global_ws gm_ws period power puis pvalue pvp
%==========================================================================
% FPsst
%--------------------------------------------------------------------------
load WPS_FPsst_ZONE2_07d.mat
%..........................................................................
FPsst_Z2_SSTm      = DATAint;
FPsst_Z2_mSST      = DATAave;
FPsst_Z2_Time      = TIME;
FPsst_Z2_coi       = coi;
FPsst_Z2_cor       = cor;
FPsst_Z2_global_ws = global_ws;
FPsst_Z2_gm_ws     = gm_ws;
FPsst_Z2_period    = period;
FPsst_Z2_power     = power;
FPsst_Z2_puis      = puis;
FPsst_Z2_pvalue    = pvalue;
FPsst_Z2_pvp       = pvp;
%..........................................................................
clear DATAint DATAave TIME coi cor global_ws gm_ws period power puis pvalue pvp
%==========================================================================



%==========================================================================
% ---------------------------------- CHL ---------------------------------%
%==========================================================================
% CHL
%--------------------------------------------------------------------------
load WPS_CHL_ZONE2_07d.mat
%..........................................................................
CHL_Z2_CHLm      = DATAint;
CHL_Z2_mCHL      = DATAave;
CHL_Z2_Time      = TIME;
CHL_Z2_coi       = coi;
CHL_Z2_cor       = cor;
CHL_Z2_global_ws = global_ws;
CHL_Z2_gm_ws     = gm_ws;
CHL_Z2_period    = period;
CHL_Z2_power     = power;
CHL_Z2_puis      = puis;
CHL_Z2_pvalue    = pvalue;
CHL_Z2_pvp       = pvp;
%..........................................................................
clear DATAint DATAave TIME coi cor global_ws gm_ws period power puis pvalue pvp
%==========================================================================
% FGchl
%--------------------------------------------------------------------------
load WPS_FGchl_ZONE2_07d.mat
%..........................................................................
FGchl_Z2_CHLm      = DATAint;
FGchl_Z2_mCHL      = DATAave;
FGchl_Z2_Time      = TIME;
FGchl_Z2_coi       = coi;
FGchl_Z2_cor       = cor;
FGchl_Z2_global_ws = global_ws;
FGchl_Z2_gm_ws     = gm_ws;
FGchl_Z2_period    = period;
FGchl_Z2_power     = power;
FGchl_Z2_puis      = puis;
FGchl_Z2_pvalue    = pvalue;
FGchl_Z2_pvp       = pvp;
%..........................................................................
clear DATAint DATAave TIME coi cor global_ws gm_ws period power puis pvalue pvp
%==========================================================================
% FPchl
%--------------------------------------------------------------------------
load WPS_FPchl_ZONE2_07d.mat
%..........................................................................
FPchl_Z2_CHLm      = DATAint;
FPchl_Z2_mCHL      = DATAave;
FPchl_Z2_Time      = TIME;
FPchl_Z2_coi       = coi;
FPchl_Z2_cor       = cor;
FPchl_Z2_global_ws = global_ws;
FPchl_Z2_gm_ws     = gm_ws;
FPchl_Z2_period    = period;
FPchl_Z2_power     = power;
FPchl_Z2_puis      = puis;
FPchl_Z2_pvalue    = pvalue;
FPchl_Z2_pvp       = pvp;
%..........................................................................
clear DATAint DATAave TIME coi cor global_ws gm_ws period power puis pvalue pvp
%==========================================================================


%==========================================================================
%% Time vector:
%==========================================================================
Tall = datenum(1998:2024,1,1);
Tval = Tall(1:3:end);
Tvec = 1998:3:2024;
%==========================================================================


%==========================================================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIGURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
make_it_tight = true;
% m = distancia entre subplots
% n = distancia a los bordes inferior y superior
% p = distancia a los bordes derecho e izqierdo
subplot = @(m,n,p) subtightplot (m, n, p, [0.03 0.02], [0.12 0.03], [0.07 0.02]);
if ~make_it_tight,  clear subplot;  end
%..........................................................................
Fig = figure;
set(gcf, 'Color','white');
set(Fig, 'Position',[860, 60,1000,450]);
%==========================================================================
subplot(2,3,1);
hold on
box on
%..........................................................................
imagesc(SST_Z2_Time,log2(SST_Z2_period),SST_Z2_power.^SST_Z2_puis);
%..........................................................................
plot(SST_Z2_Time,log2(SST_Z2_coi),'k')
%..........................................................................
contour(SST_Z2_Time,log2(SST_Z2_period),SST_Z2_pvp,...
    [SST_Z2_pvalue/SST_Z2_cor,SST_Z2_pvalue/SST_Z2_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
% xlabel('Time (years)')
xlim([CHL_Z2_Time(1) CHL_Z2_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',[]);
%..........................................................................
ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(SST_Z2_period))):fix(log2(SST_Z2_period(end))));
set(gca,'YLim',log2([min(SST_Z2_period),SST_Z2_period(end)]),'YDir','reverse',...
	    'YTick',log2(Yticks(:)),'YTickLabel',Yticks(:))
%..........................................................................
caxis([0 3]);
colormap("jet")
%..........................................................................
str = {'a'};
text(733801,-3.30,str,'LineStyle','none','HorizontalAlignment','center',...
                      'FontWeight','bold','Color','w','FontSize',12);
%..........................................................................
hold off
%--------------------------------------------------------------------------
set(gca,'FontSize',11,'FontName','Times');
%==========================================================================
subplot(2,3,2);
hold on
box on
%..........................................................................
imagesc(FGsst_Z2_Time,log2(FGsst_Z2_period),FGsst_Z2_power.^FGsst_Z2_puis);
%..........................................................................
plot(FGsst_Z2_Time,log2(FGsst_Z2_coi),'k')
%..........................................................................
contour(FGsst_Z2_Time,log2(FGsst_Z2_period),FGsst_Z2_pvp,...
    [FGsst_Z2_pvalue/FGsst_Z2_cor,FGsst_Z2_pvalue/FGsst_Z2_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
% xlabel('Time (years)')
xlim([FGchl_Z2_Time(1) FGchl_Z2_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',[]);
%..........................................................................
% ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(FGsst_Z2_period))):fix(log2(FGsst_Z2_period(end))));
set(gca,'YLim',log2([min(FGsst_Z2_period),FGsst_Z2_period(end)]),'YDir','reverse',...
	    'YTick',log2(Yticks(:)),'YTickLabel',[])
%..........................................................................
caxis([0 3]);
colormap("jet")
%..........................................................................
str = {'b'};
text(733801,-3.30,str,'LineStyle','none','HorizontalAlignment','center',...
                      'FontWeight','bold','Color','w','FontSize',12);
%..........................................................................
hold off
%--------------------------------------------------------------------------
set(gca,'FontSize',11,'FontName','Times');
%==========================================================================
subplot(2,3,3);
hold on
box on
%..........................................................................
imagesc(FPsst_Z2_Time,log2(FPsst_Z2_period),FPsst_Z2_power.^FPsst_Z2_puis);
%..........................................................................
plot(FPsst_Z2_Time,log2(FPsst_Z2_coi),'k')
%..........................................................................
contour(FPsst_Z2_Time,log2(FPsst_Z2_period),FPsst_Z2_pvp,...
    [FPsst_Z2_pvalue/FPsst_Z2_cor,FPsst_Z2_pvalue/FPsst_Z2_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
% xlabel('Time (years)')
xlim([FPchl_Z2_Time(1) FPchl_Z2_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',[]);
%..........................................................................
% ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(FPsst_Z2_period))):fix(log2(FPsst_Z2_period(end))));
set(gca,'YLim',log2([min(FPsst_Z2_period),FPsst_Z2_period(end)]),'YDir','reverse',...
	    'YTick',log2(Yticks(:)),'YTickLabel',[])
%..........................................................................
caxis([0 3]);
colormap("jet")
%..........................................................................
str = {'c'};
text(733801,-3.30,str,'LineStyle','none','HorizontalAlignment','center',...
                      'FontWeight','bold','Color','w','FontSize',12);
%..........................................................................
hold off
%--------------------------------------------------------------------------
set(gca,'FontSize',11,'FontName','Times');
%==========================================================================
subplot(2,3,4);
hold on
box on
%..........................................................................
imagesc(CHL_Z2_Time,log2(CHL_Z2_period),CHL_Z2_power.^CHL_Z2_puis);
%..........................................................................
plot(CHL_Z2_Time,log2(CHL_Z2_coi),'k')
%..........................................................................
contour(CHL_Z2_Time,log2(CHL_Z2_period),CHL_Z2_pvp,...
    [CHL_Z2_pvalue/CHL_Z2_cor,CHL_Z2_pvalue/CHL_Z2_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
xlabel('Time (years)')
xlim([CHL_Z2_Time(1) CHL_Z2_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',Tvec);
%..........................................................................
ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(CHL_Z2_period))):fix(log2(CHL_Z2_period(end))));
set(gca,'YLim',log2([min(CHL_Z2_period),CHL_Z2_period(end)]),'YDir','reverse',...
	    'YTick',log2(Yticks(:)),'YTickLabel',Yticks(:))
%..........................................................................
caxis([0 3]);
colormap("jet")
%..........................................................................
str = {'d'};
text(730221,-3.30,str,'LineStyle','none','HorizontalAlignment','center',...
                      'FontWeight','bold','Color','w','FontSize',12);
%..........................................................................
hold off
%--------------------------------------------------------------------------
set(gca,'FontSize',11,'FontName','Times');
%==========================================================================
subplot(2,3,5);
hold on
box on
%..........................................................................
imagesc(FGchl_Z2_Time,log2(FGchl_Z2_period),FGchl_Z2_power.^FGchl_Z2_puis);
%..........................................................................
plot(FGchl_Z2_Time,log2(FGchl_Z2_coi),'k')
%..........................................................................
contour(FGchl_Z2_Time,log2(FGchl_Z2_period),FGchl_Z2_pvp,...
    [FGchl_Z2_pvalue/FGchl_Z2_cor,FGchl_Z2_pvalue/FGchl_Z2_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
xlabel('Time (years)')
xlim([FGchl_Z2_Time(1) FGchl_Z2_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',Tvec);
%..........................................................................
% ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(FGchl_Z2_period))):fix(log2(FGchl_Z2_period(end))));
set(gca,'YLim',log2([min(FGchl_Z2_period),FGchl_Z2_period(end)]),'YDir','reverse',...
	    'YTick',log2(Yticks(:)),'YTickLabel',[])
%..........................................................................
caxis([0 3]);
colormap("jet")
%..........................................................................
str = {'e'};
text(730221,-3.30,str,'LineStyle','none','HorizontalAlignment','center',...
                      'FontWeight','bold','Color','w','FontSize',12);
%..........................................................................
hold off
%--------------------------------------------------------------------------
set(gca,'FontSize',11,'FontName','Times');
%==========================================================================
subplot(2,3,6);
hold on
box on
%..........................................................................
imagesc(FPchl_Z2_Time,log2(FPchl_Z2_period),FPchl_Z2_power.^FPchl_Z2_puis);
%..........................................................................
plot(FPchl_Z2_Time,log2(FPchl_Z2_coi),'k')
%..........................................................................
contour(FPchl_Z2_Time,log2(FPchl_Z2_period),FPchl_Z2_pvp,...
    [FPchl_Z2_pvalue/FPchl_Z2_cor,FPchl_Z2_pvalue/FPchl_Z2_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
xlabel('Time (years)')
xlim([FPchl_Z2_Time(1) FPchl_Z2_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',Tvec);
%..........................................................................
% ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(FPchl_Z2_period))):fix(log2(FPchl_Z2_period(end))));
set(gca,'YLim',log2([min(FPchl_Z2_period),FPchl_Z2_period(end)]),'YDir','reverse',...
	    'YTick',log2(Yticks(:)),'YTickLabel',[])
%..........................................................................
caxis([0 3]);
colormap("jet")
%..........................................................................
str = {'f'};
text(730221,-3.30,str,'LineStyle','none','HorizontalAlignment','center',...
                      'FontWeight','bold','Color','w','FontSize',12);
%..........................................................................
hold off
%--------------------------------------------------------------------------
set(gca,'FontSize',11,'FontName','Times');
%==========================================================================
%% Save the figure:
%==========================================================================
set(gcf,'PaperPositionMode','auto');
print(gcf, '-dpng', 'FIGURE_WPS_SSTvsCHL_Z2.png');
%==========================================================================
return

