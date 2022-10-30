clear;
clc;
% X=[1 13 1.5; 1.4 19 3; 1.8 25 1; 2.2 10 2.5;2.6 16 0.5; 3 22 2; 3.4 28 3.5; 3.5 30 3.7];
% Y=[0.330; 0.336; 0.294; 0.476; 0.209; 0.451; 0.482; 0.5];
load testData3D.mat;
xv = 20 : 5 : 100;
R = linspace(5, 9, length(xv));
h = linspace(2, 6, length(xv));
X = [xv', R', h'];
Y = sqrt((xv + R).^2 + (h + R).^2) - R;
Y = Y' * 10/17;

% Y = qm;
choose = 2;
[beta, r] = fit_nonlinear_data(X, Y, choose);

[X1, X2, X3] = meshgrid(X(:, 1), X(:, 2), X(:, 3));

if choose == 1
    Y_fit = beta(1) + beta(2) * X1 + beta(3) * X2 + beta(4) * X3;
else
%     Y_fit = fitRes(1) * X1 + fitRes(2) * sqrt(X1 .* X2) + ...
%     fitRes(3) * sqrt(X1 .* X3) + fitRes(4) * X3 + ...
%     fitRes(5) * X2;
    Y_fit = beta(1) * X1.^2 + beta(2) * X1 + ...
        beta(3) * X2.^2 + beta(4) * X2 + ...
        beta(5) * X3.^2 + beta(6) * X3 + ...
        beta(7) * X1 .* X2;
%     + beta(8) * sqrt(X1 .* X2) + ...
%         beta(9) * X1 .* X3 + beta(10) * sqrt(X1 .* X3);
end

figure;
% plot3(X(:, 1), X(:, 2), Y);
hold on;
% i = 1;
scatter3(X(:, 1), X(:, 2), Y);
for i = 1 : 5
    surf(X1(:, :, i), X2(:, :, i), Y_fit(:, :, i));
end
hold off;

% Y_fit_linear = beta(1) * X(:, 1) + beta(2) * sqrt(X(:, 1) .* X(:, 2)) + ...
%     beta(3) * sqrt(X(:, 1) .* X(:, 3)) + beta(4) * X(:, 3) + ...
%     beta(5) * X(:, 2);
x = X;
Y_fit_linear = beta(1) * x(:, 1).^2 + beta(2) * x(:, 1) + ...
    beta(3) * x(:, 2).^2 + beta(4) * x(:, 2) + ...
    beta(5) * x(:, 3).^2 + beta(6) * x(:, 3) + ...
    beta(7) * x(:, 1) .* x(:, 2);
%     beta(7) * x(:, 1) .* x(:, 2) + ...
%     beta(8) * sqrt(x(:, 1) .* x(:, 2)) + ...
%     beta(9) * x(:, 1) .* x(:, 3) + beta(10) * sqrt(x(:, 1) .* x(:, 3));

Y_error = abs(Y - Y_fit_linear);
figure;
plot(Y_error);

