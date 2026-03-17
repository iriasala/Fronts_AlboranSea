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
load WPS_SST_ZONE1_07d.mat
%..........................................................................
SST_Z1_SSTm      = DATAint;
SST_Z1_mSST      = DATAave;
SST_Z1_Time      = TIME;
SST_Z1_coi       = coi;
SST_Z1_cor       = cor;
SST_Z1_global_ws = global_ws;
SST_Z1_gm_ws     = gm_ws;
SST_Z1_period    = period;
SST_Z1_power     = power;
SST_Z1_puis      = puis;
SST_Z1_pvalue    = pvalue;
SST_Z1_pvp       = pvp;
%..........................................................................
clear DATAint DATAave TIME coi cor global_ws gm_ws period power puis pvalue pvp
%==========================================================================
% FGsst
%--------------------------------------------------------------------------
load WPS_FGsst_ZONE1_07d.mat
%..........................................................................
FGsst_Z1_SSTm      = DATAint;
FGsst_Z1_mSST      = DATAave;
FGsst_Z1_Time      = TIME;
FGsst_Z1_coi       = coi;
FGsst_Z1_cor       = cor;
FGsst_Z1_global_ws = global_ws;
FGsst_Z1_gm_ws     = gm_ws;
FGsst_Z1_period    = period;
FGsst_Z1_power     = power;
FGsst_Z1_puis      = puis;
FGsst_Z1_pvalue    = pvalue;
FGsst_Z1_pvp       = pvp;
%..........................................................................
clear DATAint DATAave TIME coi cor global_ws gm_ws period power puis pvalue pvp
%==========================================================================
% FPsst
%--------------------------------------------------------------------------
load WPS_FPsst_ZONE1_07d.mat
%..........................................................................
FPsst_Z1_SSTm      = DATAint;
FPsst_Z1_mSST      = DATAave;
FPsst_Z1_Time      = TIME;
FPsst_Z1_coi       = coi;
FPsst_Z1_cor       = cor;
FPsst_Z1_global_ws = global_ws;
FPsst_Z1_gm_ws     = gm_ws;
FPsst_Z1_period    = period;
FPsst_Z1_power     = power;
FPsst_Z1_puis      = puis;
FPsst_Z1_pvalue    = pvalue;
FPsst_Z1_pvp       = pvp;
%..........................................................................
clear DATAint DATAave TIME coi cor global_ws gm_ws period power puis pvalue pvp
%==========================================================================



%==========================================================================
% ---------------------------------- CHL ---------------------------------%
%==========================================================================
% CHL
%--------------------------------------------------------------------------
load WPS_CHL_ZONE1_07d.mat
%..........................................................................
CHL_Z1_CHLm      = DATAint;
CHL_Z1_mCHL      = DATAave;
CHL_Z1_Time      = TIME;
CHL_Z1_coi       = coi;
CHL_Z1_cor       = cor;
CHL_Z1_global_ws = global_ws;
CHL_Z1_gm_ws     = gm_ws;
CHL_Z1_period    = period;
CHL_Z1_power     = power;
CHL_Z1_puis      = puis;
CHL_Z1_pvalue    = pvalue;
CHL_Z1_pvp       = pvp;
%..........................................................................
clear DATAint DATAave TIME coi cor global_ws gm_ws period power puis pvalue pvp
%==========================================================================
% FGchl
%--------------------------------------------------------------------------
load WPS_FGchl_ZONE1_07d.mat
%..........................................................................
FGchl_Z1_CHLm      = DATAint;
FGchl_Z1_mCHL      = DATAave;
FGchl_Z1_Time      = TIME;
FGchl_Z1_coi       = coi;
FGchl_Z1_cor       = cor;
FGchl_Z1_global_ws = global_ws;
FGchl_Z1_gm_ws     = gm_ws;
FGchl_Z1_period    = period;
FGchl_Z1_power     = power;
FGchl_Z1_puis      = puis;
FGchl_Z1_pvalue    = pvalue;
FGchl_Z1_pvp       = pvp;
%..........................................................................
clear DATAint DATAave TIME coi cor global_ws gm_ws period power puis pvalue pvp
%==========================================================================
% FPchl
%--------------------------------------------------------------------------
load WPS_FPchl_ZONE1_07d.mat
%..........................................................................
FPchl_Z1_CHLm      = DATAint;
FPchl_Z1_mCHL      = DATAave;
FPchl_Z1_Time      = TIME;
FPchl_Z1_coi       = coi;
FPchl_Z1_cor       = cor;
FPchl_Z1_global_ws = global_ws;
FPchl_Z1_gm_ws     = gm_ws;
FPchl_Z1_period    = period;
FPchl_Z1_power     = power;
FPchl_Z1_puis      = puis;
FPchl_Z1_pvalue    = pvalue;
FPchl_Z1_pvp       = pvp;
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
imagesc(SST_Z1_Time,log2(SST_Z1_period),SST_Z1_power.^SST_Z1_puis);
%..........................................................................
plot(SST_Z1_Time,log2(SST_Z1_coi),'k')
%..........................................................................
contour(SST_Z1_Time,log2(SST_Z1_period),SST_Z1_pvp,...
    [SST_Z1_pvalue/SST_Z1_cor,SST_Z1_pvalue/SST_Z1_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
% xlabel('Time (years)')
xlim([CHL_Z1_Time(1) CHL_Z1_Time(end)]); 
set(gca,'XTick',Tval,'XTickLabel',[]);
%..........................................................................
ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(SST_Z1_period))):fix(log2(SST_Z1_period(end))));
set(gca,'YLim',log2([min(SST_Z1_period),SST_Z1_period(end)]),'YDir','reverse',...
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
imagesc(FGsst_Z1_Time,log2(FGsst_Z1_period),FGsst_Z1_power.^FGsst_Z1_puis);
%..........................................................................
plot(FGsst_Z1_Time,log2(FGsst_Z1_coi),'k')
%..........................................................................
contour(FGsst_Z1_Time,log2(FGsst_Z1_period),FGsst_Z1_pvp,...
    [FGsst_Z1_pvalue/FGsst_Z1_cor,FGsst_Z1_pvalue/FGsst_Z1_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
% xlabel('Time (years)')
xlim([FGchl_Z1_Time(1) FGchl_Z1_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',[]);
%..........................................................................
% ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(FGsst_Z1_period))):fix(log2(FGsst_Z1_period(end))));
set(gca,'YLim',log2([min(FGsst_Z1_period),FGsst_Z1_period(end)]),'YDir','reverse',...
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
imagesc(FPsst_Z1_Time,log2(FPsst_Z1_period),FPsst_Z1_power.^FPsst_Z1_puis);
%..........................................................................
plot(FPsst_Z1_Time,log2(FPsst_Z1_coi),'k')
%..........................................................................
contour(FPsst_Z1_Time,log2(FPsst_Z1_period),FPsst_Z1_pvp,...
    [FPsst_Z1_pvalue/FPsst_Z1_cor,FPsst_Z1_pvalue/FPsst_Z1_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
% xlabel('Time (years)')
xlim([FPchl_Z1_Time(1) FPchl_Z1_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',[]);
%..........................................................................
% ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(FPsst_Z1_period))):fix(log2(FPsst_Z1_period(end))));
set(gca,'YLim',log2([min(FPsst_Z1_period),FPsst_Z1_period(end)]),'YDir','reverse',...
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
imagesc(CHL_Z1_Time,log2(CHL_Z1_period),CHL_Z1_power.^CHL_Z1_puis);
%..........................................................................
plot(CHL_Z1_Time,log2(CHL_Z1_coi),'k')
%..........................................................................
contour(CHL_Z1_Time,log2(CHL_Z1_period),CHL_Z1_pvp,...
    [CHL_Z1_pvalue/CHL_Z1_cor,CHL_Z1_pvalue/CHL_Z1_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
xlabel('Time (years)')
xlim([CHL_Z1_Time(1) CHL_Z1_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',Tvec);
%..........................................................................
ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(CHL_Z1_period))):fix(log2(CHL_Z1_period(end))));
set(gca,'YLim',log2([min(CHL_Z1_period),CHL_Z1_period(end)]),'YDir','reverse',...
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
imagesc(FGchl_Z1_Time,log2(FGchl_Z1_period),FGchl_Z1_power.^FGchl_Z1_puis);
%..........................................................................
plot(FGchl_Z1_Time,log2(FGchl_Z1_coi),'k')
%..........................................................................
contour(FGchl_Z1_Time,log2(FGchl_Z1_period),FGchl_Z1_pvp,...
    [FGchl_Z1_pvalue/FGchl_Z1_cor,FGchl_Z1_pvalue/FGchl_Z1_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
xlabel('Time (years)')
xlim([FGchl_Z1_Time(1) FGchl_Z1_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',Tvec);
%..........................................................................
% ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(FGchl_Z1_period))):fix(log2(FGchl_Z1_period(end))));
set(gca,'YLim',log2([min(FGchl_Z1_period),FGchl_Z1_period(end)]),'YDir','reverse',...
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
imagesc(FPchl_Z1_Time,log2(FPchl_Z1_period),FPchl_Z1_power.^FPchl_Z1_puis);
%..........................................................................
plot(FPchl_Z1_Time,log2(FPchl_Z1_coi),'k')
%..........................................................................
contour(FPchl_Z1_Time,log2(FPchl_Z1_period),FPchl_Z1_pvp,...
    [FPchl_Z1_pvalue/FPchl_Z1_cor,FPchl_Z1_pvalue/FPchl_Z1_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
xlabel('Time (years)')
xlim([FPchl_Z1_Time(1) FPchl_Z1_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',Tvec);
%..........................................................................
% ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(FPchl_Z1_period))):fix(log2(FPchl_Z1_period(end))));
set(gca,'YLim',log2([min(FPchl_Z1_period),FPchl_Z1_period(end)]),'YDir','reverse',...
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
print(gcf, '-dpng', 'FIGURE_WPS_SSTvsCHL_Z1.png');
%==========================================================================
return

