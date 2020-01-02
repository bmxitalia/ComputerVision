%{
img = imread('brick_wall.tiff');
filteredImg1 = imboxfilt(img, 5);
%imshowpair(img,filteredImg1,'montage'); % the more you increase the box size the more the image is blurred

filteredImg2 = imgaussfilt(img,1); % the more you increase the dev std the more the image is blurred -> possibile controllare la sofcatura attraverso al standard deviation senza dover costruire un filtro di grandi dimensioni
%imshowpair(img,filteredImg2,'montage')

canny1 = edge(filteredImg1, 'canny');
canny2 = edge(filteredImg2, 'canny');
imshowpair(canny1,canny2,'montage'); % it depends on the values of the parameters of these filters but usually the gaussian is better than the box one. It seems that edges are better detected -> mostrare esempio con osservazioni su punti specifici dell'immagine

gopro1 = rgb2gray(imread('GOPR1515 03850.jpg'));
gopro2 = rgb2gray(imread('GOPR1515 03852.jpg'));
points1 = detectSURFFeatures(gopro1);
points2 = detectSURFFeatures(gopro2);
[f1,vpts1] = extractFeatures(gopro1,points1);
[f2,vpts2] = extractFeatures(gopro2,points2);
%{
subplot(1,2,1);
imshow(gopro1); hold on;
plot(vpts1.selectStrongest(20));
subplot(1,2,2);
imshow(gopro2); hold on;
plot(vpts2.selectStrongest(20));

%}
min = -100000;
dist = 0;
minv = [];
couples = [];
couples2 = [];


% funzione normale
for i=1:size(vpts1)
    min = 100000;
    mini = -1;
    minj = -1;
    for j=1:size(vpts2)
        dist = norm(vpts1(i).Location - vpts2(j).Location, 2);
        if dist < min
            min = dist;
            mini = i;
            minj = j;
        end
    end
    couples(i, 1) = mini;
    couples(i, 2) = minj;
end

% in my algorithm there are outliers that aren't present in the MATLAB
% feature matching. It is possible to obtain better results using the
% better approach

matchedPoints1 = vpts1(couples(1:20, 1));
matchedPoints2 = vpts2(couples(1:20, 2));
figure; ax = axes;
showMatchedFeatures(gopro1,gopro2,matchedPoints1,matchedPoints2,'montage','Parent',ax);
title(ax, 'Candidate point matches - My algorithm');
legend(ax, 'Matched points 1','Matched points 2');

indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(1:20,1));
matchedPoints2 = vpts2(indexPairs(1:20,2));
figure; ax = axes;
showMatchedFeatures(gopro1,gopro2,matchedPoints1,matchedPoints2,'montage','Parent',ax);
title(ax, 'Candidate point matches - MATLAB algorithm');
legend(ax, 'Matched points 1','Matched points 2');

%}
% trasformata di Fourier
last = imread('son3.gif');
last = imrotate(last, 120);
res = fft2(last);
res = fftshift(res);
res = abs(res);
logMagnitude = log(res);
thresholdMagnitude = res > 9000;
%imshow(thresholdMagnitude,[])
%imshow(logMagnitude, []);
imshowpair(logMagnitude,thresholdMagnitude,'montage');

