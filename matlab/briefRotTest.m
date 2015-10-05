%%briefRotTest.m
im = rgb2gray(im2double(imread('../data/model_chickenbroth.jpg')));
results = zeros(36,1);
parfor i = 1:36
    im2 = imrotate(im,10*(i-1));
    [locs1, desc1] = briefLite(im);
    [locs2, desc2] = briefLite(im2);
    [matches] = briefMatch(desc1, desc2);
    results(i) = size(matches,1);
    fprintf('done: %d/360\n',10*(i-1))
end
    bar(results);