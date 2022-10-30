clear;clc;
K0 = 5.25;
n = 24;
K = nthroot(10, n);
% 1 * K_e6^6
for i = 1 : n
    m(i) = abs(K^i - K0);
end
[value, index] = min(m);
disp(m')