clear;clc;

testLength = 100;
[theta2, theta3] = meshgrid(linspace(0, pi, testLength)', ...
    linspace(0, pi, testLength)');
thetaRange = linspace(0, pi, testLength)';

x = nan(testLength, 1);
y = nan(testLength, 1);

% theta(2) = 0;
% theta(3) = 0;

L = [40, 100, 180, 100];
L31 = 90; L32 = L(3) - L31;
L0 = 50;

k = 0;

for i = 1 : testLength
    for j = 1 : testLength
    theta(2) = thetaRange(i);
    theta(3) = thetaRange(j);

M = L0 - L(1) * cos(theta(2)) + L(4) * cos(theta(3));
N = - L(1) * sin(theta(2)) + L(4) * sin(theta(3));
P = (L(2)^2 - M^2 - N^2 - L31^2) / (2 * L31);
phi = atan2(M, N);

if M^2 + N^2 - P^2 >= 0
    thetaJoint = 2 * atan2(N + sqrt(M^2 + N^2 - P^2), P + M);
    
else
    thetaJoint = nan;
    k = k + 1;
end
% x = L0 + L(4) * cos(theta(3)) - L32 * cos(thetaJoint);
% y = L(4) * sin(theta(3)) - L32 * sin(thetaJoint);
% x(i) = L0 + L(4) * cos(theta(3)) - L32 * cos(thetaJoint);
% y(i) = L(4) * sin(theta(3)) - L32 * sin(thetaJoint);
x(i, j) = L0 + L(4) * cos(theta(3)) - L32 * cos(thetaJoint);
y(i, j) = L(4) * sin(theta(3)) - L32 * sin(thetaJoint);

    end

end

% plot(x, y);
% figure(1)
% surf(theta2, theta3, x);
% figure(2)
% surf(theta2, theta3, y);
figure(3)
mesh(theta2, theta3, sqrt(x.^2 + y.^2));
xlabel('theta2');
ylabel('theta3');