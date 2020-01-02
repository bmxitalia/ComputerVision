% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 585.850107917267790 ; 586.003198722303180 ];

%-- Principal point:
cc = [ 664.903569991381570 ; 498.409524449186850 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.159950393345315 ; 0.000000000000000 ; -0.000685869015729 ; -0.004896132860374 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 8.710017825595292 ; 8.939613454740497 ];

%-- Principal point uncertainty:
cc_error = [ 5.809944557431711 ; 7.463027311611222 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.005683206262503 ; 0.000000000000000 ; 0.002055303935265 ; 0.001210028314335 ; 0.000000000000000 ];

%-- Image size:
nx = 1280;
ny = 960;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 14;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 0 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 1.948720e+00 ; 1.734774e+00 ; -7.312483e-01 ];
Tc_1  = [ -4.111777e+01 ; 2.856973e+01 ; 3.730695e+02 ];
omc_error_1 = [ 1.860907e-02 ; 1.346996e-02 ; 2.566050e-02 ];
Tc_error_1  = [ 3.648280e+00 ; 4.909893e+00 ; 5.330259e+00 ];

%-- Image #2:
omc_2 = [ 2.192334e+00 ; 2.228948e+00 ; -9.803712e-02 ];
Tc_2  = [ -1.012203e+02 ; -7.236369e+01 ; 3.757402e+02 ];
omc_error_2 = [ 2.318373e-02 ; 2.073037e-02 ; 4.608548e-02 ];
Tc_error_2  = [ 3.788215e+00 ; 4.845134e+00 ; 7.613886e+00 ];

%-- Image #3:
omc_3 = [ -1.969224e+00 ; -1.898970e+00 ; 5.316389e-01 ];
Tc_3  = [ -4.397710e+01 ; -5.106409e+01 ; 4.372313e+02 ];
omc_error_3 = [ 1.600213e-02 ; 2.026732e-02 ; 3.544043e-02 ];
Tc_error_3  = [ 4.523393e+00 ; 5.450090e+00 ; 6.425467e+00 ];

%-- Image #4:
omc_4 = [ -2.138098e+00 ; -2.208260e+00 ; 6.679968e-02 ];
Tc_4  = [ -1.051026e+02 ; -7.467864e+01 ; 2.288933e+02 ];
omc_error_4 = [ 9.161117e-03 ; 1.103050e-02 ; 2.063895e-02 ];
Tc_error_4  = [ 2.305705e+00 ; 2.993409e+00 ; 4.010838e+00 ];

%-- Image #5:
omc_5 = [ 2.185272e+00 ; 2.208435e+00 ; -8.670933e-02 ];
Tc_5  = [ -1.199799e+02 ; 1.087926e+01 ; 3.551420e+02 ];
omc_error_5 = [ 2.114055e-02 ; 1.631258e-02 ; 3.840224e-02 ];
Tc_error_5  = [ 3.623727e+00 ; 4.712368e+00 ; 7.005938e+00 ];

%-- Image #6:
omc_6 = [ -1.876948e+00 ; -1.860185e+00 ; -6.403422e-01 ];
Tc_6  = [ -1.398462e+02 ; -9.852354e+01 ; 2.608548e+02 ];
omc_error_6 = [ 1.358153e-02 ; 1.393206e-02 ; 2.360289e-02 ];
Tc_error_6  = [ 2.807452e+00 ; 3.672910e+00 ; 5.429992e+00 ];

%-- Image #7:
omc_7 = [ 1.748922e+00 ; 2.075901e+00 ; 7.593696e-01 ];
Tc_7  = [ -1.142473e+02 ; -1.061052e+02 ; 2.301220e+02 ];
omc_error_7 = [ 1.268242e-02 ; 1.366871e-02 ; 2.551346e-02 ];
Tc_error_7  = [ 2.855630e+00 ; 3.204996e+00 ; 5.277108e+00 ];

%-- Image #8:
omc_8 = [ 2.027029e+00 ; 1.940103e+00 ; 4.085146e-01 ];
Tc_8  = [ -8.252014e+01 ; -7.097811e+01 ; 2.619068e+02 ];
omc_error_8 = [ 1.415234e-02 ; 1.149910e-02 ; 2.483267e-02 ];
Tc_error_8  = [ 2.891911e+00 ; 3.456301e+00 ; 5.482608e+00 ];

%-- Image #9:
omc_9 = [ 1.934386e+00 ; 2.009448e+00 ; 3.962523e-01 ];
Tc_9  = [ -5.073964e+01 ; -8.468756e+01 ; 2.217916e+02 ];
omc_error_9 = [ 1.254191e-02 ; 9.654413e-03 ; 2.027194e-02 ];
Tc_error_9  = [ 2.406195e+00 ; 2.892179e+00 ; 4.474065e+00 ];

%-- Image #10:
omc_10 = [ 1.904972e+00 ; 1.886187e+00 ; -5.349879e-01 ];
Tc_10  = [ -9.897019e+01 ; -1.743394e+01 ; 3.055541e+02 ];
omc_error_10 = [ 1.401635e-02 ; 1.239879e-02 ; 2.160791e-02 ];
Tc_error_10  = [ 2.884596e+00 ; 3.962463e+00 ; 4.707332e+00 ];

%-- Image #11:
omc_11 = [ 1.863954e+00 ; 1.824946e+00 ; -5.860482e-01 ];
Tc_11  = [ -1.216810e+02 ; -1.096294e+02 ; 2.106130e+02 ];
omc_error_11 = [ 9.056124e-03 ; 1.024135e-02 ; 1.345441e-02 ];
Tc_error_11  = [ 1.977966e+00 ; 2.664789e+00 ; 3.138793e+00 ];

%-- Image #12:
omc_12 = [ -2.207390e+00 ; -2.231516e+00 ; -5.215396e-02 ];
Tc_12  = [ -1.065682e+02 ; -6.752053e+01 ; 3.325670e+02 ];
omc_error_12 = [ 1.700445e-02 ; 1.944416e-02 ; 3.874714e-02 ];
Tc_error_12  = [ 3.451388e+00 ; 4.379119e+00 ; 6.708630e+00 ];

%-- Image #13:
omc_13 = [ -2.108843e+00 ; -2.124261e+00 ; 1.731922e-01 ];
Tc_13  = [ -1.400201e+02 ; -9.297711e+01 ; 2.864966e+02 ];
omc_error_13 = [ 1.210846e-02 ; 1.219192e-02 ; 2.442164e-02 ];
Tc_error_13  = [ 2.771736e+00 ; 3.701584e+00 ; 4.898322e+00 ];

%-- Image #14:
omc_14 = [ -2.204284e+00 ; -1.954050e+00 ; 3.754358e-01 ];
Tc_14  = [ -1.191978e+02 ; 5.401369e+01 ; 4.389046e+02 ];
omc_error_14 = [ 1.607911e-02 ; 2.152511e-02 ; 3.758013e-02 ];
Tc_error_14  = [ 4.288471e+00 ; 5.711067e+00 ; 7.296132e+00 ];

