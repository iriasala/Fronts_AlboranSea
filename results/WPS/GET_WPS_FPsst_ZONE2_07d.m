close all
clear all
%==========================================================================

%==========================================================================
%% Script to compute the WPS:
%--------------------------------------------------------------------------
% Writen by Iria Sala
% Created on 14.12.2020
% Last updated on 18.06.2025 
%--------------------------------------------------------------------------
% Computes the Wavelet Power Spectrum of a 7d time series.
% Based on Cazelles et al. (2008)
%==========================================================================

%==========================================================================
%% Load data:
%==========================================================================
path = 'G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\';
file = 'FPsst_Vector_TimeSeries_07dMean.mat';
%..........................................................................
load(fullfile(path,file));
%==========================================================================

%==========================================================================
%% Data vectors:
%==========================================================================
DATA = CFPZ2v;
TIME = datenum(weeklyDates);
%..........................................................................
% Interpolate missing values
DATAint = fillmissing(DATA,'linear');
%..........................................................................
% Mean value of the whole period
DATAave = nanmean(DATAint);
%..........................................................................
% SD value of the whole period
DATAstd = nanstd(DATAint);
%..........................................................................
% Normalize by square root
DATAsqr = sqrt(DATAint);
%..........................................................................
% Standarize to mean zero
DATAsta = DATAsqr - mean(DATAsqr(:));
VECTOR  = DATAsqr ./ std(DATAsqr(:));
%==========================================================================

%==========================================================================
%% ------------ Morlet Wavelet transformation of signal Y -------------- %%
%==========================================================================
% Decomposition between two periods (lowerPeriod,upperPeriod)
%------------ INPUTS
% ys          : input signal (Temporal Serie)
% dt          : sampling rate
% dj          : frequency resolution (i.e. number of sub-octaves)
%             : (spacing between discrete scales)
% lowerPeriod : lower period of the decomposition
% upperPeriod : upper period of the decomposition
% pad         : in case of zero padding (it must be a power of two)
%==========================================================================
ys = VECTOR;
%..........................................................................
dt = 1 / (52.15); % Weekly data
dj = 1/6; 
%..........................................................................
lowerPeriod = 4 * dt;            % 1 month
upperPeriod = (4 * dt) * 12 * 9; % 9 years
%..........................................................................
pad = 128;
%--------------------------------------------------------------------------
[wave,power,period,scale,coi] = WaveletTransform(ys,dt,dj,lowerPeriod,upperPeriod,pad);
%--------------------------------------------------------------------------
%------------- OUTPUT
%   wave      : wavelet Transform-matrix
%   power     : power wavelet spectrum
%   period    : the vector of "Fourier" periods (in time units)
%             : that corresponds to the scale.s
%   scale     : the vector of scale indices, given by so*2.^((0:j1)*dj), j=0...J1
%               where J1 is the total number of scales.
%   coi       : the "cone-of-influence", which is a vector of n_y points
%               that contains the limit of the region where the wavelet transform
%               is influenced by edge effects.
%==========================================================================

%==========================================================================
%%  Computation of different "outputs" based on the Wavelet transform of 
% the signal y.
%==========================================================================
% function [realwav,imagwav,global_ws,filtr_ts,filtr_var,phase_ts] = ...
%     WaveletOutput(wave,power,period,scale,y,variance,dt,lowPF,upPF)
%----------- INPUTS
% wave       : wavelet transform computed by 'WaveletTransform'
% power      : power wavelet spectrum
% period     : vector of period obtained based on the vector scale
% scale      : vector of the wavelet scale employed during the computation 
% ys         : THE TIME SERIES
% variance   : variance of y
% dt         : observation time step
% dj         : frequency resolution (ie number of sub-octaves)
% lowerPF    : lower value of the period used for filtering some of the output 
%              (filtr_ts, filtr_var, phase_ts)
% upperPF    : upper value of the period used for filtering some of the output
%              (filtr_ts, filtr_var, phase_ts)
%==========================================================================
lowerPF = lowerPeriod;
upperPF = 15;
var = std(ys)^2;
%--------------------------------------------------------------------------
[realwav,imagwav,global_ws,filtr_ts,filtr_var,phase_ts] = WaveletOutput(wave,power,period,scale,ys,var,dt,dj,lowerPF,upperPF);
%--------------------------------------------------------------------------
%----------- OUTPUT
% realwav    : real part of the wavelet transform (ie the modulus)
% imagwav    : imaginary part of the wavelet transform
% global_ws  : average power wavelet spectrum
% filtr_ts   : filtered time series (the reconstructed serie) based on the components 
%              which are between lowerPF and upperPF periods
% filtr_var  : average variance of the components between lowerPF and upperPF periods
% phase_ts   : filtered phase series between lowerPF and upperPF periods
%==========================================================================

%==========================================================================
%% Calculation of the maxima of the matrice m, these maxima are named RIDGE
% in the context of Wavelet Analysis a test has been introduce to plot just
% the value > amp*max
%==========================================================================
% function  rg = WaveletRidge(m,nb,amp);
%----------- INPUTS
% m    : the matrice for which one has to compute the ridges
% nb   : number of point used to compute a maximum, in fact 2*nb+1 points are used
% amp  : proportion of maximum value than one needs for plotting
%--------------------------------------------------------------------------
modul = abs(realwav);
rid   = WaveletRidge(power,3,.05);
%--------------------------------------------------------------------------
%----------- OUTPUT
% rg   : ridge values approximated by the maximum of the matrice m
%==========================================================================

%==========================================================================
%%  Statistical tests for same "outputs" of the wavelet transform of the series y
%==========================================================================
% by different boostrapping approaches (test = 1,2,3,4,5,6,7,8)
% or by comparison with white or red noise with AR (test = 10,11)
% or by comparison with white or red noise (test = 12,13)
%..........................................................................
% [pv5,pv1,gm5_ws,gm1_ws,fm5_var,fm1_var] = ...
%   WaveletTest(y,var_y,power,dt,dj,scale,lowP,upP,lowPF,upPF,pad,test,ns,ps,nbin,amp)
%..........................................................................
%--------- INPUTS
% y        : input time series
% var_y    : variance of y
% power    : power wavelet spectrum
% dt       : observation time step
% dj       : frequency resolution (ie number of sub-octaves)
% scale    : vector of the wavelet scale employed during the computation 
% lowP     : lower period of the decomposition
% upP      : upper period of the decomposition
% lowPF    : lower value of the period used for filtering some of the output 
%            (filtr_ts, filtr_var, phase_ts)
% upPF     : upper value of the period used for filtering some of the output
%            (filtr_ts, filtr_var, phase_ts)
% pad      : in case of zero padding (it must be a power of two)
% test     : test options: 
%            .  1 simple bootstrap
%            .  2 bootstrap by block after block randomization
%            .  3 bootstrap by block and random start
%            .  4 bootstrap by block with random block with a mean length 
%            .  5 surrogate with Hidden Markow Model
%            .  6 surrogate with simple shuffling
%            .  7 surrogate with Fourier randomization
%            .  8 surrogate with Fourier gaussian amplitude-adjusted
%            .  9 surrogate with identical slope of the spectrum (beta) and gaussian amplitude-adjusted
%            . 10 comparison with white noise, 11 with red noise (AR(0) ou AR(1))
%            . 12 comparison with white noise, 13 with red noise (ANALYTIC COMPUTATION)
% ns       : number of surrogate or boostrapped series
% ps       : length of block or probability of changing block for the boostrap functions
%            or parameter of the gaussian amplitude-adjusted surrogates (ps = 1 or 2 or 3)
% nbin     : number of bin used for the distribution of the raw series in test=5
% amp      : power of de 10 for the minima and maxima computations (example amp=10)
%==========================================================================
test   = 5; % 5 surrogate with Hidden Markow Model
ns     = 1000;
pvalue = 5;
cor    = 75;
ps     = 0.12;
nbin   = 20;
amp    = 10;
%--------------------------------------------------------------------------
[pvp,pvp1,gm5_ws,gm1_ws,fm5_var,fm1_var] = WaveletTest(ys,var,power,dt,dj,scale,lowerPeriod,upperPeriod,lowerPF,upperPF,pad,test,ns,ps,nbin,amp);
%--------------------------------------------------------------------------
%--------- OUTPUT
% pv5      : matrice of the Pvalue of the power wavelet, for test = 12,13 it's just the 5% level
% pv1      : matrice of the Pvalue of the power wavelet, for test = 12,13 it's just the 1% level
% gm5_ws   : 5% significance level for the average wavelet spectrum of y
% gm1_ws   : 1% significance level for the average wavelet spectrum of y
% fm5_var  : 5% significance level for the average variance of the series
% fm1_var  : 1% significance level for the average variance of the series
%==========================================================================
if pvalue == 5
   gm_ws  = gm5_ws;
   fm_var = fm5_var;
elseif pvalue == 1
   gm_ws  = gm1_ws;
   fm_var  = fm1_var;
%    if test >= 12
%       pvp5 = pvp;
%       pvp = pvp1;
%    end;
end
%==========================================================================
time = 1:469;
puis = 0.25;
cor  = 100;
fac  = 1.6;
%==========================================================================

%==========================================================================
%% Save data
%==========================================================================
save('WPS_FPsst_ZONE2_07d.mat','TIME','CFPZ1v','DATAint','DATAave','DATAstd',...
     'VECTOR','period','power','puis','coi','pvp','pvalue','cor','global_ws','gm_ws')
%==========================================================================

%==========================================================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIGURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
make_it_tight = true;
% m = distancia entre subplots
% n = distancia a los bordes inferior y superior
% p = distancia a los bordes derecho e izqierdo
subplot = @(m,n,p) subtightplot (m, n, p, [0.05 0.01], [0.05 0.05], [0.07 0.07]);
if ~make_it_tight,  clear subplot;  end
%..........................................................................
Fig = figure;
set(gcf, 'Color','white');
set(Fig, 'Position',[860, 60, 700, 500]);
%==========================================================================
S1 = subplot(2,2,1);
hold on
box on
%..........................................................................
plot(TIME,DATAint,'Color','k','LineWidth',1);
%..........................................................................
xlim([TIME(1) TIME(end)]);
set(gca,'XTick',[729756 730486 731217 731947 732678 733408 734139 734869 ...
                 735600 736330 737061 737791 738522 739252],...
        'XTickLabel',[1998 2000 2002 2004 2006 2008 2010 2012 2014 2016 ...
                      2018 2020 2022 2024],...
        'FontSize', 8)
xlabel('Time','FontName','times','FontSize',10)
%..........................................................................
% ylim([0 1.5])
% set(gca,'YTick',0:0.25:1.5,'YTickLabel',0:0.25:1.5,'FontSize', 8)
ylabel(gca,'FPsst (%)', 'fontsize', 10);
% ylabh = get(gca,'YLabel');
% set(ylabh,'Position',[731085 1.0 1.00010919874411])
%..........................................................................
line([TIME(1) TIME(end)],[DATAave DATAave],'Color','k', 'LineWidth', 1,'LineStyle',':')
%..........................................................................
% str = {'a'};
% text(730152.71,1.4,str,'LineStyle','none', 'fontsize', 12,'HorizontalAlignment','center','FontWeight','bold');
%..........................................................................
hold off
%==========================================================================
S2 = subplot(2,2,2);
hold on
box on
%..........................................................................
hist(DATAint,12);
%..........................................................................
set(get(gca,'child'),'FaceColor','k','EdgeColor','w');
%..........................................................................
% set(gca,'XLim',[0,1.5], 'FontSize', 8)
xlabel(gca,'FPsst (%)', 'fontsize', 10);  %# Add a label to the left y axis
%..........................................................................
% ylim([0 110]);
ylabel(gca,'Frequency', 'fontsize', 10);  %# Add a label to the left y axis
%..........................................................................
line([DATAave DATAave],[0 100],'Color','k', 'LineWidth', 1,'LineStyle',':')
%..........................................................................
% str = {'b'};
% text(0.12,100,str,'LineStyle','none', 'fontsize', 12,'HorizontalAlignment','center','FontWeight','bold');
%..........................................................................
hold off
%==========================================================================
S3 = subplot(2,2,3);
hold on
box on
%..........................................................................
imagesc(TIME,log2(period),power.^puis);
% caxis([0 2.2]);
%..........................................................................
xlim([TIME(1) TIME(end)]);
set(gca,'XTick',[729756 730486 731217 731947 732678 733408 734139 734869 ...
                 735600 736330 737061 737791 738522 739252],...
        'XTickLabel',[1998 2000 2002 2004 2006 2008 2010 2012 2014 2016 ...
                      2018 2020 2022 2024],...
        'FontSize', 8)
xlabel('Time','FontName','times','FontSize',10)
%..........................................................................
Yticks = 2.^(fix(log2(min(period))):fix(log2(max(period))));
set(gca,'YLim',log2([min(period),max(period)]),'YDir','reverse',...
	    'YTick',log2(Yticks(:)), 'YTickLabel',Yticks(:))
ylabel('Period (years)','FontName','times','FontSize',10)
%..........................................................................
plot(TIME,log2(coi),'k')
%..........................................................................
contour(TIME,log2(period),pvp,[pvalue/cor,pvalue/cor],'Color','k', 'LineStyle','--');
%..........................................................................
% str = {'c'};
% text(730171.16,-3.31,str,'LineStyle','none','fontsize',12,...
%     'HorizontalAlignment','center','FontWeight','bold','Color','w');
%..........................................................................
hold off
%==========================================================================
S4 = subplot(2,2,4);
hold on
box on
%..........................................................................
plot(global_ws,log2(period),'Color','k')
plot(gm_ws*1.6,log2(period*1.6),'k--')
%..........................................................................
% xlim([0 35]);
xlabel('Power','FontName','times','FontSize',10)
%..........................................................................
set(gca,'YLim',log2([min(period),max(period)]),'YDir','reverse',...
	'YTick',log2(Yticks(:)),'YTickLabel',Yticks(:),'FontSize',8)
% set(gca,'XLim',[0,1.1*max(global_ws_oo)])
%..........................................................................
% str = {'d'};
% text(3.00,-3.31,str,'LineStyle','none', 'fontsize', 12,'HorizontalAlignment','center','FontWeight','bold');
%..........................................................................
hold off
%==========================================================================
set(S1,'position',[0.11 0.60 0.59 0.37])
% distancia al borde izquierdo
% distancia al borde inferior
% distancia al borde derecho
% alto de la gráfica
set(S2,'position',[0.78 0.60 0.20 0.37])
set(S3,'position',[0.11 0.10 0.59 0.37])
set(S4,'position',[0.78 0.10 0.20 0.37])
%==========================================================================
%% Save the figure:
%==========================================================================
set(gcf,'PaperPositionMode','auto');
print(gcf, '-dpng', 'WPS_FPsst_ZONE2_07d.png');
%==========================================================================
return