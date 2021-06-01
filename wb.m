%% 这个程序产生某种杂波分布序列，然后进行统计分析及分布拟合
clear all;clc;close all;
%% 威布尔分布
dist_model=4;
signalV=2;
num=10000;
z=ScatterAmplitudeModel(num,dist_model,signalV);           %---产生这种分布的数据
abs_z = abs(z);
[n,x]=hist(abs_z,1000);
dx=mean(diff(x));
 %---从数据中获取参数
ln_z = log(abs_z);
mu = mean(ln_z);
v=1./sqrt(6*num/pi^2/(num-1)*(mean(ln_z.^2)-mu.^2));
b=exp(mu+0.5772/v);
Pdf_Theory=v*b^(-v)*x.^(v-1).*exp(-(x/b).^v);
Pdf_CalcuFromData=n/sum(n)/dx;
figure;plot(x,Pdf_CalcuFromData);
hold on;plot(x,Pdf_Theory,'r','LineWidth',2);
xlabel('幅度');ylabel('概率密度')
legend('仿真值','理论值')