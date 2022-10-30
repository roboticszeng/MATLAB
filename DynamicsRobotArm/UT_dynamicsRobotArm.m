clear;clc;
load joint2.txt;
load joint3.txt;

testLength = 361;
qRange = linspace(-180, 180, testLength)' * pi / 180;
torque = nan(testLength, 4);


qTest = [zeros(testLength, 1), qRange, zeros(testLength, 2)];
% qTest = [zeros(testLength, 2), qRange, zeros(testLength, 1)];
for i = 1 : testLength
    torque(i, :) = dynamicsRobotArm(...
        qTest(i, :), ...
        zeros(4, 1), zeros(4, 1));
end

for i = 1 : 4
    figure(i)
    plot(1:testLength, torque(:, i), 'k', 'LineWidth', 1.5);
    hold on;
    if i == 2
        plot(joint2(:, 1), joint2(:, 3));
    elseif i == 3
        plot(joint3(:, 1), joint3(:, 2));
    end
    hold off;
    xlabel('time / s');
    ylabel('torque / N*mm');
    xlim([0 360]);
end