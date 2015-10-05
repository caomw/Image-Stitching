
function [ output_args ] = construct_pyramid(image, levels, hsize, sigma)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
h = fspecial('gaussian', hsize, sigma);
output_args =  cell(levels, 1);
 for level_counter = 1:levels-1
    image_blur = conv2(image, h,'same');
    I = imresize(image_blur,[floor((size(image,1)/2)) floor(size(image,2)/2)] ,'bilinear');
    
    %upsample:
    U = zeros(floor((size(image,1))), floor(size(image,2)));
    U = imresize(I,[floor((size(image,1))) floor(size(image,2))],'bilinear');
    U_blur = conv2(U,h,'same');
   %difference
    output_args{level_counter} = image - U_blur;
    image = I;
 end
    output_args{levels} = image;


end

