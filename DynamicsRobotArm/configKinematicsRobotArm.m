function config = configKinematicsRobotArm(L)

config.omega(:, 1) = [0, -1, 0]';
config.omega(:, 2) = [1, 0, 0]';
config.omega(:, 3) = [0, 0, 1]';
config.omega(:, 4) = [-1, 0, 0]';

config.r(:, 1) = [0, 0, 0]';
config.r(:, 2) = [0, 0, -L(1)]';
config.r(:, 3) = [-L(2), 0, 0]';
config.r(:, 4) = [-L(3), 0, 0]';

config.R(:, :, 1) = [0, -1, 0; 0, 0, -1; 1, 0, 0];
config.R(:, :, 2) = [0, 0, 1; -1, 0, 0; 0, -1, 0];
config.R(:, :, 3) = eye(3);
config.R(:, :, 4) = [0, 0, -1; 0, 1, 0; 1, 0, 0];


