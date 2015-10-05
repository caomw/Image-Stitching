function locs = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature,th_contrast, th_r)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

[ind] = find((abs(DoGPyramid)>th_contrast)&(PrincipalCurvature<th_r)&(PrincipalCurvature>0));
[y,x,z] = ind2sub(size(DoGPyramid),ind);
locs = zeros(size(y,1),3);
ind = 1;
for i = 1:size(locs,1)
    if z(i) == 1 || z(i) == size(DoGPyramid,3)
        continue;
    end
    if 1 < x(i) && x(i) < size(DoGPyramid,2) && 1 < y(i) && y(i) < size(DoGPyramid,1)
       max_extrame = imregionalmax(DoGPyramid(y(i)-1:y(i)+1,x(i)-1:x(i)+1,z(i)));
       min_extrame = imregionalmin(DoGPyramid(y(i)-1:y(i)+1,x(i)-1:x(i)+1,z(i)));
        if ( isequal(max_extrame,[0,0,0;0,1,0;0,0,0]) || isequal(min_extrame,[0,0,0;0,1,0;0,0,0])) && ...
                (DoGPyramid(y(i),x(i),z(i)) >= max(DoGPyramid(y(i),x(i),z(i)-1),DoGPyramid(y(i),x(i),z(i)+1)) ||...
                DoGPyramid(y(i),x(i),z(i)) <= min(DoGPyramid(y(i),x(i),z(i)-1),DoGPyramid(y(i),x(i),z(i)+1)))
            locs(ind,:) = [x(i),y(i),z(i)]; ind = ind + 1;
        end
    end
end
 locs = locs(1:ind,:);
end

