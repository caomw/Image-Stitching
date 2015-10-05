function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
%UNTITLED Summary of this function goes here
%   A----B
%   |    |
%   C----D
    addpath('./laplacian blending/');
    safe_margin = 100;
    width = max(size(img1,2), size(img2,2))*1.5;
    new_corners = H2to1 * [0,0,1;size(img2,2),0,1;0,size(img2,1),1;size(img2,2),size(img2,1),1]';
    new_corners(1,:) = round(new_corners(1,:)./new_corners(3,:));
    new_corners(2,:) = round(new_corners(2,:)./new_corners(3,:));

    min_x = min([new_corners(1,:),0])-safe_margin;
    max_x = max([new_corners(1,:),size(img1,2)])+safe_margin;
    min_y = min([new_corners(2,:),0])-safe_margin;
    max_y = max([new_corners(2,:),size(img1,1)])+safe_margin;
    ratio = width/(max_x - min_x);
    height = round(ratio*(max_y -min_y));
    M = zeros(3,3);M(3,3) = 1;
    M(1,1) = ratio;M(2,2) = ratio;
    M(1,3) = -min_x*ratio;M(2,3)= -min_y*ratio;
    sz = [height,width];
    %%
    warped_img2 = warpH(img2, M*H2to1, sz,0);
    warped_img1 = warpH(img1, M*eye(3,3), sz,0);
    
    panoImg = laplician_blending(warped_img1,warped_img2);
    %%
   % panoImg = mask_blending(img1, img2, H2to1,M, sz);
end


function [blended] = mask_blending(A, B, H,M, sz)
maskA = ones(size(A,1), size(A,2));
mA = rgb2gray(A); mA(mA>0) = 1; maskA = maskA - mA;
if min(min(mA)) == 1
    maskA(1,:) = 1; maskA(end,:) = 1; maskA(:,1) = 1; maskA(:,end) = 1;
end
tmp = bwdist(maskA, 'city');
maskA = repmat(tmp/max(max(tmp)),[1,1,3]);
maskB = ones(size(B,1),size(B,2));
mB = rgb2gray(B); mB(mB>0) = 1; maskB = maskB - mB;
if min(min(mB)) == 1
    maskB(1,:) = 1; maskB(end,:) = 1; maskB(:,1) = 1; maskB(:,end) = 1;
end
tmp = bwdist(maskB, 'city');
maskB = repmat(tmp/max(max(tmp)),[1,1,3]);
warped_MaskB = warpH(maskB, M*H, sz,0);
warped_MaskA = warpH(maskA, M, sz,0);

B = warpH(B, M*H, sz,0);
A = warpH(A, M*eye(3,3), sz,0);
blended = (warped_MaskA.*A + warped_MaskB.*B)./(warped_MaskA + warped_MaskB+10^(-31));
end

