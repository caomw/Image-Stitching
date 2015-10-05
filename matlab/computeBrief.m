function  [locs,desc] = computeBrief(im, locs, levels, compareX, compareY)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    patchWidth = 9;nbits = 256;
    border = size(im);
    tmp = locs(:,1); tmp(tmp<1 | tmp>(border(2) - patchWidth + 1)) = -1;
    locs(:,1) = tmp;
    tmp = locs(:,2); tmp(tmp<1 | tmp>(border(1) - patchWidth + 1)) = -1;
    locs(:,2) = tmp;
    ind = find(locs(:,1) == -1 | locs(:,2) == -1);
    locs(ind,:) = [];
    desc = zeros(size(locs,1),nbits);
    
    for i = 1:size(locs,1)
        row = locs(i,2);col = locs(i,1);
        patch = reshape(im(row:row+patchWidth-1,col:col+patchWidth-1),[],1);
        desc(i,:) = (patch(compareX) > patch(compareY))';
    end
    


end

