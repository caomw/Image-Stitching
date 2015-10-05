%%testPanoramas
im1_C = im2double(imread('../data/incline_L.png'));
im2_C = im2double(imread('../data/incline_R.png'));
im1 = rgb2gray(im2double(imread('../data/incline_L.png')));
im2 = rgb2gray(im2double(imread('../data/incline_R.png')));
[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
[matches] = briefMatch(desc1, desc2);
%plotMatches(im1, im2, matches, locs1, locs2);

%%RANSAC
[H] = ransacH(matches,locs1,locs2,300,0.08);

%% stitching  
result = imageStitching_noClip(im1_C, im2_C, H);

imshow(result);


