%% ����������ĳ���Ӳ��ֲ����У�Ȼ�����ͳ�Ʒ������ֲ����
clear all;clc;close all;
%% �������ֲ�
dist_model=4;
signalV=2;
num=10000;
z=ScatterAmplitudeModel(num,dist_model,signalV);           %---�������ֲַ�������
abs_z = abs(z);
[n,x]=hist(abs_z,1000);
dx=mean(diff(x));
 %---�������л�ȡ����
ln_z = log(abs_z);
mu = mean(ln_z);
v=1./sqrt(6*num/pi^2/(num-1)*(mean(ln_z.^2)-mu.^2));
b=exp(mu+0.5772/v);
Pdf_Theory=v*b^(-v)*x.^(v-1).*exp(-(x/b).^v);
Pdf_CalcuFromData=n/sum(n)/dx;
figure;plot(x,Pdf_CalcuFromData);
hold on;plot(x,Pdf_Theory,'r','LineWidth',2);
xlabel('����');ylabel('�����ܶ�')
legend('����ֵ','����ֵ')