% function that corrects the radial distortion of the provided image
function newImg = correctDistorsion(img)
    % distorsion coefficients on the calibration file
    k = [ -0.159950393345315 -0.000685869015729 -0.004896132860374 ];
    imsize = size(img);
    %-- Focal length on the calibration file
    fc = [ 585.850107917267790 586.003198722303180 ];
    %-- Principal point on the calibration file
    cc = [ 664.903569991381570 498.409524449186850 ];
    % correcting radial distorsion with MATLAB function
    IntrinsicMatrix = [fc(1) 0 0; 0 fc(2) 0; cc(1) cc(2) 1];
    radialDistortion = k;
    cameraParams = cameraParameters('IntrinsicMatrix',IntrinsicMatrix,'ImageSize',[imsize(1) imsize(2)],'RadialDistortion',radialDistortion);
    newImg = undistortImage(img, cameraParams);
end

