close all
clear all
format long g
%==========================================================================

%==========================================================================
%% Script to plot bloom phenology using weekly mean daya:
%--------------------------------------------------------------------------
% Writen by Iria Sala
% Created on 24.07.2025
% Last updated on 24.07.2025 
%==========================================================================


%==========================================================================
% ---------------------------------- CHL ---------------------------------%
%==========================================================================
%% Load weekly data
%==========================================================================
% CHL
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\CHL_Vector_TimeSeries_07dMean.mat');
%--------------------------------------------------------------------------
% Time: Julian days
DOY = day(weeklyDates,'dayofyear');
%==========================================================================
%% Create a 2D matrix: years x months
%==========================================================================
% Extract year and week numbers
vecYear = year(weeklyDates);
vecWeek = week(weeklyDates, 'weekofyear');
%..........................................................................
% Define year range
uniqueYears = unique(vecYear);
nYear = length(uniqueYears);
maxWeeks = max(vecWeek);  % Typically 52 or 53
%..........................................................................
% Associate year labels
yearCHL = uniqueYears;
%..........................................................................
% Initialise output matrix
CHLZ0mat = NaN(nYear,maxWeeks);
CHLZ1mat = NaN(nYear,maxWeeks);
CHLZ2mat = NaN(nYear,maxWeeks);
%..........................................................................
% Fill the matrix
for i = 1:nYear
    
    yr = uniqueYears(i);
    idx = vecYear == yr;
    
    weeks = vecWeek(idx);
    valZ0 = CHLZ0m(idx);
    valZ1 = CHLZ1m(idx);
    valZ2 = CHLZ2m(idx);
    
    % Remove duplicates if any (e.g. same week appears twice due to edge cases)
    [uWeeks,ia] = unique(weeks, 'first');
    CHLZ0mat(i,uWeeks) = valZ0(ia);
    CHLZ1mat(i,uWeeks) = valZ1(ia);
    CHLZ2mat(i,uWeeks) = valZ2(ia);
    
end
%..........................................................................
% Time matrix, initialise DOY matrix
DOYCHLmat = NaN(nYear, maxWeeks);
%..........................................................................
for i = 1:nYear

    yr = uniqueYears(i);
    idx = vecYear == yr;
    
    weeks = vecWeek(idx);
    doy_vals = DOY(idx);
    
    % Remove duplicates if any
    [uWeeks, ia] = unique(weeks, 'first');
    DOYCHLmat(i,uWeeks) = doy_vals(ia);

end
%==========================================================================


%==========================================================================
% ---------------------------------- SST ---------------------------------%
%==========================================================================
%% Load weekly data
%==========================================================================
% SST
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\SST_Vector_TimeSeries_07dMean.mat');
%--------------------------------------------------------------------------
DOY = day(weeklyDates,'dayofyear');
%==========================================================================
%% Create a 2D matrix: years x months
%==========================================================================
% Extract year and week numbers
vecYearSST = year(weeklyDates);
vecWeekSST = week(weeklyDates, 'weekofyear');
%..........................................................................
% Define year range: expand SST years to match CHL range
fullYears = min(yearCHL):max(yearCHL);  % Match CHL span
nYear = length(fullYears);
maxWeeks = max(vecWeekSST);
uniqueYearsSST = unique(vecYearSST);
%..........................................................................
% Initialise output matrix
SSTZ0mat  = NaN(nYear, maxWeeks);
SSTZ1mat  = NaN(nYear, maxWeeks);
SSTZ2mat  = NaN(nYear, maxWeeks);
DOYSSTmat = NaN(nYear, maxWeeks);
%..........................................................................
% Fill the matrix
for i = 1:length(uniqueYearsSST)
    
    yr = uniqueYearsSST(i);
    rowIdx = find(fullYears == yr);  % Row index in padded matrix

    idx = vecYearSST == yr;
    weeks = vecWeekSST(idx);
    doy_vals = DOY(idx);

    valZ0 = SSTZ0m(idx);
    valZ1 = SSTZ1m(idx);
    valZ2 = SSTZ2m(idx);

    % Remove duplicates if any
    [uWeeks, ia] = unique(weeks, 'first');
    SSTZ0mat(rowIdx,uWeeks)  = valZ0(ia);
    SSTZ1mat(rowIdx,uWeeks)  = valZ1(ia);
    SSTZ2mat(rowIdx,uWeeks)  = valZ2(ia);
    DOYSSTmat(rowIdx,uWeeks) = doy_vals(ia);
    
end
%..........................................................................
yearSST = fullYears;
%==========================================================================


%==========================================================================
%% Interpolation of both data matrices year by year to regular DOY
%==========================================================================
nDOYS = 1:365;
nYear = length(yearSST);
%-------------------------------------------------------------------------- 
% Initialise output matrices
outSSTZ0 = NaN(nYear,length(nDOYS));
outSSTZ1 = NaN(nYear,length(nDOYS));
outSSTZ2 = NaN(nYear,length(nDOYS));
outCHLZ0 = NaN(nYear,length(nDOYS));
outCHLZ1 = NaN(nYear,length(nDOYS));
outCHLZ2 = NaN(nYear,length(nDOYS));
%--------------------------------------------------------------------------
% Interpolate year by year
for i = 1:nYear
    
    % SST Z0
    x = DOYSSTmat(i,:);
    y = SSTZ0mat(i,:);
    valid = ~isnan(x) & ~isnan(y);
    if nnz(valid) > 5
        outSSTZ0(i,:) = interp1(x(valid),y(valid),nDOYS,'linear',NaN);
    end

    % SST Z1
    y = SSTZ1mat(i,:);
    valid = ~isnan(x) & ~isnan(y);
    if nnz(valid) > 5
        outSSTZ1(i,:) = interp1(x(valid),y(valid),nDOYS,'linear',NaN);
    end

    % SST Z2
    y = SSTZ2mat(i,:);
    valid = ~isnan(x) & ~isnan(y);
    if nnz(valid) > 5
        outSSTZ2(i,:) = interp1(x(valid),y(valid),nDOYS,'linear',NaN);
    end

    % CHL Z0
    x = DOYCHLmat(i,:);
    y = CHLZ0mat(i,:);
    valid = ~isnan(x) & ~isnan(y);
    if nnz(valid) > 5
        outCHLZ0(i,:) = interp1(x(valid),y(valid),nDOYS,'linear',NaN);
    end

    % CHL Z1
    y = CHLZ1mat(i,:);
    valid = ~isnan(x) & ~isnan(y);
    if nnz(valid) > 5
        outCHLZ1(i,:) = interp1(x(valid),y(valid),nDOYS,'linear',NaN);
    end

    % CHL Z2
    y = CHLZ2mat(i,:);
    valid = ~isnan(x) & ~isnan(y);
    if nnz(valid) > 5
        outCHLZ2(i,:) = interp1(x(valid),y(valid),nDOYS,'linear',NaN);
    end
end
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
% m = distance between subplots
% n = distance to bottom and top
% p = distance to left and right
subplot = @(m,n,p) subtightplot (m,n,p,[0.02 0.02],[0.06 0.02],[0.10 0.02]);
if ~make_it_tight,  clear subplot;  end
%..........................................................................
Fig = figure;
set(gcf, 'Color','white');
set(Fig, 'Position',[860, 60,700,900]);
%==========================================================================
F01 = subplot(2,2,1);
hold on; grid on; box on;
%..........................................................................
im1 = imagesc(nDOYS,yearSST,outSSTZ1);
shading flat
%..........................................................................
% xlabel('Time (months)'); 
xlim([1 365]);
set(gca,'XTick',Tvec,'XTickLabel',[])
%..........................................................................
ylabel('Time (years)');
ylim([1997.3 2024.7]);
set(gca,'YTick',[1998:4:2024])
set(gca,'YDir','reverse'); 
%..........................................................................
caxis([14 26])
% h1 = colorbar;
% colormap(jet)
% set(h1,'Position',[.94 .07 .015 .24],'FontSize',11);
% set(h1,'YTick',14:2:26); % Set explicit ticks
%..........................................................................
title('(a) Zone 1 - SST (ºC)')
%..........................................................................
hold off
%--------------------------------------------------------------------------
set(im1,'AlphaData',~isnan(outSSTZ1));
set(gca,'FontSize',11,'FontName','Times');
%==========================================================================
F02 = subplot(2,2,2);
hold on; grid on; box on;
%..........................................................................
im2 = imagesc(nDOYS,yearSST,outSSTZ2);
shading flat
%..........................................................................
% xlabel('Time (months)'); 
xlim([1 365]);
set(gca,'XTick',Tvec,'XTickLabel',[])
%..........................................................................
% ylabel('Time (years)');
ylim([1997.3 2024.7]);
set(gca,'YTick',[1998:4:2024],'YTickLabel',[])
set(gca,'YDir','reverse'); 
%..........................................................................
caxis([14 26])
h2 = colorbar;
colormap(jet)
set(h2,'Position',[.90 .535 .025 .421],'FontSize',11);
set(h2,'YTick',14:2:26); % Set explicit ticks
%..........................................................................
title('(b) Zone 2 - SST (ºC)')
%..........................................................................
hold off
%--------------------------------------------------------------------------
set(im2,'AlphaData',~isnan(outSSTZ2));
set(gca,'FontSize',11,'FontName','Times');
%==========================================================================
F03 = subplot(2,2,3);
hold on; grid on; box on;
%..........................................................................
im3 = imagesc(nDOYS,yearCHL,log10(outCHLZ1));
shading flat
%..........................................................................
xlabel('Time (months)'); 
xlim([1 365]);
set(gca,'XTick',Tvec,'XTickLabel',Tout)
%..........................................................................
ylabel('Time (years)');
ylim([1997.3 2024.7]);
set(gca,'YTick',[1998:4:2024])
set(gca,'YDir','reverse'); 
%..........................................................................
caxis([log10(0.1) log10(1.7)])
% h3 = colorbar;
% colormap(jet)
% set(h3,'Position',[.94 .07 .015 .24],'FontSize',11);
% set(h3,'YTick',[log10(0.1) log10(0.3) log10(0.9) log10(1.7)],...
%        'YTickLabel',{'0.1', '0.3','0.9','1.6'});
%..........................................................................
title('(c) Zone 1 - Chl-a (mg m^{-3})')
%..........................................................................
hold off
%--------------------------------------------------------------------------
set(im3,'AlphaData',~isnan(outCHLZ1));
set(gca,'FontSize',11,'FontName','Times');
%==========================================================================
F04 = subplot(2,2,4);
hold on; grid on; box on;
%..........................................................................
im4 = imagesc(nDOYS,yearCHL,log10(outCHLZ2));
shading flat
%..........................................................................
xlabel('Time (months)'); 
xlim([1 365]);
set(gca,'XTick',Tvec,'XTickLabel',Tout)
%..........................................................................
% ylabel('Time (years)');
ylim([1997.3 2024.7]);
set(gca,'YTick',[1998:4:2024],'YTickLabel',[])
set(gca,'YDir','reverse'); 
%..........................................................................
caxis([log10(0.1) log10(1.7)])
h4 = colorbar;
colormap(jet)
set(h4,'Position',[.90 .065 .025 .421],'FontSize',11);
set(h4,'YTick',[log10(0.1) log10(0.3) log10(0.9) log10(1.7)],...
       'YTickLabel',{'0.1', '0.3','0.9','1.6'});
%..........................................................................
title('(d) Zone 2 - Chl-a (mg m^{-3})')
%..........................................................................
hold off
%--------------------------------------------------------------------------
set(im4,'AlphaData',~isnan(outCHLZ2));
set(gca,'FontSize',11,'FontName','Times');
%==========================================================================
% Subplots position
set(F01,'position',[0.10 0.53 0.38 0.43]);
set(F02,'position',[0.50 0.53 0.38 0.43]);
set(F03,'position',[0.10 0.06 0.38 0.43]);
set(F04,'position',[0.50 0.06 0.38 0.43]);
%==========================================================================
%% Save the figure:
%==========================================================================
set(gcf,'PaperPositionMode','auto');
print(gcf, '-dpng', 'FIGURE_BloomTiming_SSTvsCHL_Z1vsZ2.png');
%==========================================================================
return
