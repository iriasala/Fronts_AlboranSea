close all
clear all
%==========================================================================

%==========================================================================
%% Load data: SST
%==========================================================================
load WPS_SST_ZONE0_07d.mat
%..........................................................................
SST_Z0_CHLm      = DATAint;
SST_Z0_mCHL      = DATAave;
SST_Z0_Time      = TIME;
SST_Z0_coi       = coi;
SST_Z0_cor       = cor;
SST_Z0_global_ws = global_ws;
SST_Z0_gm_ws     = gm_ws;
SST_Z0_period    = period;
SST_Z0_power     = power;
SST_Z0_puis      = puis;
SST_Z0_pvalue    = pvalue;
SST_Z0_pvp       = pvp;
%..........................................................................
clear DATAint DATAave TIME coi cor global_ws gm_ws period power puis pvalue pvp
%==========================================================================
load WPS_SST_ZONE1_07d.mat
%..........................................................................
SST_Z1_CHLm      = DATAint;
SST_Z1_mCHL      = DATAave;
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
load WPS_SST_ZONE2_07d.mat
%..........................................................................
SST_Z2_CHLm      = DATAint;
SST_Z2_mCHL      = DATAave;
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


%==========================================================================
%% Load data: FGsst
%==========================================================================
load WPS_FGsst_ZONE0_07d.mat
%..........................................................................
FGsst_Z0_CHLm      = DATAint;
FGsst_Z0_mCHL      = DATAave;
FGsst_Z0_Time      = TIME;
FGsst_Z0_coi       = coi;
FGsst_Z0_cor       = cor;
FGsst_Z0_global_ws = global_ws;
FGsst_Z0_gm_ws     = gm_ws;
FGsst_Z0_period    = period;
FGsst_Z0_power     = power;
FGsst_Z0_puis      = puis;
FGsst_Z0_pvalue    = pvalue;
FGsst_Z0_pvp       = pvp;
%..........................................................................
clear DATAint DATAave TIME coi cor global_ws gm_ws period power puis pvalue pvp
%==========================================================================
load WPS_FGsst_ZONE1_07d.mat
%..........................................................................
FGsst_Z1_CHLm      = DATAint;
FGsst_Z1_mCHL      = DATAave;
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
load WPS_FGsst_ZONE2_07d.mat
%..........................................................................
FGsst_Z2_CHLm      = DATAint;
FGsst_Z2_mCHL      = DATAave;
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


%==========================================================================
%% Load data: FPsst
%==========================================================================
load WPS_FPsst_ZONE0_07d.mat
%..........................................................................
FPsst_Z0_CHLm      = DATAint;
FPsst_Z0_mCHL      = DATAave;
FPsst_Z0_Time      = TIME;
FPsst_Z0_coi       = coi;
FPsst_Z0_cor       = cor;
FPsst_Z0_global_ws = global_ws;
FPsst_Z0_gm_ws     = gm_ws;
FPsst_Z0_period    = period;
FPsst_Z0_power     = power;
FPsst_Z0_puis      = puis;
FPsst_Z0_pvalue    = pvalue;
FPsst_Z0_pvp       = pvp;
%..........................................................................
clear DATAint DATAave TIME coi cor global_ws gm_ws period power puis pvalue pvp
%==========================================================================
load WPS_FPsst_ZONE1_07d.mat
%..........................................................................
FPsst_Z1_CHLm      = DATAint;
FPsst_Z1_mCHL      = DATAave;
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
load WPS_FPsst_ZONE2_07d.mat
%..........................................................................
FPsst_Z2_CHLm      = DATAint;
FPsst_Z2_mCHL      = DATAave;
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
%% Time vector:
%==========================================================================
Tall = datenum(1998:2024,1,1);
Tval = Tall(1:2:end);
Tvec = 1998:2:2024;
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
xlim([SST_Z1_Time(1) SST_Z1_Time(end)]);
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
xlim([FGsst_Z1_Time(1) FGsst_Z1_Time(end)]);
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
xlim([FPsst_Z1_Time(1) FPsst_Z1_Time(end)]);
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
imagesc(SST_Z2_Time,log2(SST_Z2_period),SST_Z2_power.^SST_Z2_puis);
%..........................................................................
plot(SST_Z2_Time,log2(SST_Z2_coi),'k')
%..........................................................................
contour(SST_Z2_Time,log2(SST_Z2_period),SST_Z2_pvp,...
    [SST_Z2_pvalue/SST_Z2_cor,SST_Z2_pvalue/SST_Z2_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
xlabel('Time (years)')
xlim([SST_Z2_Time(1) SST_Z2_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',Tvec);
%..........................................................................
ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(SST_Z2_period))):fix(log2(SST_Z2_period(end))));
set(gca,'YLim',log2([min(SST_Z2_period),SST_Z2_period(end)]),'YDir','reverse',...
	    'YTick',log2(Yticks(:)), 'YTickLabel',Yticks(:))
%..........................................................................
caxis([0 3]);
colormap("jet")
%..........................................................................
str = {'d'};
text(733801,-3.30,str,'LineStyle','none','HorizontalAlignment','center',...
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
imagesc(FGsst_Z2_Time,log2(FGsst_Z2_period),FGsst_Z2_power.^FGsst_Z2_puis);
%..........................................................................
plot(FGsst_Z2_Time,log2(FGsst_Z2_coi),'k')
%..........................................................................
contour(FGsst_Z2_Time,log2(FGsst_Z2_period),FGsst_Z2_pvp,...
    [FGsst_Z2_pvalue/FGsst_Z2_cor,FGsst_Z2_pvalue/FGsst_Z2_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
xlabel('Time (years)')
xlim([FGsst_Z2_Time(1) FGsst_Z2_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',Tvec);
%..........................................................................
% ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(FGsst_Z2_period))):fix(log2(FGsst_Z2_period(end))));
set(gca,'YLim',log2([min(FGsst_Z2_period),FGsst_Z2_period(end)]),'YDir','reverse',...
	    'YTick',log2(Yticks(:)),'YTickLabel',[])
%..........................................................................
caxis([0 3]);
colormap("jet")
%..........................................................................
str = {'e'};
text(733801,-3.30,str,'LineStyle','none','HorizontalAlignment','center',...
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
imagesc(FPsst_Z2_Time,log2(FPsst_Z2_period),FPsst_Z2_power.^FPsst_Z2_puis);
%..........................................................................
plot(FPsst_Z2_Time,log2(FPsst_Z2_coi),'k')
%..........................................................................
contour(FPsst_Z2_Time,log2(FPsst_Z2_period),FPsst_Z2_pvp,...
    [FPsst_Z2_pvalue/FPsst_Z2_cor,FPsst_Z2_pvalue/FPsst_Z2_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
xlabel('Time (years)')
xlim([FPsst_Z2_Time(1) FPsst_Z2_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',Tvec);
%..........................................................................
% ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(FPsst_Z2_period))):fix(log2(FPsst_Z2_period(end))));
set(gca,'YLim',log2([min(FPsst_Z2_period),FPsst_Z2_period(end)]),'YDir','reverse',...
	    'YTick',log2(Yticks(:)),'YTickLabel',[])
%..........................................................................
caxis([0 3]);
colormap("jet")
%..........................................................................
str = {'f'};
text(733801,-3.30,str,'LineStyle','none','HorizontalAlignment','center',...
                      'FontWeight','bold','Color','w','FontSize',12);
%..........................................................................
hold off
%--------------------------------------------------------------------------
set(gca,'FontSize',11,'FontName','Times');
%==========================================================================
%% Save the figure:
%==========================================================================
set(gcf,'PaperPositionMode','auto');
print(gcf, '-dpng', 'FIGURE_WPS_SST_Z1vsZ2.png');
%==========================================================================
return

