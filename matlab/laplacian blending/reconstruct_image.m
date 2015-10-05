function [ output_args ] = reconstruct_image(pyramid)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    output_args = pyramid{length(pyramid)};
    h = fspecial('gaussian', 4, 4);
    level_counter = length(pyramid);
    for i = level_counter - 1 : -1 : 1
        image = pyramid{i};
        I = zeros((size(image,1)), size(image,2));
        I = imresize(output_args,[(size(image,1)) size(image,2)],'bilinear');
        I_blur = conv2(I,h,'same'); 
       output_args = image + I_blur;
    end
end

function [pixel] = interpolation(input, position)
        x = floor(position(1));
        y = floor(position(2));
        x_ = position(1);
        y_ = position(2);
        pixel = input(x,y)*( x+1 - x_)*(y+1 -y_) + input(x+1,y)*( x_ - x)*(y+1 -y_) + input(x,y+1)*( x+1 - x_)*(y_ - y) + input(x+1,y+1)*(x_ - x)*( y_ - y);
end
