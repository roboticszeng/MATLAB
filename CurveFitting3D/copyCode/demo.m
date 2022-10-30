clear
clc
X=[1 13 1.5; 1.4 19 3; 1.8 25 1; 2.2 10 2.5;2.6 16 0.5; 3 22 2; 3.4 28 3.5; 3.5 30 3.7];
Y=[0.330; 0.336; 0.294; 0.476; 0.209; 0.451; 0.482; 0.5];
choose = 3;
[fitRes, r] = fit_nonlinear_data(X, Y, choose);

[X1, X2, X3] = meshgrid(X(:, 1), X(:, 2), X(:, 3));

if choose == 1
    Y_fit = fitRes(1) + fitRes(2) * X1 + fitRes(3) * X2 + fitRes(4) * X3;
else
    Y_fit = fitRes(1) + fitRes(2) * X1 + fitRes(3) * X2 + ...
        fitRes(4) * X3 + fitRes(5) * (X1.^2) + ...
        fitRes(6) * (X2.^2) + fitRes(7) * (X3.^2);
end

figure;
% plot3(X(:, 1), X(:, 2), Y);
hold on;
% i = 1;
for i = 1 : 8
    surf(X1(:, :, i), X2(:, :, i), Y_fit(:, :, i));
end
hold off;