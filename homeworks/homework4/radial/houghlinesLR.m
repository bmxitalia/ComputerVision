function lines =  houghlinesLR (edges, cor_i)

tic
% Find edge coordinates, i.e. where the value is not zero in the binary
% image
[y,x] = find(edges);
[h,w] = size(edges);

% Max rho, image diagonal
rho_max = sqrt(h^2+w^2);

% Define accumulator resolution
theta_bins = 180;
rhos = -rho_max:rho_max;
thetas = linspace(-pi/2,pi/2,theta_bins); %theta_bins points, spacing pi/2+pi/2

% Initialize accumulator
H = zeros(theta_bins,length(rhos));

for p_ind = 1:length(y)
    for t_ind = 1:theta_bins
        theta = thetas(t_ind);
        rho = y(p_ind)*cos(theta) + x(p_ind)*sin(theta);
        rho = find(histcounts(rho,rhos));
        H(t_ind, rho) = H(t_ind, rho) + 1;
    end
end

% Find local maxima in the transform
xper = 10;
five_p = round(theta_bins/10);  % Looking at xper percent of maximum values
maxs = maxk(H(:),five_p);
mthetas = [];
mrhos = [];
for i = 1:five_p
  [t,r] = find(H==maxs(i));
  mthetas = [mthetas t'];
  mrhos = [mrhos r'];
end
P = [thetas(mthetas); rhos(mrhos)];


xs = 1:w/4;
figure; imshow(cor_i); hold on

for j = 1:length(P)
ys = (P(2,j)-xs*cos(P(1,j)))/sin(P(1,j));
% Rotating the lines, so that their origin is more in line with image
% origin (which is in top left)
lines_fp = [xs;ys];
lines_fp = [0 1; -1 0]*lines_fp;
plot(lines_fp(1,:),abs(lines_fp(2,:)))
lines(j).point1=[abs(lines_fp(:,1))];
lines(j).point2=[abs(lines_fp(:,end))];
end


toc
