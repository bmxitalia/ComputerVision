function [heading,tilt,roll]=calc_Rotation(vpcomp,vpycoord,ccx,ccy,fcx,fcy,ys)

K=[fcx 0 ccx;0 fcy ccy;0 0 1];
V=[1 vpycoord(1) vpcomp(1);1 ys-vpycoord(2) ys-vpcomp(2);1 1 1]; % Contains only vp in y-direction because 
                                                                 % when using vp in x-direction only 3rd  column is used 
R_vp=inv(K)*V;

    roll=-atand(R_vp(1,2)/R_vp(2,2));
    %(abs((R_vp(2,3)+(cosd(roll)/sind(roll)*R_vp(1,3)))/(sind(roll)+((cosd(roll))^2/sind(roll)))))
    
    if ((abs((R_vp(2,3)+(cosd(roll)/sind(roll)*R_vp(1,3)))/(sind(roll)+((cosd(roll))^2/sind(roll))))) > 1.0)
        heading=0;
        tilt=0;
        roll=0;
        return;
    else
        heading = asind((R_vp(2,3)+(cosd(roll)/sind(roll)*R_vp(1,3)))/(sind(roll)+((cosd(roll))^2/sind(roll))));
        if ((abs((R_vp(1,3)-cosd(roll)*sind(heading))/(sind(roll)*cosd(heading)))) > 1.0)
            heading=0;
            tilt=0;
            roll=0;
            return;
        else
            tilt = asind((R_vp(1,3)-cosd(roll)*sind(heading))/(sind(roll)*cosd(heading))); 
        end
    end
