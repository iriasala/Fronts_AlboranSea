close all
clear all
%==========================================================================

%==========================================================================
%% Load data: CHL
%==========================================================================
load WPS_CHL_ZONE0_07d.mat
%..........................................................................
CHL_Z0_CHLm      = DATAint;
CHL_Z0_mCHL      = DATAave;
CHL_Z0_Time      = TIME;
CHL_Z0_coi       = coi;
CHL_Z0_cor       = cor;
CHL_Z0_global_ws = global_ws;
CHL_Z0_gm_ws     = gm_ws;
CHL_Z0_period    = period;
CHL_Z0_power     = power;
CHL_Z0_puis      = puis;
CHL_Z0_pvalue    = pvalue;
CHL_Z0_pvp       = pvp;
%..........................................................................
clear DATAint DATAave TIME coi cor global_ws gm_ws period power puis pvalue pvp
%==========================================================================

%==========================================================================
%% Load data: FGchl
%==========================================================================
load WPS_FGchl_ZONE0_07d.mat
%..........................................................................
FGchl_Z0_CHLm      = DATAint;
FGchl_Z0_mCHL      = DATAave;
FGchl_Z0_Time      = TIME;
FGchl_Z0_coi       = coi;
FGchl_Z0_cor       = cor;
FGchl_Z0_global_ws = global_ws;
FGchl_Z0_gm_ws     = gm_ws;
FGchl_Z0_period    = period;
FGchl_Z0_power     = power;
FGchl_Z0_puis      = puis;
FGchl_Z0_pvalue    = pvalue;
FGchl_Z0_pvp       = pvp;
%..........................................................................
clear DATAint DATAave TIME coi cor global_ws gm_ws period power puis pvalue pvp
%==========================================================================

%==========================================================================
%% Load data: FPchl
%==========================================================================
load WPS_FPchl_ZONE0_07d.mat
%..........................................................................
FPchl_Z0_CHLm      = DATAint;
FPchl_Z0_mCHL      = DATAave;
FPchl_Z0_Time      = TIME;
FPchl_Z0_coi       = coi;
FPchl_Z0_cor       = cor;
FPchl_Z0_global_ws = global_ws;
FPchl_Z0_gm_ws     = gm_ws;
FPchl_Z0_period    = period;
FPchl_Z0_power     = power;
FPchl_Z0_puis      = puis;
FPchl_Z0_pvalue    = pvalue;
FPchl_Z0_pvp       = pvp;
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
imagesc(CHL_Z0_Time,log2(CHL_Z0_period),CHL_Z0_power.^CHL_Z0_puis);
%..........................................................................
plot(CHL_Z0_Time,log2(CHL_Z0_coi),'k')
%..........................................................................
contour(CHL_Z0_Time,log2(CHL_Z0_period),CHL_Z0_pvp,...
    [CHL_Z0_pvalue/CHL_Z0_cor,CHL_Z0_pvalue/CHL_Z0_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
xlabel('Time (years)')
xlim([CHL_Z0_Time(1) CHL_Z0_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',Tvec);
%..........................................................................
ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(CHL_Z0_period))):fix(log2(CHL_Z0_period(end))));
set(gca,'YLim',log2([min(CHL_Z0_period),CHL_Z0_period(end)]),'YDir','reverse',...
	    'YTick',log2(Yticks(:)),'YTickLabel',Yticks(:))
%..........................................................................
caxis([0 3]);
colormap("jet")
%..........................................................................
str = {'a'};
text(730221,-3.30,str,'LineStyle','none','HorizontalAlignment','center',...
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
imagesc(FGchl_Z0_Time,log2(FGchl_Z0_period),FGchl_Z0_power.^FGchl_Z0_puis);
%..........................................................................
plot(FGchl_Z0_Time,log2(FGchl_Z0_coi),'k')
%..........................................................................
contour(FGchl_Z0_Time,log2(FGchl_Z0_period),FGchl_Z0_pvp,...
    [FGchl_Z0_pvalue/FGchl_Z0_cor,FGchl_Z0_pvalue/FGchl_Z0_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
xlabel('Time (years)')
xlim([FGchl_Z0_Time(1) FGchl_Z0_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',Tvec);
%..........................................................................
% ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(FGchl_Z0_period))):fix(log2(FGchl_Z0_period(end))));
set(gca,'YLim',log2([min(FGchl_Z0_period),FGchl_Z0_period(end)]),'YDir','reverse',...
	    'YTick',log2(Yticks(:)),'YTickLabel',[])
%..........................................................................
caxis([0 3]);
colormap("jet")
%..........................................................................
str = {'b'};
text(730221,-3.30,str,'LineStyle','none','HorizontalAlignment','center',...
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
imagesc(FPchl_Z0_Time,log2(FPchl_Z0_period),FPchl_Z0_power.^FPchl_Z0_puis);
%..........................................................................
plot(FPchl_Z0_Time,log2(FPchl_Z0_coi),'k')
%..........................................................................
contour(FPchl_Z0_Time,log2(FPchl_Z0_period),FPchl_Z0_pvp,...
    [FPchl_Z0_pvalue/FPchl_Z0_cor,FPchl_Z0_pvalue/FPchl_Z0_cor],...
    'Color','k', 'LineStyle','--');
%..........................................................................
xlabel('Time (years)')
xlim([FPchl_Z0_Time(1) FPchl_Z0_Time(end)]);
set(gca,'XTick',Tval,'XTickLabel',Tvec);
%..........................................................................
% ylabel('Period (years)')
Yticks = 2.^(fix(log2(min(FPchl_Z0_period))):fix(log2(FPchl_Z0_period(end))));
set(gca,'YLim',log2([min(FPchl_Z0_period),FPchl_Z0_period(end)]),'YDir','reverse',...
	    'YTick',log2(Yticks(:)),'YTickLabel',[])
%..........................................................................
caxis([0 3]);
colormap("jet")
%..........................................................................
str = {'c'};
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
print(gcf, '-dpng', 'FIGURE_WPS_CHL_Z0.png');
%==========================================================================
return

