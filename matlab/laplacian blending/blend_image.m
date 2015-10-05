function [blended_image] = blend_image(image1, image2,binary_mask_)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
level = 6;
sigma = 6;
hsize = 6;


pryamid_L = construct_pyramid(image1,level,hsize,sigma);
pryamid_R = construct_pyramid(image2,level,hsize,sigma);


% binary_mask_ = zeros(size(image1,1),size(image1,2)); 
% binary_mask_(:,1:size(binary_mask_,2)/2) = 1;


pryamid_O = cell(length(pryamid_L),1);

prymaid_mask = pyramid(binary_mask_,level,sigma,hsize);


for i = 1:level
    pryamid_O{i} = pryamid_L{i}.*prymaid_mask{i} + pryamid_R{i}.*(1- prymaid_mask{i});
end

blended_image = reconstruct_image(pryamid_O);

end

function [ output_args ] = pyramid( image, level, sigma,hsize )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% image = im2double(image);
h = fspecial('gaussian', hsize, sigma);
output_args =  cell(level, 1);
output_args{1} = image;
 for level_counter = 2:level
    image = conv2(image, h,'same');
    I = imresize(image, [floor((size(image,1)/2)) floor(size(image,2)/2)], 'bilinear');
    output_args{level_counter} = I;
    image = I;
end

end

