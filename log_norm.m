%% ����������ĳ���Ӳ��ֲ����У�Ȼ�����ͳ�Ʒ������ֲ����
clear all;clc;close all;
%% ������̬�ֲ�
dist_model=3;
signalV=0.4;
num=10000;
z=ScatterAmplitudeModel(num,dist_model,signalV);           %---�������ֲַ�������
abs_z = abs(z);
[n,x]=hist(abs_z,1000);
dx=mean(diff(x));
 %---�������л�ȡ����
ln_z = log(abs_z);
mu = mean(ln_z);
sigmas_Estimation=sqrt(mean(ln_z.^2)-mu.^2);
Pdf_Theory=1/sqrt(2*pi)/sigmas_Estimation./x.*exp(-(log(x)-mu).^2/2/sigmas_Estimation^2);
Pdf_CalcuFromData=n/sum(n)/dx;
figure;plot(x,Pdf_CalcuFromData);
hold on;plot(x,Pdf_Theory,'r','LineWidth',2);
xlabel('����');ylabel('�����ܶ�')
legend('����ֵ','����ֵ')