close all
clear all
%==========================================================================

%==========================================================================
%% Quantile Regression Analysis for weekly time series
%--------------------------------------------------------------------------
% Writen by Iria Sala (with ChatGPT)
% Created on 20.06.2025
% Last updated on 23.07.2025 
%--------------------------------------------------------------------------
% This script performs quantile regression at 0.25, 0.5, and 0.75
% quantiles to estimate seasonal trends, following Wang et al. (2023).
%==========================================================================

%==========================================================================
%% Quantile Regression Toolbox:
%==========================================================================
addpath('G:\My Drive\RESEARCH\ToolsMatlab\Quantile_reg');
%==========================================================================

%==========================================================================
%% Load data:
%==========================================================================
path = 'G:\My Drive\RESEARCH\PAPERS\InPreparation\Fronts_AlboranSea\Data\Weekly\';
file = 'CHL_Vector_TimeSeries_07dMean.mat';
%..........................................................................
load(fullfile(path,file));
%..........................................................................
y0 = fillmissing(CHLZ2v,'linear');           % Interpolate missing values
t0 = datetime(year(weeklyDates(1)), 1, 1); % Convert datetime to decimal year
t0 = t0';
%..........................................................................
y = y0';
% Decimal year from exact day
t = year(weeklyDates) + (day(weeklyDates, 'dayofyear') - 1) ./ 365.25;
%..........................................................................
y = y(:);   % Convert to column vector
t = t(:);   % Convert to column vector
%..........................................................................
tm = mean(t);  % centre time to reduce intercept magnitude
tc = t - tm;
%==========================================================================

%==========================================================================
%% Quantile regression setup
%==========================================================================
quantiles = [0.25, 0.5, 0.75];
slopes = zeros(size(quantiles));
intercepts = zeros(size(quantiles));
ci = zeros(length(quantiles),2);  % confidence intervals
%..........................................................................
nboot = 500;
rng(2025);  % Fixed seed for reproducibility
%==========================================================================

%==========================================================================
%% Run quantile regression
%==========================================================================
for i = 1:length(quantiles)
    
    tau = quantiles(i);

    slopes_boot = zeros(nboot,1);

    for j = 1:nboot

        idx = randsample(length(t),length(t),true);
        
        tmp_range = range(t(idx));  % add semicolon here
        if tmp_range < 0.01
            slopes_boot(j) = NaN;
            continue
        end
        
        try
            b = qr_standard(tc(idx),y(idx),tau,'test','kernel');
            slopes_boot(j) = b(2);
        catch
            slopes_boot(j) = NaN;
        end
        
    end

    % Clean NaNs
    slopes_boot = slopes_boot(~isnan(slopes_boot));

    % Check if we have enough samples
    if length(slopes_boot) < 50
        
        warning('Too few valid bootstrap samples at τ = %.2f. Using direct estimate.', tau);
        b_direct = qr_standard(tc,y,tau,'test','kernel');
        slopes(i) = b_direct(2);
        intercepts(i) = b_direct(1);
        ci(i,:) = [NaN NaN];
        
    else
        
        slopes(i) = median(slopes_boot);
        sdv(i) = std(slopes_boot);
        ci(i,:) = prctile(slopes_boot, [2.5 97.5]);
        b_final = qr_standard(tc,y,tau,'test','kernel');
        intercepts(i) = b_final(1);
        
    end
end
%==========================================================================

%==========================================================================
%% Compute regression lines:
%==========================================================================
yhat = zeros(length(t), length(quantiles));
for i = 1:length(quantiles)
    yhat(:,i) = intercepts(i) + slopes(i) * (t(:) - tm);
end
%==========================================================================

%==========================================================================
%% Plot results
%==========================================================================
figure;
plot(t, y, '.', 'color', [0.6 0.6 0.6]); hold on;
colors = lines(length(quantiles));

plot(t, yhat(:,1), '-', 'LineWidth', 2, 'Color', colors(1,:));
plot(t, yhat(:,2), '-', 'LineWidth', 2, 'Color', colors(2,:));
plot(t, yhat(:,3), '-', 'LineWidth', 2, 'Color', colors(3,:));

legend('Data', '25th quantile', 'Median (50th)', '75th quantile');
xlabel('Year'); ylabel('CHL (mg m^{-3})');
title('Quantile Regression of Weekly CHL');
grid on;
%==========================================================================

%==========================================================================
%% Save data:
%==========================================================================
save('QR_CHL_Z2.mat','t','y','intercepts','slopes','ci','sdv','yhat');
%==========================================================================
return