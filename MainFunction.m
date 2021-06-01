%% ʵ�����ݴ���
clear all;clc;close all;
%% ���ݶ�ȡ
load data_Raw.mat; 
[Nrn,Nan]=size(data1);  % ������������ͷ�λ�������
%% ���״�ϵͳ��������
PRF=1256.98;           % Pulse Reputation Frequency (Hz)��ʱ�������
PRT=1/PRF;             % �����ظ����ڣ�s��
Fs=32.317e+6;          % Radar sampling rate (Hz)��ʱ��Ƶ��
fc=5.300e+9;           % Radar center frequency (Hz)�ز�Ƶ��
c=2.9979e+8;           % Speed of light (m/s)����
R0=0.0065956*c/2;      % �������ĵ�б��
Kr=0.72135e+12;        % FM rate of radar pulse (Hz/s)��ʱ���Ƶ��
Tp=41.75e-6;           % Chirp duration (s)�������ʱ��
Doppler_centroid=-6900;% ����������ƫ�ƣ�Hz��
lambda=c/fc;           % ������m��
v=6.9621e+03;          %ƽ̨���ٶȣ�m/s��
fr=([0:Nrn-1]-ceil(Nrn/2))'/Nrn*Fs;     %  ����Ƶ�ʱ�����Hz��
tm=([0:Nan-1]-ceil(Nan/2))*PRT;         % ��λ��ʱ�䣨s��
fa=([0:Nan-1]-ceil(Nan/2))/Nan*PRF;     % ��λ��ʱ���Ӧ�Ķ�����Ƶ�ʣ�Hz��

%% �ھ���Ƶ����ɾ�������ѹ��
s=fftshift(fft(ifftshift(data1),[],1));
sr=exp(-j*pi/Kr*fr.^2);
out=s.*(sr*ones(1,Nan));
rg_compr = fftshift(ifft(ifftshift(out)));
figure;colormap(gray);imagesc(abs(rg_compr));

%% �ھ���Ƶ����ɾ����߶�����
sin_theta=Doppler_centroid*lambda/2/v;
h=exp(-j*4*pi*v*sin_theta/c*fr*tm);
out2=out.*h;
rg_cc = fftshift(ifft(ifftshift(out2),[],1));
figure;colormap(gray);imagesc(abs(rg_cc));

%% ��ɷ�λѹ�����
kd=-2*v^2/lambda/R0*(1-sin_theta^2);
sa=exp(j*pi/kd*fa.^2);
out3=fftshift(fft(ifftshift(rg_cc),[],2));
out3=out3.*(ones(Nrn,1)*sa);
sar = fftshift(ifft(ifftshift(out3),[],2));
figure;
colormap(gray);
imagesc((abs(sar)).^0.25);

