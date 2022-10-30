clear;clc;
close all;
gamma=1.4;
A=200;%幅值
f=2;%频率
m=0.748;%移动组件质量
p0=500;%500Pa
pl=A*sin(2*pi*f*0)+p0;
dpl=A*2*pi*f*cos(2*pi*f*0); %初始值为A*2*pi*f
D=0.08;
Ac=pi/4*D*D;
L0=0.01;%初始长度
Vl=Ac*(L0-0);
Vr=Ac*(L0+0);
%%%%%%%%%%%%%%%%%初始值计算%%%%%%%%%%%%%%
v0=dpl*Vl/(gamma*Ac*pl);
F0=0;a0=0;x0=0;
%%%%%%%%%%%%%%%%%%%%
[t,y]=ode45('accelerateFun',[0,1],[x0, 500]); %func;自变量范围；初始化值

x = y(:, 1);
pr = y(:, 2);



v = [0; diff(x) ./ diff(t)];
a = [0; diff(v) ./ diff(t)];

F = m * a - (pr - pl) * Ac;
figure(1)
plot(t, x);
figure(2)
plot(t, pr);
figure(3)
plot(t, F);
