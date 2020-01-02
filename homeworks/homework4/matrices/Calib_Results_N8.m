% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 719.302047058490760 ; 718.392548175289110 ];

%-- Principal point:
cc = [ 334.631234942930060 ; 256.166677783686790 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.166329582926249 ; -0.520179332215331 ; 0.000740948247014 ; -0.002307272386086 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 21.589238769417289 ; 20.815686366812162 ];

%-- Principal point uncertainty:
cc_error = [ 4.538120743575024 ; 9.598915760688465 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.028190787769788 ; 0.154098055417021 ; 0.003003250194962 ; 0.002928913420256 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 12;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 2.173037e+000 ; 2.098575e+000 ; -1.991232e-001 ];
Tc_1  = [ -9.486944e+001 ; -1.421840e+002 ; 5.359001e+002 ];
omc_error_1 = [ 6.773368e-003 ; 6.852066e-003 ; 1.398516e-002 ];
Tc_error_1  = [ 3.403464e+000 ; 6.953203e+000 ; 1.592529e+001 ];

%-- Image #2:
omc_2 = [ -2.213129e+000 ; -2.169738e+000 ; 3.381042e-001 ];
Tc_2  = [ -5.364079e+001 ; -1.109010e+002 ; 5.090327e+002 ];
omc_error_2 = [ 6.225404e-003 ; 6.636086e-003 ; 1.700760e-002 ];
Tc_error_2  = [ 3.203907e+000 ; 6.624239e+000 ; 1.511931e+001 ];

%-- Image #3:
omc_3 = [ 2.226995e+000 ; 2.206710e+000 ; -1.592328e-001 ];
Tc_3  = [ -7.578621e+001 ; -1.246597e+002 ; 4.712375e+002 ];
omc_error_3 = [ 6.313123e-003 ; 6.100579e-003 ; 1.385100e-002 ];
Tc_error_3  = [ 2.989413e+000 ; 6.166744e+000 ; 1.394452e+001 ];

%-- Image #4:
omc_4 = [ 2.075893e+000 ; 2.014759e+000 ; -3.240172e-001 ];
Tc_4  = [ -8.092083e+001 ; -1.284080e+002 ; 4.918152e+002 ];
omc_error_4 = [ 7.387942e-003 ; 7.347189e-003 ; 1.292125e-002 ];
Tc_error_4  = [ 3.113487e+000 ; 6.394162e+000 ; 1.442401e+001 ];

%-- Image #5:
omc_5 = [ 2.104981e+000 ; 2.045889e+000 ; -2.788024e-001 ];
Tc_5  = [ -8.096211e+001 ; -1.405300e+002 ; 5.028785e+002 ];
omc_error_5 = [ 7.074154e-003 ; 7.080517e-003 ; 1.300654e-002 ];
Tc_error_5  = [ 3.195070e+000 ; 6.512141e+000 ; 1.487508e+001 ];

%-- Image #6:
omc_6 = [ 2.179591e+000 ; 2.152467e+000 ; -3.276706e-001 ];
Tc_6  = [ -7.784898e+001 ; -1.355454e+002 ; 4.649482e+002 ];
omc_error_6 = [ 5.738276e-003 ; 6.478601e-003 ; 1.443124e-002 ];
Tc_error_6  = [ 2.947105e+000 ; 6.017985e+000 ; 1.378353e+001 ];

%-- Image #7:
omc_7 = [ 2.054052e+000 ; 2.051801e+000 ; 7.388970e-002 ];
Tc_7  = [ -1.117785e+001 ; -1.459133e+002 ; 4.995775e+002 ];
omc_error_7 = [ 9.616326e-003 ; 6.702706e-003 ; 1.212572e-002 ];
Tc_error_7  = [ 3.209782e+000 ; 6.526329e+000 ; 1.504867e+001 ];

%-- Image #8:
omc_8 = [ 2.066007e+000 ; 2.066587e+000 ; -4.500774e-002 ];
Tc_8  = [ 3.869969e+000 ; -1.213549e+002 ; 5.411775e+002 ];
omc_error_8 = [ 9.134214e-003 ; 6.706770e-003 ; 1.309507e-002 ];
Tc_error_8  = [ 3.451973e+000 ; 7.073412e+000 ; 1.628137e+001 ];

%-- Image #9:
omc_9 = [ 2.173434e+000 ; 2.095850e+000 ; -1.357913e-001 ];
Tc_9  = [ -2.970514e+001 ; -1.504335e+002 ; 5.516901e+002 ];
omc_error_9 = [ 7.956076e-003 ; 6.898014e-003 ; 1.394478e-002 ];
Tc_error_9  = [ 3.531572e+000 ; 7.177952e+000 ; 1.641008e+001 ];

%-- Image #10:
omc_10 = [ 2.176549e+000 ; 2.104754e+000 ; -1.444661e-001 ];
Tc_10  = [ -5.725584e+001 ; -1.582773e+002 ; 5.479703e+002 ];
omc_error_10 = [ 7.427028e-003 ; 6.951185e-003 ; 1.394293e-002 ];
Tc_error_10  = [ 3.504801e+000 ; 7.117310e+000 ; 1.626749e+001 ];

%-- Image #11:
omc_11 = [ 2.052540e+000 ; 1.999283e+000 ; -3.496546e-001 ];
Tc_11  = [ -7.349530e+001 ; -1.333612e+002 ; 5.534165e+002 ];
omc_error_11 = [ 7.682189e-003 ; 7.667710e-003 ; 1.330067e-002 ];
Tc_error_11  = [ 3.505304e+000 ; 7.210015e+000 ; 1.618147e+001 ];

%-- Image #12:
omc_12 = [ 1.930088e+000 ; 1.916900e+000 ; -4.722799e-001 ];
Tc_12  = [ -9.162239e+001 ; -1.414519e+002 ; 6.136338e+002 ];
omc_error_12 = [ 8.359634e-003 ; 8.549302e-003 ; 1.332471e-002 ];
Tc_error_12  = [ 3.889940e+000 ; 8.071268e+000 ; 1.744584e+001 ];

