clear;clc;

% start
[T, ~, ~] = partialKinematicsRobotArm([0, 170, -60, 0]' * pi / 180);
Ts1 = T(:, :, 1) * T(:, :, 2) * T(:, :, 3) * T(:, :, 4);

% end
[T, ~, ~] = partialKinematicsRobotArm([0, 0, 0, 0]' * pi / 180);
Ts2 = T(:, :, 1) * T(:, :, 2) * T(:, :, 3) * T(:, :, 4);