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

% form the K matrix to normalize points
K = [719.302047058490760 0 334.631234942930060;
    0 718.392548175289110 256.166677783686790;
    0 0 1];

% the inverse of the K matrix has to be used to normalize the points
invK = inv(K); 

% points normalization with K matrix
x1 = matchedPoints1.Location;
x2 = matchedPoints2.Location;
x1(:,3) = 1;
x2(:,3) = 1;
x1 = invK*x1';
x2 = invK*x2';

% building the constraint matrix
A = [x2(1,:)'.*x1(1,:)' x2(1,:)'.*x1(2,:)' x2(1,:)' ...
    x2(2,:)'.*x1(1,:)' x2(2,:)'.*x1(2,:)' x2(2,:)' ...
    x1(1,:)' x1(2,:)' ones(8,1) ];

[U,D,V] = svd(A);

% Extract fundamental matrix from the column of V
% corresponding to the smallest singular value.
E = reshape(V(:,9),3,3)';

% Enforce rank2 constraint - The constraint of the first two singular 
% values must be equal and the third one is zero has to be enforced.
[U,D,V] = svd(E);
E = U*diag([D(1,1) D(2,2) 0])*V';
E


