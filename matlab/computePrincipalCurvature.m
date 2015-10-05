function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    [dx,dy] = gradient(DoGPyramid);
    [dxx,dxy] = gradient(dx);
    [dyx,dyy] = gradient(dy);
     R = (dxx+dyy).^2./(dxx.*dyy - dxy.*dyx);    
     PrincipalCurvature = R;
end

