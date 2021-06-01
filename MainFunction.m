%% 实测数据处理
clear all;clc;close all;
%% 数据读取
load data_Raw.mat; 
[Nrn,Nan]=size(data1);  % 距离脉冲个数和方位脉冲个数
%% 该雷达系统参数配置
PRF=1256.98;           % Pulse Reputation Frequency (Hz)慢时间采样率
PRT=1/PRF;             % 脉冲重复周期（s）
Fs=32.317e+6;          % Radar sampling rate (Hz)快时间频率
fc=5.300e+9;           % Radar center frequency (Hz)载波频率
c=2.9979e+8;           % Speed of light (m/s)光速
R0=0.0065956*c/2;      % 场景中心的斜距
Kr=0.72135e+12;        % FM rate of radar pulse (Hz/s)快时间调频率
Tp=41.75e-6;           % Chirp duration (s)脉冲持续时间
Doppler_centroid=-6900;% 多普勒中心偏移（Hz）
lambda=c/fc;           % 波长（m）
v=6.9621e+03;          %平台的速度（m/s）
fr=([0:Nrn-1]-ceil(Nrn/2))'/Nrn*Fs;     %  距离频率变量（Hz）
tm=([0:Nan-1]-ceil(Nan/2))*PRT;         % 方位慢时间（s）
fa=([0:Nan-1]-ceil(Nan/2))/Nan*PRF;     % 方位慢时间对应的多普勒频率（Hz）

%% 在距离频域完成距离脉冲压缩
s=fftshift(fft(ifftshift(data1),[],1));
sr=exp(-j*pi/Kr*fr.^2);
out=s.*(sr*ones(1,Nan));
rg_compr = fftshift(ifft(ifftshift(out)));
figure;colormap(gray);imagesc(abs(rg_compr));

%% 在距离频域完成距离走动矫正
sin_theta=Doppler_centroid*lambda/2/v;
h=exp(-j*4*pi*v*sin_theta/c*fr*tm);
out2=out.*h;
rg_cc = fftshift(ifft(ifftshift(out2),[],1));
figure;colormap(gray);imagesc(abs(rg_cc));

%% 完成方位压缩结果
kd=-2*v^2/lambda/R0*(1-sin_theta^2);
sa=exp(j*pi/kd*fa.^2);
out3=fftshift(fft(ifftshift(rg_cc),[],2));
out3=out3.*(ones(Nrn,1)*sa);
sar = fftshift(ifft(ifftshift(out3),[],2));
figure;
colormap(gray);
imagesc((abs(sar)).^0.25);

