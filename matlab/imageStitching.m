function [panoImg] = imageStitching(img1, img2, H2to1)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    sz = max(size(img1), size(img2));
    warped_img2 = warpH(img2, H2to1, sz,0);
    warped_img1 = warpH(img1, eye(3,3), sz,0);
    panoImg = average_blending(warped_img1, warped_img2);  
end


function [blended] = average_blending(A, B)
blended = (A + B)/2;
blended((A == 0) | (B == 0)) = blended((A == 0) | (B == 0))*2;
end