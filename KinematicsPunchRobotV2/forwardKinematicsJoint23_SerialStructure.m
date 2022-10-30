clear;clc;
L = [0, 80, 50];

theta = [31, -49.2, 47]' * pi / 180;

x0Test = L(2) * cos(theta(2)) - L(3) * cos(theta(3));
y0Test = (L(2) * sin(theta(2)) - L(3) * sin(theta(3))) * sin(theta(1));
z0Test = (L(2) * sin(theta(2)) - L(3) * sin(theta(3))) * cos(theta(1));

%%

testLength = 10;
% theta1 = linspace(-180, 180, testLength)' * pi / 180;
theta1 = linspace(0, 0, testLength)' * pi / 180;
% theta2 = linspace(-180, 180, testLength)' * pi / 180;
% theta3 = linspace(-180, 180, testLength)' * pi / 180;
% theta1 = 0;
theta2 = linspace(-90, 90, testLength)' * pi / 180;
theta3 = linspace(-90, 90, testLength)' * pi / 180;

x0 = nan(testLength, testLength, testLength);
y0 = nan(testLength, testLength, testLength);
z0 = nan(testLength, testLength, testLength);
% x0 = nan(testLength, testLength);
% y0 = nan(testLength, testLength);
% z0 = nan(testLength, testLength);

for i = 1 : testLength
    for j = 1 : testLength
        for k = 1 : testLength
            theta(1) = theta1(i);
%             theta(1) = theta1;
            theta(2) = theta2(j);
            theta(3) = theta3(k);

x0(i, j, k) = L(2) * cos(theta(2)) - L(3) * cos(theta(3));
y0(i, j, k) = (L(2) * sin(theta(2)) - L(3) * sin(theta(3))) * sin(theta(1));
z0(i, j, k) = (L(2) * sin(theta(2)) - L(3) * sin(theta(3))) * cos(theta(1));
% x0(j, k) = L(2) * cos(theta(2)) - L(3) * cos(theta(3));
% y0(j, k) = (L(2) * sin(theta(2)) - L(3) * sin(theta(3))) * sin(theta(1));
% z0(j, k) = (L(2) * sin(theta(2)) - L(3) * sin(theta(3))) * cos(theta(1));

        end
    end
end
hold on;
for i = 1 : testLength
    for j = 1 : testLength
        for k = 1 : testLength
% plot(x0(j, k), z0(j, k), 'bo');
% plot3(x0(i, j, k), y0(i, j, k), z0(i, j, k), 'bo');
plot3(x0(i, j, k), z0(i, j, k), y0(i, j, k), 'bo');
        end
    end
end