function dy = accelerateFun( t,y )
% % �����ո׿��ƴﵽ��̬ʱ��������ٶ�
% % y(1)=x;y(2)=v;y(3)=Pr;y(4)=F;
% dy=zeros(4,1);
% %%%%%%%%%%%%%%%
% gamma=1.4;
% A=200;%��ֵ
% f=2;%Ƶ��
% m=0.748;%�ƶ��������
% p0=500;%500Pa
% D=0.08;
% Ac=pi/4*D*D;
% L0=0.01;%��ʼ����
% pl=A*sin(2*pi*f*t)+p0;
% dpl=A*2*pi*f*cos(2*pi*f*t); %��ʼֵΪA*2*pi*f
% Vl=Ac*(L0-y(1));
% Vr=Ac*(L0+y(1));
% %%%%%%%%%%%%%%%%%%%%%%
% v=dpl*Vl/(gamma*Ac*pl);
% y(2)=v; %��ʼ�ٶ�0.0359
% dy(1)=y(2); 
% dy(2)=1/m*(y(4)+(y(3)-pl)*Ac); %���ٶȳ�ʼֵΪ
% dy(3)=-gamma*Ac*y(3)*y(2)/Vr;


dy=zeros(2,1);
%%%%%%%%%%%%%%%
gamma=1.4;
A=200;%��ֵ
f=2;%Ƶ��
m=0.748;%�ƶ��������
p0=500;%500Pa
D=0.08;
Ac=pi/4*D*D;
L0=0.01;%��ʼ����
pl=A*sin(2*pi*f*t)+p0;
dpl=A*2*pi*f*cos(2*pi*f*t); %��ʼֵΪA*2*pi*f
Vl=Ac*(L0-y(1));
Vr=Ac*(L0+y(1));

dy(1) = dpl * Ac * Vl / (gamma * Ac * pl);
dy(2) = -gamma * Ac * y(2) * dy(1) / Vr;

% dy(1) = y(2);
% dy(2) = dpl * Ac * (L0 - y(1)) / (gamma * Ac * pl);



end

