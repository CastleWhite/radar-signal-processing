%% 这个程序产生某种杂波分布序列，然后进行统计分析及分布拟合
clear all;clc;close all;
%% 高斯分布
dist_model=1;
signalV=10;
num=10000;
z=ScatterAmplitudeModel(num,dist_model,signalV);           %---产生这种分布的数据
[n,x]=hist(abs(z),1000);
dx=mean(diff(x));
sigmas_Estimation=sqrt(mean(abs(z).^2)-(mean(abs(z))).^2)  %---从数据中获取标准差,利用方差和均值之间的关系
b=sigmas_Estimation/sqrt((4-pi)/2)
Pdf_Theory=x/(b)^2.*exp(-x.^2/2/b^2);
Pdf_CalcuFromData=n/sum(n)/dx;

figure;plot(x,Pdf_CalcuFromData);
hold on;plot(x,Pdf_Theory,'r','LineWidth',2);
xlabel('幅度');ylabel('概率密度')
legend('仿真值','理论值')
