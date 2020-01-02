%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Name       : Calculating_VPs_motion
%   Author     : Laura Ruotsalainen, Finnish Geodetic Institute
%   Date       : 10/2011
%   Parameters : (in)  greyimtemp = greyscale image
%                      ccy = y-coordinate of the principal point
%                (out) vp_coord = coordinate of the vanishing point
%                      probability of the vanishing point being correct
%
%   Updates    : 6/2012 VP doesn't have to be inside the image
%
%   Modified 2019 for Computer Vision course, error detection removed
%   and other parts not important for this exercise. However, 
%   some funny variables might exist
%
%   Self developed Hough line detector is really slow, for testing
%   purposes you should use the one developed by Matlab 
%   
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [vp_coord, roll, tilt, heading] = Calculate_VPs_and_RPY(greyimtempVP,ccx,ccy,fcx,fcy,greyimtemp)


% too horizontal or vertical lines reduced

tilt=0;
heading=0;
roll=0;

hortzcont=0;
nro_vert=0;

lvx=1;
lvy=1;

noLinesY=1;
vpsc=0;
vpycoord=[];
vp_coord=[0 0];

           
        [ys,xs]=size(greyimtempVP);

        % Slopes for dividing lines into vertical and others                
        upTresh=tand(80);     
        downTresh=tand(10);
        
        % Edges found with Canny edge detector
        canim=edge(greyimtempVP,'canny');
                
       % Lines found with Matlabs Hough algorithms, can be used for
       % validating the result
       
%       [H,theta,rho]=hough(canim);
%        peaks=houghpeaks(H,75,'threshold',ceil(0.3*max(H(:))));
%        x=theta(peaks(:,2)); y=rho(peaks(:,1));
%  
%       lines = houghlines(canim,theta,rho,peaks,'FillGap',3,'MinLength',25);
                   
        lines = houghlinesLR(canim, greyimtemp);
                   
        vps = zeros(1,3);
        slopes=zeros(length(lines)); 

        enoughl1=0;
        enoughl2=0;
        
        if (length(lines)==1)
            vp_coord=zeros(1,2);   
            return; 
        else
                              
            %%%% VANISHING POINTS %%%%
            % vanishing points calculated by voting
                                                           
            for k=1:length(lines)
                         
                 yone = ys-lines(k).point1(2);
                 ytwo = ys-lines(k).point2(2);
                            
                if  lines(k).point1(1)== lines(k).point2(1) % x1=x2 => vertical
                    nro_vert=nro_vert+1;
                elseif lines(k).point1(2) == lines(k).point2(2) % y1=y2 => horizontal
                    hortzcont=hortzcont+1;
                else
                    kk = (ytwo-yone)/(lines(k).point2(1)-lines(k).point1(1));
                                     
                    % Lines for vy
                    if (abs(kk)>upTresh)
                        linesVy(lvy)=lines(k);
                        lvy=lvy+1;
                        noLinesY=0;
                    elseif (abs(kk)< downTresh)
                        linesVx(lvx)=lines(k);
                        lvx=lvx+1;
                        noLinesX=0;
                    else

                        
                        b1= yone -(kk*lines(k).point1(1));
                        % The intersection point with all other lines
                        for j=1:length(lines)                        
                          
                            if (k==j ||lines(j).point1(1)== lines(j).point2(1) || lines(j).point1(2) == lines(j).point2(2)) 
                            else
                                
                                % To ease calculations convert the image
                                % coordinate system into normal coordinate
                                % system ie (0,0) on low left corner
                                yone2 = ys-lines(j).point1(2);
                                ytwo2 = ys-lines(j).point2(2);
                                kk2 = (ytwo2-yone2)/(lines(j).point2(1)-lines(j).point1(1));
                               
                                if (abs(kk2)>upTresh || abs(kk2)<downTresh || kk2==0)
                                else
                                    b2= yone2 -(kk2*lines(j).point1(1));
                                                        
                                    A=[-kk 1; -kk2 1];
                                    vanpo=A\[b1;b2];        % y1=k1x1+b1 y2=k2x2+b2
                                                                                                       
                                    vpsc=vpsc+1;

                                    vps(vpsc,1)=vanpo(1);
                                    vps(vpsc,2)=vanpo(2);
                                    vps(vpsc,3)=1;
                                                                       
                                end
                            end
                        end
                    end
                end       %if kk=0
            end        %for lines
        end
            


% May be many vps with same weight, mean of the ones close to each other
               
        Cn=max(vps(:,3));
        indMax=find(vps(:,3)==Cn);
       
        array=vps(indMax,:);
        
        threshold = 20;
        sortedArray = sortrows(array);
        nPerGroup = diff(find([1 (diff(sortedArray(:,1))' > threshold) 1]));
        groupArray = mat2cell(sortedArray',3,nPerGroup);
                
        vpsGroups=groupArray';
        vp_x=1; vp_y=1; nroR=0;
            
        for nG=1:length(nPerGroup)
            vpsGroups{nG}(1,1)
            nroR_temp=sum(vpsGroups{nG}(3,:));
            if (nroR_temp > nroR)
                vp_x=mean(vpsGroups{nG}(1,:));
                vp_y=mean(vpsGroups{nG}(2,:));
                nroR=nroR_temp;
            end
        end
              
        vpcomp=[vp_x; vp_y];
       

         if ((length(noLinesY) < nro_vert) || noLinesY==1 ) % No lines in vertical direction intersecting
             noroll=1;
         else
            % vanishing point in y direction for calculating roll
            [vpycoord]=VPXY(linesVy,ys);
            if (not(isempty(vpycoord)) && (vpycoord(1) ~= 0))
                noroll=0;
            else
                noroll=1;
            end
                   
         end
       
         % Heading and tilt with respect to the camera with no rotation
            if (noroll)  
                    heading = asind((vpcomp(1,:)-ccx)/fcx);
                    tilt = asind((ys-vpcomp(2,:)-ccy)/-fcy*cosd(heading));
                    roll=0;
            else
                 [heading,tilt,roll]=calc_Rotation(vpcomp,vpycoord,ccx,ccy,fcx,fcy,ys);
                 if (isnan(roll)) % There we lines but they were e.g. orthogonal to the principal ray =>
                                  % vanishing point at infinity
                     roll = 0;
                     heading = asind((vpcomp(1,:)-ccx)/fcx);
                     tilt = asind((ys-vpcomp(2,:)-ccy)/-fcy*cosd(heading));
                 end

             end
                       
      
                vp_coord = [vpcomp(1,:) vpcomp(2,:)];

                if (isempty(vpcomp))
                else
                     plot(vpcomp(1,:),ys-vpcomp(2,:),'o','Color','red');
                end
                if (isempty(vpycoord) || vpycoord(1)>xs || vpycoord(1)<1 || vpycoord(2)>ys ||vpycoord(2)<1)
                else
                    plot(vpycoord(:,1),ys-vpycoord(:,2),'o','Color','yellow');
                end
                
                     h=gcf;
                    

     
     

      
        
        
       



            