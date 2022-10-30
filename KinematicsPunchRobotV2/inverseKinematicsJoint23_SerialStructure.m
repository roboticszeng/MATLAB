clear;clc;
% load testXYZ;
L = [0, 80, 50];
% x0 = 44.6447;
% y0 = 0; z0 = -35.3553;

x0 = -32.14;
y0 = 42.7;
z0 = 0;

% x0 = (rand - 0.5) * 100;
% y0 = (rand - 0.5) * 100;
% z0 = (rand - 0.5) * 100;

for iLoop = 1 : 2
    
    if iLoop == 1
        y0_ = sqrt(y0^2 + z0^2);
    else
        y0_ = -sqrt(y0^2 + z0^2);
    end

A = (L(2)^2 - (x0^2 + y0_^2 + L(3)^2)) / (2 * L(3));

t3(1) = (y0_ + sqrt(x0^2 + y0_^2 - A^2)) / (A + x0);
t3(2) = (y0_ - sqrt(x0^2 + y0_^2 - A^2)) / (A + x0);

j = 0;
for i = 1 : 2
    if t3(i) < pi / 2 && t3(i) > -pi / 2
        t = t3(i);
        j = j + 1;
    end
end

if j == 2
    disp('error');
    return;
end

theta(3, iLoop) = atan2(t, 1) * 2;
theta(2, iLoop) = atan2(y0_ + L(3) * sin(theta(3)), x0 + L(3) * cos(theta(3)));
theta(1, iLoop) = atan(y0/z0);

end

thetaDeg = theta * 180 / pi;