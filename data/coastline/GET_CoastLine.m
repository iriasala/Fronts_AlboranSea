close all
clear all
%==========================================================================

%==========================================================================
%% Using GSHHS effectively
% The simplest calling mechanism is identical to that for m_coast (Section 3). 
% For example, to draw a gray-filled high-resolution coastline, you just need
%..........................................................................
% m_gshhs_h('patch',[.5 .5 .5]);
%..........................................................................
% However, execution times may be very, very long, as the entire database 
% must be searched and processed. I would not recommend trying to draw world
% maps with the intermediate or high-resolution coastlines! There are two 
% ways to speed this up. The first is to use a lower-resolution database,
% with fewer points. The second is useful if you are going to be repeatedly
% drawing a map (because, for example, it's the base figure for your work).
% In this case I recommend that you save an intermediate processed (generally
% smaller) file as follows:
%..........................................................................
ROI = [-8.0 3.0 34.0 39.0];
m_proj('mercator','long',[ROI(1) ROI(2)],'lat',[ROI(3) ROI(4)]);  % set up projection parameters
%..........................................................................
% This command does not draw anything - it merely processes the 
% high-resolution database using the current projection parameters 
% to generate a smaller coastline file called "gumby"
%..........................................................................
m_gshhs_f('save','alboran_coastline');
%..........................................................................
% Now we can draw a few maps of the same area much more quickly
%..........................................................................
figure(1);
m_usercoast('alboran_coastline','patch','r');
m_grid;
%..........................................................................
figure(2);
m_usercoast('alboran_coastline','linewidth',2,'color','b');
m_grid('tickdir','out','yaxisloc','left');
%==========================================================================
return
