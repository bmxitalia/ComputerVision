%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Name       : Based on Motion_Laura_Full
%   Author     : Laura Ruotsalainen, Finnish Geodetic Institute
%   Date       : 10/2011
%
%   Updates    : Modified 2019 for Computer Vision course, 
%                all else but vanishing point and attitude computation 
%                removed
% 
%   
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

warning off all;
clear all;
close all;

iter=1;

vpcoord=zeros(2,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read calibration results from a file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Calib_Results
angle1= 0;

% principal point times 0.5 for the resolution of the images is reduced
% compared to the ones used in calibration
ccx=cc(1);
ccy=cc(2);

% focal length
fcx=fc(1);
fcy=fc(2);

% initialization for vp calculation
roll=zeros(2,2);
tilt= zeros(2,2);
heading=zeros(2,2);

        imp=imread('Corridor1.jpg');
        imp = correctDistorsion(imp);
        greyimtemp=rgb2gray(imp);
            
        [height,width]=size(greyimtemp);
        
        % Linear Filtering with Matlab's Gaussian filter
         H=fspecial('unsharp'); 
         im1=imfilter(greyimtemp,H,'replicate','conv');
              
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Calculate vanishing points
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
   
        [vpcoord(1,:),roll(1), tilt(1), heading(1)] = Calculate_VPs_and_RPY(im1,ccx,ccy,fcx,fcy,greyimtemp);

        % The next photo
          
        imp2=imread('Corridor2.jpg');
        imp2 = correctDistorsion(imp2);
        greyimtemp2=rgb2gray(imp2);
                
        % Linear Filtering with Matlab's filter
        H=fspecial('unsharp'); 
        im2=imfilter(greyimtemp2,H,'replicate','conv');
                              
        [vpcoord(2,:), roll(2), tilt(2), heading(2)] = Calculate_VPs_and_RPY(im2,ccx,ccy,fcx,fcy,greyimtemp2);

        disp ('Change in heading, pitch and roll')
        heading(2)-heading(1)
        tilt(2)-tilt(1)
        roll(2)-roll(1)

     
   
   hold off;
   %close all;

toc
 

