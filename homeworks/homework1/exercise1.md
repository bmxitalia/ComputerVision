**Exercise set:** 1 **Student:** Tommaso Carraro **Student number:** 015147592

#Exercise set 1 Computer Vision

## Exercise 1.1 (a, b, c)

I will reply to this answer considering 2D 3x3 matrix transformations.

**Translation**

$$\begin{bmatrix}
1 & 0 & tx \\
0 & 1 & ty \\
0 & 0 & 1 
\end{bmatrix}$$

The translation matrix has 2 degrees of freedom. $$tx$$ specifies the displacement along the $$x$$ axis and $$ty$$ specifies the displacement along the $$y$$ axis.

**Euclidean**

$$\begin{bmatrix}
cos(\theta) & sin(\theta) & tx \\
-sin(\theta) & cos(\theta) & ty \\
0 & 0 & 1 
\end{bmatrix}$$

The Euclidean matrix has 3 degrees of freedom. $$\theta$$ specifies the angle of rotation about the origin, $$tx$$ specifies the displacement along the $$x$$ axis and $$ty$$ specifies the displacement along the $$y$$ axis.

**Similarity**

$$\begin{bmatrix}
s*cos(\theta) & s*sin(\theta) & tx \\
s*-sin(\theta) & s*cos(\theta) & ty \\
0 & 0 & 1 
\end{bmatrix}$$

The similarity matrix has 4 degrees of freedom. $$\theta$$ specifies the angle of rotation about the origin, $$tx$$ specifies the displacement along the $$x$$ axis, $$ty$$ specifies the displacement along the $$y$$ axis and $$s$$ specifies the scale factor.

**Affine**

$$\begin{bmatrix}
a & b & c \\
d & e & f \\
0 & 0 & 1 
\end{bmatrix}$$

The affine matrix has 4 degrees of freedom for linear transformations and translations.

**Projective**

$$\begin{bmatrix}
a & b & c \\
d & e & f \\
g & h & i 
\end{bmatrix}$$

The projective matrix has 8 degrees of freedom. The number of degrees of freedom in a projective transformation is less than the number of elements in a 3×3 matrix because the vectors are defined up to scale. This means that we loose the information about the scale of the objects.

## Exercise 1.1 (d)

$$l1 = [a1,b1,c1] $$ and $$l2 = [a2,b2,c2]$$ are the two lines we have to find the intersection point $$x$$. If $$x$$ is $$\perp$$ to both $$l1$$ and $$l2 \implies x = l1 \times l2 \implies x = (b1c1-b2c1;a2c1-a1c2;a1b2-a2b1)$$.

From this formula of the cross product we can find that:

a) $$x = [1,-4,1]$$;

b) $$x = [0,2,0]$$, since the lines of the second question are parallel, their intersection point is at the infinity.

## Exercise 1.2

1. The size of the image is 720x1280 and the image is presented like a 3D matrix. Each of the three 2D matrices contain the intensity values of the RGB. The first matrix contains 720x1280 intensity values for the red, the second 720x1280 intensity values for the green and the last one 720x1280 intensity values for the blue. If we show these matrices in MATLAB it is possible to see these specific intensity values for each of the three matrices.
2. The calibration matrix K of the provided image is $$\begin{bmatrix}
   4,1685 \times 10^5 & 0 & 4,6500 \times 10^5 \\
   0 & 7,4925 \times 10^5 & 4,6934 \times 10^5 \\
   0 & 0 & 1 
   \end{bmatrix}$$ and is has been obtained through the formula presented at the slide 45.

## Exercise 1.3

To do this exercise I used the parameters of the K matrix computed in the previous exercise, the rotation matrix at slide 43 and the P matrix formulation at slide 41. These are the image coordinates requested:

a) $$(4.6500 \times 10^5, 4.6934 \times 10^5)$$

b) $$(4.6500 \times 10^5, 4.6934 \times 10^5)$$

c) $$(4.8171 \times 10^5, 6.5952 \times 10^5)$$

d) $$(2.0159 \times 10^6, 6.5952 \times 10^5)$$

In the first two cases, since we loose the information about the scale, the two 2D points (a, b) are the same, even if the respective 3D points are at different distances from the camera (3 and 5 meters).

In the last two cases the camera is at the same point and has the same direction. The unique parameter that changes it is the horizontal translation of the 3D object respect to the camera. Since in d) there is a bigger translation to the right (15 meters against 0.5 meters), the point d) has a bigger x-coordinate than the point c).

## Question 1.4

We begin with the computation of the eigenvalues of the matrix $A*A^{T}$.

$$A*A^{T} = \begin{bmatrix} 26 & 35 & 0 \\
35 & 50 & 12 \\
0 & 12 & 145 \end{bmatrix} = W$$

$$\begin{bmatrix} 26-\lambda & 35 & 0 \\
35 & 50-\lambda & 12 \\
0 & 12 & 145-\lambda \end{bmatrix}*x=(W - \lambda*I)*x=0$$

From $$|W-\lambda*I|=0$$ we obtain the eigenvalues of $A*A^{T}$, that are the following: $\lambda1 = 0.66, \lambda2=73.68$ and $\lambda3=146.66$.

With these three eigenvalues we can compute the eigenvectors that can be placed in the rows of U.

With $\lambda1$ we obtain this system of equations:

$$\begin{cases}25.34x1 + 35x2 = 0 \\
35x1 + 49.34x2 + 12x3 = 0 \\
12x2 + 144.34x3 = 0\end{cases}$$

I'm not able to continue the computation because I can't find a tutorial on what to do from this point. In fact, in the second link they just said that $x1$ and $x2$ have been chosen in such a way that the values in the S matrix can be the square roots of the eigenvalues, but as you can see from this system the simplest solution is to put both $x1$ and $x2$ to 0, but in this way we can't put the square roots of the eigenvalues on the S matrix. So, the question is: how can I choose these values in such a way that I can put the square roots of the eigenvalues in S?

We the same procedure used to find the eigenvector associated to $\lambda1$ it is possible to find also the other two eigenvectors. In this way is possible to complete the U matrix.

For the computation of the V matrix is possible to use the same procedure used for the U matrix but on the $A^{T}*A$ matrix.

Finally it is possible to build the S matrix that has in the diagonal the square roots of the eigenvalues:

$S = $$ \begin{bmatrix} 0.81 & 0 & 0 \\\
0 & 8.58 & 0 \\\
0 & 0 & 12.11 
\end{bmatrix}$.





