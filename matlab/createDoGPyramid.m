function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    tmp = GaussianPyramid; tmp(:,:,2:end) = GaussianPyramid(:,:,1:end-1);
    GaussianPyramid(:,:,1) = GaussianPyramid(:,:,1);
    DoGPyramid = GaussianPyramid - tmp;
    DoGPyramid = DoGPyramid(:,:,2:end);
    DoGLevels = levels(2:end);

end

