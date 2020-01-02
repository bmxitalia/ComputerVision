I1 = rgb2gray(imread('frame10.png'));
I2 = rgb2gray(imread('frame11.png'));
% compute gradients in x and y direction at time t using central filter 
% to avoid image shifting
[Gx,Gy] = imgradientxy(I1, 'central');
% compute temporal gradient between time t and t + 1 using frame
% differences
Gt = I1 - I2;
Gt = double(Gt);
% move a 5x5 patch in the image and solve a 25 linear equations system
% for each patch using least square method
a1 = 0.0;
a2 = 0.0;
a3 = 0.0;
a4 = 0.0;
a5 = 0.0; 
a6 = 0.0;
% variables to store the flow velocities
u = [];
v = [];
for x=1:size(I1,1)
    for y=1:size(I1,2)
        if x+4 <= size(I1,1) && y+4 <= size(I1,2)
            for i=x:x+4
                for j=y:y+4
                    a1 = a1 + Gx(i,j)^2;
                    a2 = a2 + Gx(i,j)*Gy(i,j);
                    a3 = a3 + Gy(i,j)*Gx(i,j);
                    a4 = a4 + Gy(i,j)^2;
                    a5 = a5 + Gx(i,j)*Gt(i,j);
                    a6 = a6 + Gy(i,j)*Gt(i,j);
                end
            end
            a5 = -a5;
            a6 = -a6;
            A = [a1 a2; a3 a4];
            b = [a5; a6];
            % solving the system
            uv = A\b;
            u(end+1) = uv(1);
            v(end+1) = uv(2);
        end
    end
end