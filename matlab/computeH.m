function [H2to1] =computeH(P1,P2)

xs2 = P2';
xs1 = P1';

xs2 = padarray(xs2,[0,1],1,'post');
xs1 = padarray(xs1,[0,1],1,'post');

length_m = size(xs1,1);
A = zeros(length_m*2,9);
B = zeros(length_m*2,1);
for i = 1:length_m
    a = zeros(2,9);
    a(1,1:3) = [-xs1(i,1), -xs1(i,2), -xs1(i,3)];
    a(1,7:9) = [xs1(i,1)*xs2(i,1), xs1(i,2)*xs2(i,1), xs2(i,1)];
    a(2,4:6) = [-xs1(i,1), -xs1(i,2), -xs1(i,3)];
    a(2,7:9) = [xs1(i,1)*xs2(i,2), xs1(i,2)*xs2(i,2), xs2(i,2)];
    A(i*2 -1:i*2,:) = a;
    B(i*2-1 : i*2,:) = [-xs2(i,1);-xs2(i,2)];
end
A = A(:,1:8);
H_ = inv(A'*A)*A'*B;
H2to1 = zeros(3,3);
H2to1 = [H_(1), H_(2), H_(3);
    H_(4),H_(5),H_(6);
    H_(7),H_(8),1];

end
