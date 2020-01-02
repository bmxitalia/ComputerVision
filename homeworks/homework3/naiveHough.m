
%[h, t, r] = hought(imread('rect.jpg'));
im = zeros(101,101);
im(1,1)=1;
im(1,end)=1;
im(end,1)=1;
im(end,end)=1;
im(floor(end/2), floor(end/2))=1;
%[h, t, r] = hought(im);
%h = houghx(im, 10, 300, 300);
[h, t, r] = hough(im);
%imshow(h>1);
s = size(h);
imshow(im); hold on;
for t=1:s(2)
    for r=1:s(1)
        if h(r, t) > 1
            x = 1:400;
            y = -x * (cosd(-r)/sind(-r)) + (t/sind(-r));
            plot(y, x);
        end
    end
end

function [ Hough, theta_range, rho_range ] = hought(I)
%NAIVEHOUGH Peforms the Hough transform in a straightforward way.
%   
    %img = rgb2gray(I);
    img = I;
    edges = edge(img, 'canny');
    [rows, cols] = size(edges);
 
    theta_maximum = 90;
    rho_maximum = floor(sqrt(rows^2 + cols^2)) - 1;
    theta_range = -theta_maximum:theta_maximum - 1;
    rho_range = -rho_maximum:rho_maximum;
 
    Hough = zeros(length(rho_range), length(theta_range));
 
    wb = waitbar(0, 'Naive Hough Transform');
    
    for row = 1:rows
        waitbar(row/rows, wb);
        for col = 1:cols
            if edges(row, col) > 0
                x = col - 1;
                y = row - 1;
                for theta = theta_range
                    rho = round((x * cosd(theta)) + (y * sind(theta)));                   
                    rho_index = rho + rho_maximum + 1;
                    theta_index = theta + theta_maximum + 1;
                    Hough(rho_index, theta_index) = Hough(rho_index, theta_index) + 1;
                end
            end
        end
    end
    close(wb);
    %{
    i = 0;
    %imshow(I); hold on;
    for t=1:length(theta_range)
        for r=1:length(rho_range)
            i = i + 1;
            if Hough(r, t) > 2
                x = 1:400;
                y = -x * (cos(t)/sin(t)) + (r/sin(t));
                plot(x, y);
            end
        end
    end
    i
    %}
end

function h = houghx(im, thresh, nrho, ntheta)
    img = edge(im, 'canny');
    imshow(img);
    acc = zeros(nrho, ntheta);
    imsize = size(im);
    size_x = imsize(1);
    size_y = imsize(2);
    rhomax = hypot(size_x, size_y);
    drho = 2*rhomax/(nrho-1);
    dtheta = pi/ntheta;
    for x=1:size_x
        for y=1:size_y
            if img(x, y) ~= 0
                for theta=0:dtheta:pi-dtheta
                    rho = x*sin(theta) + y*cos(theta);
                    rhoindex = round(rho/drho + nrho/2);
                    thetaindex = round(theta/dtheta + 1);
                    acc(rhoindex, thetaindex) = acc(rhoindex, thetaindex) + 1;
                end
            end
        end
    end
    h = acc;
end