clc;clear;
load ./parameters.mat;
im = rgb2gray(im2double(imread('../data/model_chickenbroth.jpg')));
[locs, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, thetaC,thetaR);
patchWidth = 9; nbits = 256;
[compareX, compareY] = makeTestPattern(patchWidth, nbits);
[locs,desc] = computeBrief(im, locs, levels, compareX, compareY);
