% this is the directory containing the images
buildingDir = fullfile('C:','Users','tomma','Desktop','uni','Helsinki','corsi','computerVision','esercizi','5','panorama','img');
buildingScene = imageDatastore(buildingDir);
% Read the first image from the image set.
I = imresize(imrotate(readimage(buildingScene, 1),-90,'bilinear'),0.1);
% Initialize features for the first image
grayImage = rgb2gray(I);
points = detectSURFFeatures(grayImage);
[features, points] = extractFeatures(grayImage, points);
numImages = numel(buildingScene.Files);
% set a standard projective transformation for the first image
tforms(1) = projective2d(eye(3));

% Iterate over remaining image pairs
for i = 2:numImages
    % Store points and features for I(n-1).
    pointsPrevious = points;
    featuresPrevious = features;
    % Read I(n).
    I = imresize(imrotate(readimage(buildingScene, i),-90,'bilinear'),0.1);
    % Convert image to grayscale.
    grayImage = rgb2gray(I);    
    % Detect and extract SURF features for I(n).
    points = detectSURFFeatures(grayImage);    
    [features, points] = extractFeatures(grayImage, points);
    % Find correspondences between I(n) and I(n-1).
    indexPairs = matchFeatures(features, featuresPrevious);
    matchedPoints = points(indexPairs(:,1), :);
    matchedPointsPrev = pointsPrevious(indexPairs(:,2), :);        
    % Estimate the transformation between I(n) and I(n-1).
    tforms(i) = estimateGeometricTransform(matchedPoints, matchedPointsPrev,'projective');
    tforms(i).T = tforms(i).T * tforms(i-1).T;
end

% making the center image of the scene the least distorted
Tinv = invert(tforms(4));
for i = 1:size(tforms, 2)    
    tforms(i).T = tforms(i).T * Tinv.T;
end

% Prepare to warp the images
[w, h]     = deal(2000, 1300);  % Size of the mosaic
[x0, y0]   = deal(-700, -300);   % Upper-left corner of the mosaic
xLim = [0.5, w+0.5] + x0;
yLim = [0.5, h+0.5] + y0;
outputView = imref2d([h,w], xLim, yLim);
mosaic = ones(h, w, 3, 'uint8')*255;

% blender definition
halphablender = vision.AlphaBlender('Operation', 'Binary mask', 'MaskSource', 'Input port');

% Create the panorama.
for i = 1:numImages
    I = imresize(imrotate(readimage(buildingScene, i),-90,'bilinear'),0.1);
    % Transform I into the panorama.
    warpedImage = imwarp(I, tforms(i), 'OutputView', outputView);
    % Generate a binary mask.    
    mask = imwarp(true(size(I,1),size(I,2)), tforms(i), 'OutputView', outputView);
    % Overlay the warpedImage onto the panorama.
    mosaic = step(halphablender, mosaic, warpedImage, mask);
end

figure;
imshow(mosaic);

