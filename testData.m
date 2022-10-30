clear;clc;
A = 10;
xv = 20 : 20 : 100;
R = 5 : 9;
h = 2 : 6;
% h = 2;
% qm = nan(5, 5, 4);
for i = 1 : length(xv)
    for j = 1 : length(R)
%         qm(i, j)= sqrt((xv(i) + R(j))^2 + (h + R(j))^2) - R(j);
        for k = 1 : length(h)
            qm(i, j, k)= sqrt((xv(i) + R(j))^2 + (h(k) + R(j))^2) - R(j);
        end
    end
end