close all
clear all
%==========================================================================

%==========================================================================
%% SCRIPT TO PERFORM THE EDGE-DETECTION IN REMOTE SENSING IMAGES
%==========================================================================
% Gabriel Navarro, Nikolaos Zarokanellos and Ismael Hernandez.
% ICMAN - CSIC, SOCIB, IMEDEA-CSIC.
%==========================================================================

%==========================================================================
%% Some info:
%==========================================================================
ROI = [-6.00 0.00 34.90 37.80];
scrsz = get(0,'ScreenSize');
%..........................................................................
% file = 'C:\Users\usuario\Google Drive\RESEARCH\BolsaICMAN\PROJECT_CALYPSO\02_DATA\GlobColour\CHL1\Daily\L3m_19970922__778213049_1_GSM-SWF_CHL1_DAY_00.nc';
file = '/Users/iria/Library/CloudStorage/OneDrive-UniversityofStrathclyde/ProjectCalypso/02_DATA/GlobColour/CHL1/Daily/L3m_19970922__778213049_1_GSM-SWF_CHL1_DAY_00.nc';
%..........................................................................
lon = double(nc_varget(file,'lon'));
lon = lon(1:402);
lat = double(nc_varget(file,'lat'));
%..........................................................................
[X,Y] = meshgrid(lon,lat);
%==========================================================================

%==========================================================================
%% LOAD REMOTE SENSING DATABASE:
%==========================================================================
VAR = ['CHL1'];
%..........................................................................
% dirin = 'C:\Users\usuario\Google Drive\RESEARCH\BolsaICMAN\PROJECT_CALYPSO\02_DATA\GlobColour\CHL1\Daily\';
dirin = '/Users/iria/Library/CloudStorage/OneDrive-UniversityofStrathclyde/ProjectCalypso/02_DATA/GlobColour/CHL1/Daily/';
%==========================================================================
for year = 2005

    %......................................................................
    files = dir([dirin,'L3m_',num2str(year),'*GSM*',VAR,'*.nc']);
    %......................................................................
    Dates = [];
    %......................................................................
    Gradient  = NaN*ones(401,402,length(files));
    GradFront = NaN*ones(401,402,length(files));
    Fronts    = NaN*ones(401,402,length(files));
    Threshold = NaN*ones(length(files),2);
    %......................................................................
%     return
    %======================================================================
    %% By day:
    %======================================================================
    for z = 127
%         z

        %==================================================================
        fname = files(z).name;
        %==================================================================

        %==================================================================
        % Get dates:
        %..................................................................
        date  = datenum(str2num(fname(5:8)),str2num(fname(9:10)),str2num(fname(11:12)));
        Dates = [Dates; date];
        %==================================================================

        %==================================================================
        VarExt = [VAR,'_mean'];
        %..................................................................
        CHL1 = double(nc_varget([dirin,fname],VarExt));
        %         CHL2 = rot90(CHL1,1);   % No entiendo este paso
        %         CHL3 = flipud(CHL2);
        CHL1 = CHL1(:,1:402);
        %..................................................................
        clear CHL2 CHL3
        %==================================================================
    
        %==================================================================
        %% CED Canny Edge Detector.
        % The CED is a multi-stage process and basically involves four steps:
        %==================================================================
        % Chlorophyll distribution on the global scale is approximately 
        % log-normal (Campbell, 1995). Therefore we have to transform 
        % log-normally the original chl data.
        % Our logarithmic gradient of Chl at every pixel is the difference
        % between natural logarithms of Chl at adjacent pixels that is the 
        % natural logarithm of the ratio of adjacent Chl values.
        %==================================================================
        img = log10(CHL1); % From Belkin & O'Reilly 2009
        %==================================================================
        
        %==================================================================
        %% __________STEP 1  ___________________
        %==================================================================
        % 1. Noise reduction by smoothing the image with a Gaussian filter.
        % The size of the filter mask depends on the standard deviation of 
        % the Gaussian filter, sigma.
        % We followed Wall et al. (2008), which use a sigma value of 1.0,
        % corresponding to a 7x7 pixel mask.
        %..................................................................
        % Gaussian Filter Coefficient: Kernel 5x5, sigma = 1.
        % From Nieto, K. - PhD, 2002.
        % G = 1/200*[ 1,  3,  4,  3,  1;
        %             3, 12, 20, 12,  3;
        %             4, 20, 32, 20,  4;
        %             3, 12, 20, 12,  3;
        %             1,  3,  4,  3,  1];
        %..................................................................
        % From Oram et al. (2008) we can calculate the sigma value for the
        % Gaussian Kernel using Equation 1, based on gradient length scale 
        % pixels.
        % If we used a desired edge scale of 6 km and the images are 1.1 km,
        % the sigma would be 6/1.
        % We can calculate it using the Matlab function:
        % gaussian_filter = fspecial('gaussian', filter_size, gaussian)
        %..................................................................
        G = fspecial('gaussian', 5, 3);
        % Where: 5 is filter_size 5x5
        %    and 3 is gaussian from Oram et al. (2008)
	%    alfa, eq. 3
        %..................................................................
        A = conv2(img, G, 'same');
        % Convolution of image by Gaussian Coefficient
        %==================================================================
        
        %==================================================================
        %% __________STEP 2  ___________________
        %==================================================================
        % 2. The edge gradient (strength and  direction) for each pixel was
        % computed using a 3x3 pixel window at the smoothed imaged, using
        % the Sobel Kernel.
        %...................................................................
        % We used the Sobel edge enhancement kernel to calculate the
        % gradient images. 
        % Filter for horizontal and vertical direction
        %...................................................................
        Sobel_X = [-1.0,  0.0,  1.0;
                   -2.0,  0.0,  2.0;
                   -1.0,  0.0,  1.0];
        %...................................................................
        Sobel_Y = [ 1.0,  2.0,  1.0; 
                    0.0,  0.0,  0.0;
                   -1.0, -2.0, -1.0];
        %==================================================================        
        % Convolution of the image by horizontal and vertical filter with 
        % SOBEL kernel.
        Grad_X = conv2(A, Sobel_X, 'same');
        Grad_Y = conv2(A, Sobel_Y, 'same');
        %==================================================================                
        % Calculate the magnitude of the gradient:
        magnitude = sqrt(Grad_X.^2) + (Grad_Y.^2);  
        % This magnitude matriz will be used later to calculate the thresholds
        %==================================================================                
        % Calculate the direction/orientation of the gradient:
        arah = atan2 (Grad_Y, Grad_X);
        arah = arah*180/pi;  % Direction of the gradient
        %...................................................................        
        % Adjustment for negative directions, making all directions positive
        pan = size(A,1);
        leb = size(A,2);
        %...................................................................
        for i = 1:pan
            
            for j = 1:leb
                
                if (arah(i,j)<0)    
                    arah(i,j) = 360 + arah(i,j);
                    
                end
            end
        end
        %==================================================================                
        
        %==================================================================                        
        %% __________STEP 3  ___________________
        %==================================================================                
        % 3. Non-Maximum Supression
        % 3.1. Adjusting directions to nearest 0, 45, 90, or 135 degree.
        %...................................................................
        arah2 = zeros(pan, leb);
        %...................................................................        
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
        %==================================================================                
        % 3.2. Non-Maximal Supression:
        % BW is a matriz with 0 (no edges) and 1 (edges).
        %...................................................................
        BW = zeros(pan, leb);
        %...................................................................                
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
        %...................................................................                
        BWGrad = BW .* magnitude;
        % BWGrad is the matrix with the edge pixels including the gradient value
        %==================================================================                
        
        %==================================================================                
        %% __________STEP 4  ___________________
        %==================================================================                        
        % 4. Hysteresis (double) thresholding is applied to determine the
        % significance of the edge gradient. Chains of edge pixels gradients
        % with magnitudes below the lower gradient threshold are removed.
        % Edge pixel gradient magnitudes above the lower threshold and
        % connected through a chain to any edge pixel gradient with a
        % magnitude above the upper gradient threshold remain.
        %...................................................................                
        % Value for Thresholding: The gradient cumulative histogram is
        % used to set the upper threshold (T_high) and the lower threshold
        % (T_low) (Ping Bo et al., 2014; Oram et al, 2008).
        %..................................................................              
        % We used the 0.8 and 0.95 percent pixeles with gradient.
        %..................................................................
        nbins   = 10000.0;
        MaxGrad =     0.6;
        xbins   = 0:MaxGrad/(nbins-1):MaxGrad;
        %..................................................................        
        [counts,centers] = hist(magnitude(:),nbins,xbins);
        fNormalized      = counts/sum(counts);
        cdf              = cumsum(fNormalized);
        %..................................................................
        if sum(isnan(cdf))==10000
            
            T_Low  = NaN;
            T_High = NaN;
            T_res  = NaN*ones(401,402);
            GradFronts  = NaN*ones(401,402);            
        
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
            % Obtain all connected regions in aboveT_Low that include
            % a point that has a value above T_High
            T_res = bwselect(aboveT_Low, aboveT_Highc, aboveT_Highr, 8);
            T_res = double(T_res);
        %..................................................................
            GradFronts = magnitude .* T_res;
            GradFronts(GradFronts==0)=NaN;
            % Matrix with the edge pixels and gradient magnitude
        %..................................................................
            
        end
        %==================================================================                

        %==================================================================                
        %% DATABASE: outputs
        %..................................................................
                Gradient (:,:,z) = magnitude;
                GradFront(:,:,z) = GradFronts;
                Fronts   (:,:,z) = T_res;
                Threshold(z,:)   = [T_Low T_High];
        %==================================================================                
%         return
        %==================================================================
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIGURES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %==================================================================
        make_it_tight = true;
        % m = distancia entre subplots (Vertical horizontal)
        % n = distancia a los bordes inferior y superior
        % p = distancia a los bordes derecho e izquierdo
        subplot = @(m,n,p) subtightplot (m, n, p, [0.01 0.01], [0.02 0.02], [0.02 0.02]);
        if ~make_it_tight,  clear subplot;  end
        ...................................................................
            Fig = figure;
        set(gcf, 'Color','white');
        set(Fig, 'Position',[400,050,800,700]);
        %==================================================================
        S1 = subplot(3,2,[1 2]);
        hold on
        %..................................................................
        m_proj('mercator','long',[ROI(1) ROI(2)],'lat',[ROI(3) ROI(4)]);
        %..................................................................
        m_pcolor(X,Y,log10(CHL1));
        shading interp
        %..................................................................
        m_usercoast('alboran_coastline','patch',[1 1 1]);
        m_grid('box','fancy','tickdir','in','ytick',6,'fontsize',10,...
            'fontweight','bold');
        %..................................................................
%         str = {'[CHL] (mg m^{-3})'};
%         text(-0.0423,0.6495,str,'LineStyle','none', 'fontsize', 12,...
%              'HorizontalAlignment','left','FontWeight','bold');
        %..................................................................
        colormap('jet')
        caxis([log10(0.1) log10(6)])
        h1 = colorbar('EastOutside');
        set(h1,'fontsize',10);
        set(h1, 'Position', [.685 .69 .015 0.22]);
        % ditancia al margen izquierdo
        % distancia al margen inferior
        % largo
        % ancho
        set(h1,'yTick',[log10(0.1) log10(0.3) log10(0.9) log10(3.0) log10(6.0)],...
            'yticklabel',[0.1 0.3 0.9 3.0 6.0],'FontSize',10)
        %==================================================================
        S2 = subplot(3,2,3);
        hold on
        %..................................................................
        m_proj('mercator','long',[ROI(1) ROI(2)],'lat',[ROI(3) ROI(4)]);
        %..................................................................
        m_pcolor(X,Y,A);
        shading interp
        %..................................................................
        m_usercoast('alboran_coastline','patch',[1 1 1]);
        m_grid('box','fancy','tickdir','in','ytick',6,'fontsize',10,...
            'fontweight','bold','xticklabels',[]);
        %..................................................................
%         str = {'[CHL] (mg m^{-3})'};
%         text(-0.0423,0.6495,str,'LineStyle','none', 'fontsize', 12,...
%              'HorizontalAlignment','left','FontWeight','bold');
        %..................................................................
        colormap('jet')
        caxis([log10(0.1) log10(6)])
        h2 = colorbar('EastOutside');
        set(h2,'fontsize',10);
        set(h2, 'Position', [.435 .38 .015 0.22]);
        % ditancia al margen izquierdo
        % distancia al margen inferior
        % largo
        % ancho
        set(h2,'yTick',[log10(0.1) log10(0.3) log10(0.9) log10(3.0) log10(6.0)],...
            'yticklabel',[0.1 0.3 0.9 3.0 6.0],'FontSize',10)
        %==================================================================
        S3 = subplot(3,2,4);
        hold on
        %..................................................................
        m_proj('mercator','long',[ROI(1) ROI(2)],'lat',[ROI(3) ROI(4)]);
        %..................................................................
        m_pcolor(X,Y,magnitude);
        shading interp
        %..................................................................
        m_usercoast('alboran_coastline','patch',[1 1 1]);
        m_grid('box','fancy','tickdir','in','ytick',6,'fontsize',10,...
            'fontweight','bold','xticklabels',[],'yticklabels',[]);
        %..................................................................
%         str = {'[CHL] (mg m^{-3})'};
%         text(-0.0423,0.6495,str,'LineStyle','none', 'fontsize', 12,...
%              'HorizontalAlignment','left','FontWeight','bold');
        %..................................................................
        colormap('jet')
        caxis([0 2])
        h3 = colorbar('EastOutside');
        set(h3,'fontsize',10);
        set(h3, 'Position', [.915 .38 .015 0.22]);
        % ditancia al margen izquierdo
        % distancia al margen inferior
        % largo
        % ancho
        set(h3,'yTick',[0:0.5:2],'yticklabel',[0:0.5:2],'FontSize',10)
        %==================================================================
        S4 = subplot(3,2,5);
        hold on
        %..................................................................
        m_proj('mercator','long',[ROI(1) ROI(2)],'lat',[ROI(3) ROI(4)]);
        %..................................................................
        T_res(T_res==0)=NaN;
        m_pcolor(X,Y,T_res)
        shading flat
        %..................................................................
        m_usercoast('alboran_coastline','patch',[1 1 1]);
        m_grid('box','fancy','tickdir','in','ytick',6,'fontsize',10,...
            'fontweight','bold');
        %..................................................................
%         str = {'Chl Fronts'};
%         text(-0.0423,0.6495,str,'LineStyle','none', 'fontsize', 12,...
%              'HorizontalAlignment','left','FontWeight','bold');
        %..................................................................
        colormap('jet')
        caxis([0 1])
        h4 = colorbar('EastOutside');
        set(h4,'fontsize',10);
        set(h4, 'Position', [.435 .095 .015 0.22]);
        % ditancia al margen izquierdo
        % distancia al margen inferior
        % largo
        % ancho
        set(h4,'yTick',[0.0:0.2:1.0],'yticklabel',[0.0:0.2:1.0],'FontSize',10)
        %==================================================================
        S5 = subplot(3,2,6);
        hold on
        %..................................................................
        m_proj('mercator','long',[ROI(1) ROI(2)],'lat',[ROI(3) ROI(4)]);
        %..................................................................
        m_pcolor(X,Y,GradFronts)
        shading flat
        %..................................................................
        m_usercoast('alboran_coastline','patch',[1 1 1]);
        m_grid('box','fancy','tickdir','in','ytick',6,'fontsize',10,...
            'fontweight','bold','yticklabels',[]);
        %..................................................................
%         str = {'Chl Fronts'};
%         text(-0.0423,0.6495,str,'LineStyle','none', 'fontsize', 12,...
%              'HorizontalAlignment','left','FontWeight','bold');
        %..................................................................
        colormap('jet')
        caxis([0 1])
        h5 = colorbar('EastOutside');
        set(h5,'fontsize',10);
        set(h5, 'Position', [.915 .095 .015 0.22]);
        % ditancia al margen izquierdo
        % distancia al margen inferior
        % largo
        % ancho
        set(h5,'yTick',[0.0:0.2:1.0],'yticklabel',[0.0:0.2:1.0],'FontSize',10)
        %==================================================================
        set(S1,'position',[0.31 0.500 0.36 0.60])
        % distancia al borde izquierdo
        % distancia al borde inferior
        % distancia al borde derecho
        % alto de la gráfica
        set(S2,'position',[0.06 0.310 0.36 0.36])
        set(S3,'position',[0.54 0.310 0.36 0.36])
        set(S4,'position',[0.06 0.025 0.36 0.36])
        set(S5,'position',[0.54 0.025 0.36 0.36])
        %==================================================================
        %% Save figure:
        %..................................................................
        formatOut = 'yyyymmdd';
        figname = sprintf(['PLOT_CaseStudy_',datestr(date,formatOut),'.png']);
        %..................................................................
        set(gcf,'PaperPositionMode','auto');
        print(gcf, '-dpng',[figname]);
        %==================================================================
%         close      
        %==================================================================
        clear img magnitude T_res A T_High T_Low Percent GM BW BWGrad arah2 
        clear arah Grad_X Grad_Y Sobel_X Sobel_Y
        %==================================================================

    end

end
%==========================================================================
return
