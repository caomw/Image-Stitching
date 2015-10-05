function [compareX, compareY] = makeTestPattern(patchWidth, nbits)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    S = patchWidth;
    X = round(normrnd(S/2,S/5,[nbits,2]));
    Y = round(normrnd(S/2,S/5,[nbits,2]));
    X(X<1) = 1; X(X>S) = S;
    Y(Y<1) = 1; Y(Y>S) = S;
    compareX = sub2ind([S,S],X(:,1),X(:,2));
    compareY = sub2ind([S,S],Y(:,1),Y(:,2));
    
    save ./testPattern.mat compareX compareY    
end

