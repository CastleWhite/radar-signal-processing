function sca_coeff=ScatterAmplitudeModel(num,dist_model,m_para)
%% 该程序作用：根据不同的杂波幅度分布模型，得到杂波幅度
%---输入：
%       num：仿真点数
%       dist_model：杂波分布模型
%       m_para：分布参数（dist_model=0时为数据文件路径）
%---输出：
%       sca_coeff：各杂波点散射系数
%%
switch dist_model
    case 1  
        %% 高斯杂波模型
        msrt=m_para;          %--msrt就是标准差
        w=randn(num,1)*msrt;
        v=randn(num,1)*msrt;
        am_dst=w+j*v;
        z=am_dst./sqrt(2);
    case 2 
        %% 复合K分布产生过程
        b = 1;
        nu = m_para;  %形状参数
        w=randn(num,1);
        v=randn(num,1);
        am_dst=w+j*v;
        s = sqrt(gamrnd(nu, 2*b.^2, num, 1));
        z = s.*am_dst;
                        
    case 3
        %% 对数正态分布过程
        msrt=m_para; %标准差
        mu=2;
        w=normrnd(mu,msrt,[num,1]);
        z = exp(w);
                
    case 4
        %% 威布尔分布
        v = m_para;  %形状参数
        b = 4;  %尺度参数
        z = wblrnd(b,v,[num,1]);
                
end
sca_coeff=z;
