function torque = dynamicsRobotArm(q, qd, qdd)

% read dimension of input
jointNum = length(q);

% initial iteration value of kane
omega_0 = [0, 0, 0]';
v_0 = [0, 0, 0]';
alpha_0 = [0, 0, 0]';
a_0 = [0, 9.81, 0]';
omegaDiffqd_0 = zeros(3, jointNum);
vDiffqd_0 = zeros(3, jointNum);

% define the rotational axis direction
z = [0, 0, 1]';

% Solve Kinematics Parameter T p R
[~, p, R] = partialKinematicsRobotArm(q);

% load dynamics config parameter
dynamicsConfig = configDynamicsRobotArm();
m = dynamicsConfig.m;
pc = dynamicsConfig.pc;
Ic = dynamicsConfig.Ic;

% Solve general dynamics term function

% Solve omega
omega = nan(3, jointNum);
% alpha(:, 1) depend on omega_0
omega(:, 1) = R(:, :, 1) * omega_0 + z * qd(1);
% omega(:, i) depend on alpha(:, i - 1), iterative solve
for iJoint = 2 : jointNum  
    omega(:, iJoint) = R(:, :, iJoint) * omega(:, iJoint-1) + z * qd(iJoint);
end

% Solve v
v = nan(3, jointNum);
% v(:, 1) depend on v_0 and omega_0
v(:, 1) = R(:, :, 1) * (v_0 + cross(omega_0, p(:, 1)));
% v(:, i) depend on v(:, i-1), iterative solve.
for i = 2 : jointNum
    % Main chain joint sequence: 1-2-3-4-5-6-7
    v(:, i) = R(:, :, i) * (v(:, i - 1) + cross(omega(:, i - 1), p(:, i)));
end

% Solve vc
vc = nan(3, jointNum);
for i = 1 : jointNum
    vc(:, i) = v(:, i) + cross(omega(:, i), pc(:, i));
end

% Solve alpha
alpha = nan(3, jointNum);
% alpha(:, 1) depend on alpha_0 and omega_0
alpha(:, 1) = R(:, :, 1) * alpha_0 + ...
    cross(R(:, :, 1) * omega_0, z * qd(1)) + z * qdd(1);
% alpha(:, i) depend on alpha(:, i-1), iterative solve.
for i = 2 : jointNum
    alpha(:, i) = R(:, :, i) * alpha(:, i-1) + ...
        cross(R(:, :, i) * omega(:, i-1), z * qd(i)) + ...
        z * qdd(i);
end

% Solve Nc
Nc = nan(3, jointNum);
for i = 1 : jointNum
    Nc(:, i) = Ic(:, :, i) * alpha(:,i) + ...
        cross(omega(:,i), Ic(:, :, i) * omega(:,i));
end

% Solve a
a = nan(3, jointNum);
% a(:, 1) depend on a_0
a(:, 1) = R(:, :, 1) * (a_0 + cross(alpha_0, p(:, 1)) + ...
    cross(omega_0, cross(omega_0, p(:, 1))));
% a(:, i) depend on a(:, i-1), iterative solve.
for i = 2 : jointNum
    a(:,i) = R(:, :, i) * (a(:, i - 1) + cross(alpha(:, i - 1), p(:, i)) + ...
        cross(omega(:, i - 1), cross(omega(:, i - 1), p(:, i))));
end

% Solve ac
ac = nan(3, jointNum);
for i = 1 : jointNum
    ac(:, i) = a(:, i) + cross(alpha(:, i), pc(:, i)) + ...
        cross(omega(:, i), cross(omega(:, i), pc(:, i)));
end

% Solve partial velocity term

% Solve omegaDiffqd
omegaDiffqd = nan(3, jointNum, jointNum);
% joint 1 depend on omegaDiffqd_0
for j = 1 : jointNum
    if j < 1
        omegaDiffqd(:, 1, j) = R(:, :, 1) * omegaDiffqd_0(:, j);
    elseif j == 1
        omegaDiffqd(:, 1, j) = z;
    else
        omegaDiffqd(:, 1, j) = zeros(3, 1);
    end
end
% other joint
for i = 2 : jointNum
    for j = 1 : jointNum
        if j < i
            omegaDiffqd(:, i, j) = ...
                R(:, :, i) * omegaDiffqd(:, i - 1, j);
        elseif j == i
            omegaDiffqd(:, i, j) = z;
        else
            omegaDiffqd(:, i, j) = zeros(3, 1);
        end
    end
end

% Solve vDiffQd
vDiffqd = nan(3, jointNum, jointNum);
% joint 1 depend on vDiffqd_0 and omegaDiffqd_0
for j = 1 : jointNum
    if j < 1
        vDiffqd(:, 1, j) = R(:, :, 1) * ...
            (vDiffqd_0(:, j) + cross(omegaDiffqd_0(:, j), p(:, 1)));
    elseif j >= 1
        vDiffqd(:, 1, j) = zeros(3, 1);
    end
end
% other joint
for i = 2 : jointNum
    for j = 1 : jointNum
        if j < i
            vDiffqd(:, i, j) = R(:, :, i) * (vDiffqd(:, i-1, j) + ...
                cross(omegaDiffqd(:, i-1, j), p(:, i)));
        elseif j >= i
            vDiffqd(:, i, j) = [0,0,0]';
        end
    end
end

% Solve vcDiffQd
vcDiffqd = nan(3, jointNum, jointNum);
for i = 1 : jointNum
    for j = 1 : jointNum
        if j < i
            vcDiffqd(:, i, j) = vDiffqd(:, i, j) + ...
                cross(omegaDiffqd(:, i, j), pc(:, i));
        elseif j == i
            vcDiffqd(:, i, j) = cross(z, pc(:, i));
        else
            vcDiffqd(:, i, j) = zeros(3, 1);
        end
    end
end

% Solve Torque
torque = nan(jointNum, 1);
torqueV = zeros(jointNum, 1);
torqueOmega = zeros(jointNum, 1);
for j = 1 : jointNum
    for i = 1 : jointNum
        torqueV(j) = torqueV(j) + m(i) * dot(ac(:, i), vcDiffqd(:, i, j));
        torqueOmega(j) = torqueOmega(j) + dot(Nc(:, i), omegaDiffqd(:, i, j));
    end
    torque(j) = torqueV(j) + torqueOmega(j);
end



end