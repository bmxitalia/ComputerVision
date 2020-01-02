function [vpycoord]=VPXY(ylines,ys)

vpymat=zeros(length(ylines),3);
vpc=1;

  for ky=1:length(ylines)
                 
     yone = ys-ylines(ky).point1(2);
     ytwo = ys-ylines(ky).point2(2);
                 
     if  ylines(ky).point1(1)== ylines(ky).point2(1) % x1=x2 => vertical
     else
         kk = (ytwo-yone)/(ylines(ky).point2(1)-ylines(ky).point1(1));                   
         b1= yone -(kk*ylines(ky).point1(1));
         % The intersection point with all other lines
         for jy=1:length(ylines)
          
             if (ky==jy ||ylines(jy).point1(1)== ylines(jy).point2(1)) 
             else
                 yone2 = ys-ylines(jy).point1(2);
                 ytwo2 = ys-ylines(jy).point2(2);
                 kk2 = (ytwo2-yone2)/(ylines(jy).point2(1)-ylines(jy).point1(1));
                               
                 if (kk2==0)
                 else
                     b2= yone2 -(kk2*ylines(jy).point1(1));                    
                     A=[-kk 1; -kk2 1];
                     vanpoy=A\[b1;b2];
                     if (isinf(vanpoy(1)) || isinf(vanpoy(2)))
                         break;
                     end
                     
   
                        vpymat(vpc,1)= round(vanpoy(1));
                        vpymat(vpc,2)= round(vanpoy(2));
                        vpymat(vpc,3)= 1;
                        vpc=vpc+1;
                                                                    
                     
                 end
             end
         end
         
     end
  end
    
  [maxC, maxI]=max(vpymat(:,3));
  vpycoord(1)=vpymat(maxI,1);
  vpycoord(2)=vpymat(maxI,2);
 
  % If the calculations succeeded
  if (vpycoord(1)==1)
      vpycoord=[0 0];
  end