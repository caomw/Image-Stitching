function [output] = ransacH(matches,locs1,locs2,n,threshld)
P1 = locs1(matches(:,1),1:2);
P2 = locs2(matches(:,2),1:2);
P1 = padarray(P1,[0,1],1,'post');
P2 = padarray(P2,[0,1],1,'post');
threshld = 0.08;
    [H_2, P2_inlier, P1_inlier] = compute_homography_RANSAC(P2,P1,300,threshld);
    while size(P2_inlier,1) < 4
        threshld = threshld+0.01;
        %disp('restart RANSAC')
        %threshld
        %pause(1);
        [H_2, P2_inlier, P1_inlier] = compute_homography_RANSAC(P2,P1,n,threshld);
    end
    output = H_2;
end


function [output, P1_inlier, P2_inlier] = compute_homography_RANSAC(P1,P2,n,thresh)

P1_inlier = []; P2_inlier = [];

 sum = 0; min_sum = Inf;
for i = 1:n
    if size(P1,1) > 4
        P1_inlier_ = []; P2_inlier_ = [];
        perm = randperm(size(P1,1)) ;
        sel = perm(1:4);
        H_hat = homography(P2(sel,:),P1(sel,:));
        P1_ = (H_hat * P1')';
        P2_ = P1_./[P1_(:,3) P1_(:,3) P1_(:,3);];
        P2_ = (inv(H_hat) * P2')';
        P1_ = P2_./[P2_(:,3) P2_(:,3) P2_(:,3);];
        d = ((P1(:,1) - P1_(:,1)).^2 + (P1(:,2) - P1_(:,2)).^2).^(1/2);
        counter = 1;sum = 0;
        for i = 1:size(d,1)
            if(d(i) < thresh)
%                             disp('accept!');
                sum = sum + d(i);
                P1_inlier_(counter,:) = P1(i,:);
                P2_inlier_(counter,:) = P2(i,:);
                counter = counter + 1;
            end
        end
        if size(P1_inlier_,1) > 32
            if sum < min_sum
%                 disp('new model!')
                min_sum = sum;
                P1_inlier = P1_inlier_;
                P2_inlier = P2_inlier_;
            end
        end
    end
end
    if isempty(P1_inlier) || isempty(P2_inlier)
        output = zeros(3,3);
    else
        output = computeH(P1_inlier(:,1:2)',P2_inlier(:,1:2)');
    end
end

function [ output_args ] = homography(xs2_, xs1_)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
xs2 = xs2_;
xs1 = xs1_;
A = zeros(8,9);
B = zeros(8,1);
for i = 1:4
    a = zeros(2,9);
    a(1,1:3) = [-xs1(i,1), -xs1(i,2), -1];
    a(1,7:9) = [xs1(i,1)*xs2(i,1), xs1(i,2)*xs2(i,1), xs2(i,1)];
    a(2,4:6) = [-xs1(i,1), -xs1(i,2), -1];
    a(2,7:9) = [xs1(i,1)*xs2(i,2), xs1(i,2)*xs2(i,2), xs2(i,2)];
    A(i*2 -1:i*2,:) = a;
    B(i*2-1 : i*2,:) = [-xs2(i,1);-xs2(i,2)];
end
A = A(:,1:8);
H_ = inv(A)*B;
output_args = zeros(3,3);
output_args = [H_(1), H_(2), H_(3);
    H_(4),H_(5),H_(6);
    H_(7),H_(8),1];

end
