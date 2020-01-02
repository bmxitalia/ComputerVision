img = rgb2gray(imread('Corridor2.jpg'));
edges1 = edge(img,'canny');
imshow(edges1);
[x_max, y_max] = size(edges1);
rho_range = floor(hypot(x_max, y_max));
hough_space = zeros(rho_range, 181);
% compute hough transform
for x=1:x_max
    for y=1:y_max
        if edges1(x, y) ~= 0
            for theta=1:181
                rho = x*cosd(theta) + y*sind(theta);
                if abs(floor(rho)) ~= 0
                    hough_space(abs(floor(rho)), theta) = hough_space(abs(floor(rho)), theta) + 1;
                end
            end
        end
    end
end
% plot detected lines
imshow(img); hold on;
for rho=1:rho_range
    for theta=1:91
        % we can't plot all the lines because we want to see if they are
        % good
        if hough_space(rho, theta) > 75
            x = 1:1000;
            y = -x * (sind(theta)/cosd(theta)) + (rho/cosd(theta));
            plot(x, y);
        end
    end
end
% finding and computing all intersections of detected lines
pointsx = [];
pointsy = [];
incr = [];
cont = zeros(x_max, y_max);
for rho=1:rho_range
    for theta=1:91
        for rho2=1:rho_range
            for theta2=1:91
                if hough_space(rho, theta) > 75 && hough_space(rho2, theta2) > 75 && rho ~= rho2 && theta ~= theta2
                    x = 1:0.1:x_max;
                    y1 = -x * (sind(theta)/cosd(theta)) + (rho/cosd(theta));
                    y2 = -x * (sind(theta2)/cosd(theta2)) + (rho2/cosd(theta2));
                    x11 = 1;
                    x12 = 2;
                    x21 = 3;
                    x22 = 4;
                    y11 = -x11 * (sind(theta)/cosd(theta)) + (rho/cosd(theta));
                    y12 = -x12 * (sind(theta)/cosd(theta)) + (rho/cosd(theta));
                    y21 = -x21 * (sind(theta2)/cosd(theta2)) + (rho2/cosd(theta2));
                    y22 = -x22 * (sind(theta2)/cosd(theta2)) + (rho2/cosd(theta2));
                    point = linlinintersect([x11 y11; x12 y12; x21 y21; x22 y22]);
                    found = false;
                    [s1, s2] = size(pointsx);
                    for ix=1:s2
                        if floor(pointsx(ix)) == floor(point(1)) && floor(pointsy(ix)) == floor(point(2))
                            % number of straigh lines that intersect in the same point
                            incr(ix) = incr(ix) + 1;
                            found = true;
                        end
                    end
                    if found == false
                        pointsx(end+1) = point(1);
                        pointsy(end+1) = point(2);
                        incr(end+1) = 0;
                    end
                    % find coordinates of intersection points outside of
                    % the image
                    if abs(floor(point(1))) > x_max || abs(floor(point(2))) > y_max
                        disp(floor(point(1)));
                        disp(floor(point(2)));
                    end
                    plot(floor(point(1)), floor(point(2)), 'r*');
                end
            end
        end
    end
end

% finding coordinates of the vanishing points on the image
[s1, s2] = size(incr);
for i=1:s2
    % show only points with a minimum number of intersections
    if incr(i) > 54 % threshold to show only the desidered point
        plot(floor(pointsx(i)), floor(pointsy(i)), 'r*');
    end
end

% function that compute the intersection between two given lines
function point = linlinintersect(lines)
    % Input Check
    if size(lines,1) ~= 4 || size(lines,2) ~= 2, error('Input lines have to be specified with 2 points'), end
    
    x = lines(:,1);
    y = lines(:,2);
    % Calculation
    denominator = (x(1)-x(2))*(y(3)-y(4))-(y(1)-y(2))*(x(3)-x(4));
    point = [((x(1)*y(2)-y(1)*x(2))*(x(3)-x(4))-(x(1)-x(2))*(x(3)*y(4)-y(3)*x(4)))/denominator ...
        ,((x(1)*y(2)-y(1)*x(2))*(y(3)-y(4))-(y(1)-y(2))*(x(3)*y(4)-y(3)*x(4)))/denominator];
    
end

% heading1 = asin((141 - 664.903569991381570)/585.850107917267790);
% pitch1 = asin((134 - 498.409524449186850)/-586.003198722303180*cos(heading1));
% heading2 = asin((141 - 664.903569991381570)/585.850107917267790);
% pitch2 = asin((109 - 498.409524449186850)/-586.003198722303180*cos(heading2));
% 
% heading1
% heading2
% pitch1
% pitch2

% 111 870 first vanishing point and outside of the image
% 133 122 second vanishing point mean of similar points
% 157 634 first vanishing second image
% 126 124 second second image

%imshow(hough_space>75);
