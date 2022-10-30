function config = configDynamicsRobotArm()

config.m = [0.051, 0.098, 0.094, 0.064];

config.pc(:, 1) = [-1.112, -1.039, -3.921]';
config.pc(:, 2) = [-10.892, -0.542, -2.819]';
config.pc(:, 3) = [-10.293, 0.803, -2.720]';
config.pc(:, 4) = [-2.771, 0.997, 10.159]';

config.Ic = zeros(3, 3, 4);

config.L = [42, 129, 84.5]';
