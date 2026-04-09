close all
clear
format long g
%--------------------------------------------------------------------------
addpath('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\CoastLine')
%==========================================================================


%==========================================================================
%% Load CHL data
%==========================================================================
load('G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\CHL_WholeDomain_TimeSeries_07d.mat');
%==========================================================================

%==========================================================================
%% Compute yearly climatology
%==========================================================================
ROI = nanmean(compositeMaps,3);
%..........................................................................
LON = [-6.0 -1.0];
LAT = [34.9 37.8];
%==========================================================================

%==========================================================================
%% Classify pixels by chl concentration:
%==========================================================================
% Oligotrophic waters: Chl-a < 0.5 mg m-3
% Mesotrophic waters: 0.5 mg/m³ ≤ Chl-a < 1.0 mg m-3
% Eutrophic waters: Chl-a ≥ 1.0 mg m-3
%==========================================================================
% Initialize the output map
waterType = NaN(size(ROI));  % Same size as ROI, filled with zeros
%..........................................................................
% Classify pixels based on chl-a concentration
waterType(ROI < 0.5) = 1;
waterType(ROI >= 0.5 & ROI < 1.0) = 2;
waterType(ROI >= 1.0) = 3;
%==========================================================================

%==========================================================================
%% Smooth the selected region:
%==========================================================================
% Step 1: Create binary mask for productive waters (mesotrophic + eutrophic)
prod_mask = (ROI >= 0.5);  % Mesotrophic + Eutrophic regions
%..........................................................................
% Step 2: Label connected components (regions of contiguous pixels)
labeled_regions = bwlabel(prod_mask);
%..........................................................................
% Step 3: Remove small regions (e.g., regions with less than a certain number of pixels)
min_region_size = 400;  % Example threshold for minimum region size in pixels
region_sizes = regionprops(labeled_regions, 'Area');
regions_to_keep = find([region_sizes.Area] >= min_region_size);
%..........................................................................
% Step 4: Create a new mask with only the large regions
smoothed_mask = ismember(labeled_regions, regions_to_keep);
%..........................................................................
% Step 5: Apply morphological smoothing (optional, to smooth boundaries)
smoothed_mask = imdilate(smoothed_mask,strel('disk',1));
smoothed_mask = double(smoothed_mask);
smoothed_mask(smoothed_mask == 1) = 2;
smoothed_mask(smoothed_mask <  1) = NaN;
%==========================================================================

%==========================================================================
%% Identify the boundary line
%==========================================================================
% Step 1: Extract the boundary of the smoothed mask, ignoring NaN values
Z = smoothed_mask;  % The smoothed mask containing the regions
%..........................................................................
% Reshape meshgrid to N X 1 array
[nRow, nCol] = size(X);
xList = reshape(X, [nRow*nCol, 1]);
yList = reshape(Y, [nRow*nCol, 1]);
zList = reshape(Z, [nRow*nCol, 1]);
%..........................................................................
% Step 2: Remove NaN values
validIndices = ~isnan(zList);  % Find valid (non-NaN) values
xList = xList(validIndices);  % Remove NaN x coordinates
yList = yList(validIndices);  % Remove NaN y coordinates
zList = zList(validIndices);  % Remove NaN mask values
%..........................................................................
% Step 3: Extract boundary using the valid points
k = boundary(xList, yList, 1);  % Get boundary indices
%==========================================================================

%==========================================================================
%% Create masks
%==========================================================================
ZONE1 = smoothed_mask;  % Already cleaned and set to 2, others as NaN
ZONE1(ZONE1 >= 0) = 1;
%..........................................................................
ZONE2 = ROI;
ZONE2(ZONE2 >= 0) = 1;
ZONE2(~isnan(ZONE1)) = NaN;       % Exclude anything inside ZONE2
%--------------------------------------------------------------------------
save('CHL_MaskZones.mat','ZONE1','ZONE2','X','Y');
%==========================================================================

%==========================================================================
%% FIGURE:
%==========================================================================
make_it_tight = true;
% m = distance between subplots
% n = distance to bottom and upper edges
% p = distance to right and left edges
subplot = @(m,n,p) subtightplot (m, n, p, [0.04 0.01], [0.06 0.02], [0.08 0.02]);
if ~make_it_tight,  clear subplot;  end
%..........................................................................
Fig = figure;
set(gcf, 'Color','white');
set(Fig, 'Position',[400,060,500,600]);
%==========================================================================
subplot(2,1,1);
%..........................................................................
m_proj('mercator','long',[LON],'lat',[LAT]);
%..........................................................................
m_pcolor(X,Y,waterType);
shading interp
%..........................................................................
m_usercoast('alboran_coastline','patch',[1 1 1]);
m_grid('box','fancy','tickdir','in','xticklabels',[],'ytick',6,...
       'fontsize',9,'fontweight','bold');
%..........................................................................
caxis([1 3]); 
%..........................................................................
colormap(jet(3))
h1 = colorbar('EastOutside');
set(h1,'fontsize',10);
% set(h1, 'Position', [.26 .04 .5 .015]);
set(h1,'ytick',[1.30 2.00 2.65],'yticklabel',{'OLI' 'MES' 'EUT'},'fontsize',9);
%==========================================================================
subplot(2,1,2);
hold on
%..........................................................................
m_proj('mercator','long',[LON],'lat',[LAT]);
%..........................................................................
m_pcolor(X,Y,smoothed_mask);
shading interp
%..........................................................................
m_plot(xList(k), yList(k), 'k', 'LineWidth', 2);  % Plot the boundary in black
%..........................................................................
m_usercoast('alboran_coastline','patch',[1 1 1]);
m_grid('box','fancy','tickdir','in','ytick',6,'fontsize',9,'fontweight', 'bold');
%..........................................................................
caxis([1 3]); 
%..........................................................................
colormap(jet(3))
h2 = colorbar('EastOutside');
set(h2,'fontsize',10);
% set(h2, 'Position', [.26 .04 .5 .015]);
set(h2,'ytick',[1.30 2.00 2.65],'yticklabel',{'OLI' 'MES' 'EUT'},'fontsize',9);
%==========================================================================
set(gca,'FontSize',12);
%==========================================================================
%% Save figure:
%..........................................................................
set(gcf,'PaperPositionMode','auto');
print(gcf, '-dpng', 'FIG_MaskZones.png');
%==========================================================================
return