close all
clear all
%==========================================================================

%==========================================================================
%% Load data: SST
%==========================================================================
load WPS_SST_ZONE0_07d.mat
%..........................................................................
SST_Z0_SSTm      = DATAint;
SST_Z0_mSST      = DATAave;
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

%==========================================================================
%% Load data: FGsst
%==========================================================================
load WPS_FGsst_ZONE0_07d.mat
%..........................................................................
FGsst_Z0_SSTm      = DATAint;
FGsst_Z0_mSST      = DATAave;
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

%==========================================================================
%% Load data: FPsst
%==========================================================================
load WPS_FPsst_ZONE0_07d.mat
%..........................................................................
FPsst_Z0_SSTm      = DATAint;
FPsst_Z0_mSST      = DATAave;
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
subplot = @(m,n,p) subtightplot (m, n, p, [0.03 0.02], [0.19 0.03], [0.07 0.02]);
if ~make_it_tight,  clear subplot;  end
%..........................................................................
Fig = figure;
set(gcf, 'Color','white');
set(Fig, 'Position',[860, 60,1000,250]);
%==========================================================================
subplot(1,3,1);
hold on
box on
%..........................................................................
imagesc(SST_Z0_Time,log2(SST_Z0_period),SST_Z0_power.^SST_Z0_puis);
%..........................................................................
plot(SST_Z0_Time,log2(SST_Z0_coi),'k')
%..........................................................................
contour(SST_Z0_Time,log2(SST_Z0_period),SST_Z0_pvp,...
    [SST_Z0_pvalue/SST_Z0_cor,SST_Z0_pvalue/SST_Z0_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
xlabel('Time (years)')
xlim([SST_Z0_Time(1) SST_Z0_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',Tvec);
%..........................................................................
ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(SST_Z0_period))):fix(log2(SST_Z0_period(end))));
set(gca,'YLim',log2([min(SST_Z0_period),SST_Z0_period(end)]),'YDir','reverse',...
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
subplot(1,3,2);
hold on
box on
%..........................................................................
imagesc(FGsst_Z0_Time,log2(FGsst_Z0_period),FGsst_Z0_power.^FGsst_Z0_puis);
%..........................................................................
plot(FGsst_Z0_Time,log2(FGsst_Z0_coi),'k')
%..........................................................................
contour(FGsst_Z0_Time,log2(FGsst_Z0_period),FGsst_Z0_pvp,...
    [FGsst_Z0_pvalue/FGsst_Z0_cor,FGsst_Z0_pvalue/FGsst_Z0_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
xlabel('Time (years)')
xlim([FGsst_Z0_Time(1) FGsst_Z0_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',Tvec);
%..........................................................................
% ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(FGsst_Z0_period))):fix(log2(FGsst_Z0_period(end))));
set(gca,'YLim',log2([min(FGsst_Z0_period),FGsst_Z0_period(end)]),'YDir','reverse',...
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
subplot(1,3,3);
hold on
box on
%..........................................................................
imagesc(FPsst_Z0_Time,log2(FPsst_Z0_period),FPsst_Z0_power.^FPsst_Z0_puis);
%..........................................................................
plot(FPsst_Z0_Time,log2(FPsst_Z0_coi),'k')
%..........................................................................
contour(FPsst_Z0_Time,log2(FPsst_Z0_period),FPsst_Z0_pvp,...
    [FPsst_Z0_pvalue/FPsst_Z0_cor,FPsst_Z0_pvalue/FPsst_Z0_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
xlabel('Time (years)')
xlim([FPsst_Z0_Time(1) FPsst_Z0_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',Tvec);
%..........................................................................
% ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(FPsst_Z0_period))):fix(log2(FPsst_Z0_period(end))));
set(gca,'YLim',log2([min(FPsst_Z0_period),FPsst_Z0_period(end)]),'YDir','reverse',...
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
%% Save the figure:
%==========================================================================
set(gcf,'PaperPositionMode','auto');
print(gcf, '-dpng', 'FIGURE_WPS_SST_Z0.png');
%==========================================================================
return

