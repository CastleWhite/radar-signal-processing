%% ����������ĳ���Ӳ��ֲ����У�Ȼ�����ͳ�Ʒ������ֲ����
clear all;clc;close all;
%% K�ֲ�
dist_model=2;
signalV=2;
num=10000;
z=ScatterAmplitudeModel(num,dist_model,signalV);           %---�������ֲַ�������
abs_z = abs(z);
[n,x]=hist(abs_z,1000);
dx=mean(diff(x));
m2 = mean(abs_z.^2);              %---�������л�ȡ����v,b(�ع���)
m4 = mean(abs_z.^4);
v = 1/(m4/2/m2^2-1);
b = 1/sqrt(v/m2)/2;
Pdf_Theory=2/b/gamma(v)*(x/2/b).^v.*besselk(v-1,x/b);
Pdf_CalcuFromData=n/sum(n)/dx;
figure;plot(x,Pdf_CalcuFromData);
hold on;plot(x,Pdf_Theory,'r','LineWidth',2);
xlabel('����');ylabel('�����ܶ�')
legend('����ֵ','����ֵ')