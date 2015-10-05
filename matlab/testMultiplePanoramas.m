%%testPanoramas
I0 = imread('./WF01.jpg');
I1 = imread('./WF02.jpg');
I2 = imread('./WF03.jpg');

Im12 = generatePanorama(I1,I2);
imshow(Im12);
result = generatePanorama(Im12,I0);
imshow(result);


