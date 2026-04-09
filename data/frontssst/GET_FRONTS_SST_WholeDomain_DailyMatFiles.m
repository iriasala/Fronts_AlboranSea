close all
clear all
%==========================================================================

%==========================================================================
%% SCRIPT TO PERFORM THE EDGE-DETECTION IN REMOTE SENSING IMAGES
%==========================================================================
% Written by Iria Sala
% Created in 17.03.2025
%==========================================================================

%==========================================================================  
%% Define the directory containing the NetCDF files  
%==========================================================================  
dirin  = 'G:\My Drive\RESEARCH\PROJECT CALYPSO\02_DATA\SST1\';  
files  = dir(fullfile(dirin,'*.nc'));  
nFiles = length(files);
%==========================================================================  

%==========================================================================  
%% Define the directory containing the output files  
%==========================================================================  
dirout = 'G:\My Drive\RESEARCH\PROJECT CALYPSO\03_RESULTS\05_CED-SST\MATFILES\';    
%==========================================================================  

%==========================================================================
%% Define the study area:
%==========================================================================
% minLon = -6.00; maxLon = -1.00;
minLON = 1455; maxLON = 2055;
%--------------------------------------------------------------------------
% minLat = 34.90; maxLat = 37.80;
minLAT =  558; maxLAT =  907;
%==========================================================================

%==========================================================================  
%% Extract longitude and latitude vectors:  
%==========================================================================  
firstFile = fullfile(dirin, files(1).name);  
%--------------------------------------------------------------------------  
try  
    lon = double(nc_varget(firstFile,'lon'));
    lon = squeeze(lon);
    lon = lon(minLON:maxLON);

    lat = double(nc_varget(firstFile,'lat'));  
    lat = squeeze(lat);
    lat = lat(minLAT:maxLAT);    
catch ME  
    error('Could not read "lon" and/or "lat" from %s: %s', files(1).name, ME.message);  
end  
%==========================================================================  

%==========================================================================
%% Compute daily maps
%==========================================================================
for i = 1:nFiles
    i

    fname = files(i).name;
    filepath = fullfile(dirin,fname);
    sst1    = double(nc_varget(filepath, 'sea_surface_temperature'));
    SST1    = squeeze(sst1);

    %======================================================================
    %% CED Canny Edge Detector.
    % The CED is a multi-stage process and basically involves four steps:
    %======================================================================
    img = SST1(minLAT:maxLAT,minLON:maxLON); % From Belkin & O'Reilly 2009
    img = img - 273.15; % [degree C]
    %======================================================================
    
    %======================================================================
    %% ----------------------------- STEP 1 ---------------------------- %%
    %======================================================================
    % 1. Noise reduction by smoothing the image with a Gaussian filter.
    % The size of the filter mask depends on the standard deviation of
    % the Gaussian filter, sigma.
    % We followed Wall et al. (2008), which use a sigma value of 1.0,
    % corresponding to a 7x7 pixel mask.
    %......................................................................
    % Gaussian Filter Coefficient: Kernel 5x5, sigma = 1.
    % From Nieto, K. - PhD, 2002.
    % G = 1/200*[ 1,  3,  4,  3,  1;
    %             3, 12, 20, 12,  3;
    %             4, 20, 32, 20,  4;
    %             3, 12, 20, 12,  3;
    %             1,  3,  4,  3,  1];
    %......................................................................
    % From Oram et al. (2008) we can calculate the sigma value for the
    % Gaussian Kernel using Equation 1, based on gradient length scale
    % pixels.
    % If we used a desired edge scale of 6 km and the images are 1.1 km,
    % the sigma would be 6/1.
    % We can calculate it using the Matlab function:
    % gaussian_filter = fspecial('gaussian', filter_size, gaussian)
    %......................................................................
    G = fspecial('gaussian', 5, 3);
    % Where: 5 is filter_size 5x5
    %    and 3 is gaussian from Oram et al. (2008)
    %    alfa, eq. 3
    %......................................................................
    A = conv2(img, G, 'same');
    % Convolution of image by Gaussian Coefficient
    %======================================================================
    
    %======================================================================
    %% ----------------------------- STEP 2 ---------------------------- %%
    %======================================================================
    % 2. The edge gradient (strength and  direction) for each pixel was
    % computed using a 3x3 pixel window at the smoothed imaged, using
    % the Sobel Kernel.
    %......................................................................
    % We used the Sobel edge enhancement kernel to calculate the
    % gradient images.
    % Filter for horizontal and vertical direction
    %......................................................................
    Sobel_X = [-1.0,  0.0,  1.0;
               -2.0,  0.0,  2.0;
               -1.0,  0.0,  1.0];
    %......................................................................
    Sobel_Y = [ 1.0,  2.0,  1.0;
                0.0,  0.0,  0.0;
               -1.0, -2.0, -1.0];
    %======================================================================
    % Convolution of the image by horizontal and vertical filter with
    % SOBEL kernel.
    Grad_X = conv2(A, Sobel_X, 'same');
    Grad_Y = conv2(A, Sobel_Y, 'same');
    %======================================================================
    % Calculate the magnitude of the gradient:
    magnitude = sqrt(Grad_X.^2 + Grad_Y.^2);
    % This magnitude matrix will be used later to calculate the thresholds
    %======================================================================
    % Calculate the direction/orientation of the gradient:
    arah = atan2 (Grad_Y, Grad_X);
    arah = arah*180/pi;  % Direction of the gradient
    %......................................................................
    % Adjustment for negative directions, making all directions positive
    pan = size(A,1);
    leb = size(A,2);
    %......................................................................
    for i = 1:pan
        
        for j = 1:leb
            
            if (arah(i,j)<0)
                arah(i,j) = 360 + arah(i,j);
                
            end
        end
    end
    %======================================================================
    
    %======================================================================
    %% ----------------------------- STEP 3 ---------------------------- %%
    %======================================================================
    % 3. Non-Maximum Supression
    % 3.1. Adjusting directions to nearest 0, 45, 90, or 135 degree.
    %......................................................................
    arah2 = zeros(pan, leb);
    %......................................................................
    for i = 1:pan
        
        for j = 1:leb
            
            if ((arah(i, j) >= 0 )...
                    && (arah(i, j) <   22.5) || (arah(i, j) >= 157.5)...
                    && (arah(i, j) <  202.5) || (arah(i, j) >= 337.5)...
                    && (arah(i, j) <= 360.0))
                arah2(i, j) = 0;
                
            elseif ((arah(i, j) >=   22.5)...
                    && (arah(i, j) < 67.5) || (arah(i, j) >= 202.5)...
                    && (arah(i, j) < 247.5))
                arah2(i, j) = 45;
                
            elseif ((arah(i, j) >=       67.5...
                    && arah(i, j) < 112.5) || (arah(i, j) >= 247.5...
                    && arah(i, j) < 292.5))
                arah2(i, j) = 90;
                
            elseif ((arah(i, j) >=      112.5...
                    && arah(i, j) < 157.5) || (arah(i, j) >= 292.5...
                    && arah(i, j) < 337.5))
                arah2(i, j) = 135;
                
            end
            
        end
        
    end
    %======================================================================
    % 3.2. Non-Maximal Supression:
    % BW is a matriz with 0 (no edges) and 1 (edges).
    %......................................................................
    BW = zeros(pan, leb);
    %......................................................................
    for i = 2:pan-1
        
        for j = 2:leb-1
            
            if (arah2(i,j)==0)
                BW(i,j) = (magnitude(i,j) == max([magnitude(i,j),...
                    magnitude(i,j+1), magnitude(i,j-1)]));
                
            elseif (arah2(i,j)==45)
                BW(i,j) = (magnitude(i,j) == max([magnitude(i,j),...
                    magnitude(i+1,j-1), magnitude(i-1,j+1)]));
                
            elseif (arah2(i,j)==90)
                BW(i,j) = (magnitude(i,j) == max([magnitude(i,j),...
                    magnitude(i+1,j), magnitude(i-1,j)]));
                
            elseif (arah2(i,j)==135)
                BW(i,j) = (magnitude(i,j) == max([magnitude(i,j),...
                    magnitude(i+1,j+1), magnitude(i-1,j-1)]));
                
            end
            
        end
        
    end
    %......................................................................
    BWGrad = BW .* magnitude;
    % BWGrad is the matrix with the edge pixels including the gradient value
    %======================================================================
    
    %======================================================================
    %% ----------------------------- STEP 4 ---------------------------- %%
    %======================================================================
    % 4. Hysteresis (double) thresholding is applied to determine the
    % significance of the edge gradient. Chains of edge pixels gradients
    % with magnitudes below the lower gradient threshold are removed.
    % Edge pixel gradient magnitudes above the lower threshold and
    % connected through a chain to any edge pixel gradient with a
    % magnitude above the upper gradient threshold remain.
    %......................................................................
    % Value for Thresholding: The gradient cumulative histogram is
    % used to set the upper threshold (T_high) and the lower threshold
    % (T_low) (Ping Bo et al., 2014; Oram et al, 2008).
    %......................................................................
    % We used the 0.8 and 0.95 percent pixeles with gradient.
    %......................................................................
    nbins   = 10000.0;
    MaxGrad =     0.6;
    xbins   = 0:MaxGrad/(nbins-1):MaxGrad;
    %......................................................................
    [counts,centers] = hist(magnitude(:),nbins,xbins);
    fNormalized      = counts/sum(counts);
    cdf              = cumsum(fNormalized);
    %......................................................................
    if sum(isnan(cdf))==10000      
        T_Low  = NaN;
        T_High = NaN;
        T_res  = NaN*ones(601,668);
        frontalgrad  = NaN*ones(601,668);
    else
        %..................................................................
        loc_Tlow  = find(min(abs((cdf - 0.80)))==abs((cdf - 0.80)));
        T_Low     = centers(loc_Tlow(1));
        %[Percent,GM] = histcounts(magnitude,'Normalization','cdf');
        % Cumulative histogram of gradient
        %..................................................................
        loc_Thigh  = find(min(abs((cdf - 0.95)))==abs((cdf - 0.95)));
        T_High     = centers(loc_Thigh(1));
        %[Percent,GM] = histcounts(magnitude,'Normalization','cdf');
        % Cumulative histogram of gradient
        %..................................................................
        aboveT_Low = BWGrad > T_Low;
        % Edge points above lower threshold.
        [aboveT_Highr, aboveT_Highc] = find(BWGrad > T_High);
        % Row and column coords of points above upper threshold.
        %..................................................................
        % Obtain all connected regions in above T_Low that include
        % a point that has a value above T_High
        T_res = bwselect(aboveT_Low, aboveT_Highc, aboveT_Highr, 8);
        T_res = double(T_res);
        %..................................................................
        frontalgrad = magnitude .* T_res;
        frontalgrad(frontalgrad==0)=NaN;
        % Matrix with the edge pixels and gradient magnitude
    end
    %======================================================================

    %======================================================================
    %% Save data:
    %======================================================================
    save(fullfile(dirout,[fname(1:end-3),'.mat']),'-v7.3','lon','lat',...
         'magnitude','frontalgrad','T_res','T_Low','T_High');
    %======================================================================

end
%==========================================================================
return
