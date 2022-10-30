function theta = compute_inverse_kinematics(pos)

theta = [nan; nan];

config = get_config_punchrobot();

L = config.L;

X = pos(1);
Y = pos(2);

a = X^2 + Y^2 - L(2)^2 - 2 * L(3) * Y + L(3)^2;
b = -4 * X * L(3);
c = X^2 + Y^2 - L(2)^2 + 2 * L(3) * Y + L(3)^2;

if a == 0
    t = -c / b;
else
    t(1) = (-b + sqrt(b^2 - 4 * a * c)) / (2 * a);
    t(2) = (-b - sqrt(b^2 - 4 * a * c)) / (2 * a);
end


theta1Tmp = atan2(t, 1) * 2;
theta2Tmp = atan2((Y + L(3) * cos(theta1Tmp)) ./ ...
    (X - L(3) * sin(theta1Tmp)), 1);

thetaTmp = [theta1Tmp; theta2Tmp];
[~, solvePoint] = size(thetaTmp);
if solvePoint > 1
    for i = 1 : solvePoint
        if (thetaTmp(1, i) >= -pi/2 && thetaTmp(1, i) <= pi/2 ) && ...
            (thetaTmp(2, i) >= 0 && thetaTmp(2, i) <= pi/2)
            theta = thetaTmp(:, i);
            disp('useful angle is:');
            disp(theta);
        else
            disp('over limit angle is:');
            disp(thetaTmp(:, i));
        end
    end
end

