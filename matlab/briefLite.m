function   [locs, desc] = briefLite(im)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    load('./parameters.mat');
    [locs, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, thetaC,thetaR-4);
%     patchWidth = 9; nbits = 256;
%     %[compareX, compareY] = makeTestPattern(patchWidth, nbits);
    load('./testPattern.mat');
    [locs,desc] = computeBrief(im, locs, levels, compareX, compareY);
end

