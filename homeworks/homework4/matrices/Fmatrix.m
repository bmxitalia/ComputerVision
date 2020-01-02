% finding the 8 best correspondences between the two images
i1 = rgb2gray(imread('EFM1.jpg'));
i2 = rgb2gray(imread('EFM2.jpg'));
points1 = detectSURFFeatures(i1);
points2 = detectSURFFeatures(i2);
[f1, vpts1] = extractFeatures(i1, points1.selectStrongest(25));
[f2, vpts2] = extractFeatures(i2, points2.selectStrongest(25));
indexPairs = matchFeatures(f1, f2) ;
matchedPoints1 = vpts1(indexPairs(:, 1));
matchedPoints2 = vpts2(indexPairs(:, 2));

% normalization of the matched points so that their root-mean-squared
% distance is sqrt(2)
[s1,s2] = size(i1);
T = [2/s2 0 -1;
    0 2/s1 -1;
    0 0 1];
x1 = matchedPoints1.Location;
x2 = matchedPoints2.Location;
x1(:,3) = 1;
x2(:,3) = 1;
x1 = T*x1';
x2 = T*x2';

% building the constraint matrix
A = [x2(1,:)'.*x1(1,:)' x2(1,:)'.*x1(2,:)' x2(1,:)' ...
    x2(2,:)'.*x1(1,:)' x2(2,:)'.*x1(2,:)' x2(2,:)' ...
    x1(1,:)' x1(2,:)' ones(8,1) ];

[U,D,V] = svd(A);

% Extract fundamental matrix from the column of V
% corresponding to the smallest singular value.
F = reshape(V(:,9),3,3)';

% Enforce rank2 constraint - The constraint of the first two singular 
% values must be equal and the third one is zero has to be enforced.
[U,D,V] = svd(F);
F = U*diag([D(1,1) D(2,2) 0])*V';

% Denormalize the F matrix
F = T'*F*T;
F