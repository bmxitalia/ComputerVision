% reading images
img = rgb2gray(imread('Corridor1.jpg'));
h = hough(rgb2gray(imread('Corridor1.jpg')), 1, 300, 300);
imshow(h);
%{
edges1 = edge(img1,'canny');
%imshow(edges1);

% perform hough
imgsize = size(edges1);
x_max = imgsize(1);
y_max = imgsize(2);

theta_max = 181.0;
theta_min = 0.0;

roh_max = hypot(x_max, y_max);
roh_min = 0.0;

hough_space = zeros(330, 200);

for x=1:x_max
    for y=1:y_max
        if edges1(x, y) == 1
            for theta=1:theta_max
                roh = x * cos(deg2rad(theta - 1)) + y * sin(deg2rad(theta - 1));
                roh = round(roh);
                if roh > 0
                    hough_space(roh, theta) = hough_space(roh, theta) + 1;
                end
            end
        end
    end
end
%}
%{
imshow(img); hold on;
for r=1:300
    for t=1:300
        if h(r, t) > 160
            x = 1:400;
            y = -x * (cos(t)/sin(t)) + (r/sin(t));
            plot(x, y);
        end
    end
end
%}
function h = hough(im, thresh, nrho, ntheta)
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
