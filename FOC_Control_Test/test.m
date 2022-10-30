clear;clc;

testLength = 101;
t = linspace(0, 10, testLength)';

Um = 3.3;
R = 3.3;
omega = 1;
theta = omega * t;

Ia = nan(testLength, 1);
Ib = nan(testLength, 1);
Ic = nan(testLength, 1);
Ialphabeta = nan(testLength, 2);
Idq = nan(testLength, 2);

for i = 1 : testLength
    
    Ia(i) = Um / R * sin(omega * t(i));
    Ib(i) = Um / R * sin(omega * t(i) - 2 / 3 * pi);
    Ic(i) = Um / R * sin(omega * t(i) - 4 / 3 * pi);
    Ialphabeta(i, :) = [1, -1/2, -1/2; 0, sqrt(3)/2, -sqrt(3)/2] * ...
        [Ia(i), Ib(i), Ic(i)]';
    Idq(i, :) = [cos(theta(i)), sin(theta(i)); ...
        -sin(theta(i)), cos(theta(i))] * Ialphabeta(i, :)';
    
end


