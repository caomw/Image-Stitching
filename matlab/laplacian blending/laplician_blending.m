function [blended_image] = laplician_blending(IM_left,IM)

        IM_left_mask = rgb2gray(IM_left);
        IM_left_mask(IM_left_mask < 0.3) = 0;   
        IM_left_mask(IM_left_mask >= 0.3) = 1;   
        
        IM_mask = rgb2gray(IM);
        IM_mask(IM_mask > 10^(-12)) = 1;    
        
        IM_mask_inv = ones(size(IM_mask)) - IM_mask;
        
        intersect = IM_mask_inv.*IM_left_mask;
        
        blend_mask = intersect;
        
        h = fspecial('disk', 51);        
        blend_mask_ = conv2(blend_mask,h,'same');
%         blend_mask = blend_mask_ .* IM_left_mask;
        blend_mask_(blend_mask_ > 0.01) = 1;
        blend_mask_(blend_mask_ <= 0.01) = 0;

%        tmp = bwdist(blend_mask,'city');
%        blend_mask_ = 1 - tmp/max(max(tmp));
%        
%        blend_mask_(blend_mask_ > 0.95) = 1;
%        blend_mask_(blend_mask_ <= 0.98) = 0;
        disp('start laplican blending!')
        for channel = 1:3
         [blended_image(:,:,channel)] = blend_image(IM_left(:,:,channel),IM(:,:,channel),blend_mask_);
        end
        
end