function [T, p, Rinv] = partialKinematicsRobotArm(theta)

% load dynamics and kinematics config parameter
dynamicsConfig = configDynamicsRobotArm();
kinematicsConfig = configKinematicsRobotArm(dynamicsConfig.L);

% solve kinematics parameter v and M
jointNum = length(theta);
for iJoint = 1 : jointNum
    kinematicsConfig.v(:, iJoint) = cross(...
        kinematicsConfig.r(:, iJoint), ...
        kinematicsConfig.omega(:, iJoint));
    kinematicsConfig.M(:, :, iJoint) = [kinematicsConfig.R(:, :, iJoint), ...
        kinematicsConfig.r(:, iJoint); 0, 0, 0, 1];
end

% initial T p Rinv
% note that dynamics function needs inv(R) instead of R
T = nan(4, 4, jointNum);
Rinv = nan(3, 3, jointNum);
p = nan(3, jointNum);

for iJoint = 1 : jointNum
    % Solve T p Rinv
%     T(:, :, iJoint) = solveKineT(kinematicsConfig.omega(:, iJoint), ...
%         kinematicsConfig.v(:, iJoint), theta(iJoint)) * ...
%         kinematicsConfig.M(:, :, iJoint);
    % Solve anti-symmetric matrix
    omega_skew = vec2svec(kinematicsConfig.omega(:, iJoint));
    R = eye(3) + sin(theta(iJoint)) * ...
        omega_skew + (1 - cos(theta(iJoint))) * omega_skew^2;
    G = eye(3) * theta(iJoint) + (1 - cos(theta(iJoint))) * omega_skew + ...
        (theta(iJoint) - sin(theta(iJoint))) * omega_skew^2;
    T(:, :, iJoint) = [R, G*kinematicsConfig.v(:, iJoint); 0, 0, 0, 1] * ...
        kinematicsConfig.M(:, :, iJoint);
    Rinv(:, :, iJoint) = inv(T(1 : 3, 1 : 3, iJoint));
    p(:, iJoint) = T(1 : 3, 4 , iJoint);
end
