%% ����������ĳ���Ӳ��ֲ����У�Ȼ�����ͳ�Ʒ������ֲ����
clear all;clc;close all;
%% ��˹�ֲ�
dist_model=1;
signalV=10;
num=10000;
z=ScatterAmplitudeModel(num,dist_model,signalV);           %---�������ֲַ�������
[n,x]=hist(abs(z),1000);
dx=mean(diff(x));
sigmas_Estimation=sqrt(mean(abs(z).^2)-(mean(abs(z))).^2)  %---�������л�ȡ��׼��,���÷���;�ֵ֮��Ĺ�ϵ
b=sigmas_Estimation/sqrt((4-pi)/2)
Pdf_Theory=x/(b)^2.*exp(-x.^2/2/b^2);
Pdf_CalcuFromData=n/sum(n)/dx;

figure;plot(x,Pdf_CalcuFromData);
hold on;plot(x,Pdf_Theory,'r','LineWidth',2);
xlabel('����');ylabel('�����ܶ�')
legend('����ֵ','����ֵ')
