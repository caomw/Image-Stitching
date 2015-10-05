function [locs, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast,th_r)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
      GaussianPyramid = createGaussianPyramid(im, sigma0, k, levels);
      [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);
      PrincipalCurvature = computePrincipalCurvature(DoGPyramid);
      locs = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r);
end

