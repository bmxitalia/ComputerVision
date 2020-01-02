**Exercise set:** 2 **Student:** Tommaso Carraro **Student number:** 015147592

# Exercise set 2 Computer Vision

## Question 2.1.1

In the following images I show the result of the application of a 5x5 and 21x21 box filters on the image provided. On the left it is possible to see the original image and on the right the filtered image.

![](C:\Users\tomma\Desktop\uni\Helsinki\corsi\computerVision\esercizi\2\5x5.png)

![](C:\Users\tomma\Desktop\uni\Helsinki\corsi\computerVision\esercizi\2\21x21.png)

As you can see from these two images with we increase of the size of the box filter the image becomes more blurry.

## Question 2.1.2

In the following images I show the result of the application of a gaussian filter with different values of standard deviation (2, 4 and 6) on the image provided. On the left it is possible to see the original image and on the right the filtered image.

![](C:\Users\tomma\Desktop\uni\Helsinki\corsi\computerVision\esercizi\2\std2.png)

![](C:\Users\tomma\Desktop\uni\Helsinki\corsi\computerVision\esercizi\2\std4.png)

![](C:\Users\tomma\Desktop\uni\Helsinki\corsi\computerVision\esercizi\2\std6.png)

As you can see from these images with the increase of the standard deviation the image becomes more blurry. It is interesting that with this filter we don't need to change its size to get an effect similar to the previous one, in fact we need only to change its standard deviation.

## Question 2.1.3

In the following image it is possible to see the edges detected by the Matlab's Canny edge detector for two filtered image with the following parameters:

1. 5x5 box filter on the left;
2. gaussian filter with standard deviation of 1 on the right.

I've chosen these parameters to obtain comparable results.

![](C:\Users\tomma\Desktop\uni\Helsinki\corsi\computerVision\esercizi\2\5x5_against_std1.png)

As you can see from the image the gaussian filter works better respect to the box filter with the chosen parameters. I say it works better because it is possible to recognize all the bricks in the image and the edges are smoother. It is possible to obtain similar results trying different combinations of the parameters but the gaussian filter is usually better than the box filter, in fact it allows to recognize more shapes after filtering operations.

## Question 2.2.1

In the following image I show the 20 best SURF features detected by Matlab in the two images provided.

<img src="C:\Users\tomma\Desktop\uni\Helsinki\corsi\computerVision\esercizi\2\featuresDetected.png" />

## Question 2.2.2

The following code presents my Matlab matching algorithm.

```matlab
min = -100000;
dist = 0;
couples = []; % contains pairs of matched points

for i=1:size(vpts1) % iterate over all the features of the first image
    min = 100000;
    mini = -1;
    minj = -1;
    for j=1:size(vpts2) % iterate over all the features of the second image
        dist = norm(vpts1(i).Location - vpts2(j).Location, 2);
        if dist < min % find the best match
            min = dist;
            mini = i;
            minj = j;
        end
    end
    % insert best match inside the couples array
    couples(i, 1) = mini;
    couples(i, 2) = minj;
end
```
In the following images I show the results of my algorithm (top one) and the Matlab algorithm (bottom one) on the images provided.

![](C:\Users\tomma\Desktop\uni\Helsinki\corsi\computerVision\esercizi\2\myMatched.png)

![](C:\Users\tomma\Desktop\uni\Helsinki\corsi\computerVision\esercizi\2\MATLABmatched.png)

I've shown only the first 20 points to be able to compare the two results. It is possible to see that the results are similar so I can say that my algorithm works well. However, if we increase the number of shown points it is possible to see that the Matlab algorithm works a little bit better. It is possible to obtain better results using the ratio distance threshold explained during the last lecture.

## Question 2.3.1 and 2.3.2

After performing the Fourier transformation of the provided image we obtain the following results:

1. logarithm of the magnitude on the left;
2. thresholded magnitude on the right.

![](C:\Users\tomma\Desktop\uni\Helsinki\corsi\computerVision\esercizi\2\fourier1.png)

From these results it is possible to know that the text is written horizontally and that in the text there are three main parts.

## Question 2.3.3

In the following images it is possible to see the results of the application of the Fourier transformation on the provided image after it has been rotated 4 times (30°, 60°, 90° and 120°).

![](C:\Users\tomma\Desktop\uni\Helsinki\corsi\computerVision\esercizi\2\30.png)

![](C:\Users\tomma\Desktop\uni\Helsinki\corsi\computerVision\esercizi\2\60.png)

![](C:\Users\tomma\Desktop\uni\Helsinki\corsi\computerVision\esercizi\2\90.png)

![](C:\Users\tomma\Desktop\uni\Helsinki\corsi\computerVision\esercizi\2\120.png)

As you can see the Fourier transformation help us understanding the orientation of an image. This could be useful to be sure that the text is correctly oriented before applying deep learning algorithm on top of it. It is possible to see these effects after the application of the Fourier transformation because it represents the image in the frequency domain, where each point represents a particular frequency contained in the spatial domain image. Because the image in the Fourier domain is decomposed into its sinusoidal components, it is easy to examine or process certain frequencies of the image, thus influencing the geometric structure in the spatial domain.