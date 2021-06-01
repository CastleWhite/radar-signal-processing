function sca_coeff=ScatterAmplitudeModel(num,dist_model,m_para)
%% �ó������ã����ݲ�ͬ���Ӳ����ȷֲ�ģ�ͣ��õ��Ӳ�����
%---���룺
%       num���������
%       dist_model���Ӳ��ֲ�ģ��
%       m_para���ֲ�������dist_model=0ʱΪ�����ļ�·����
%---�����
%       sca_coeff�����Ӳ���ɢ��ϵ��
%%
switch dist_model
    case 1  
        %% ��˹�Ӳ�ģ��
        msrt=m_para;          %--msrt���Ǳ�׼��
        w=randn(num,1)*msrt;
        v=randn(num,1)*msrt;
        am_dst=w+j*v;
        z=am_dst./sqrt(2);
    case 2 
        %% ����K�ֲ���������
        b = 1;
        nu = m_para;  %��״����
        w=randn(num,1);
        v=randn(num,1);
        am_dst=w+j*v;
        s = sqrt(gamrnd(nu, 2*b.^2, num, 1));
        z = s.*am_dst;
                        
    case 3
        %% ������̬�ֲ�����
        msrt=m_para; %��׼��
        mu=2;
        w=normrnd(mu,msrt,[num,1]);
        z = exp(w);
                
    case 4
        %% �������ֲ�
        v = m_para;  %��״����
        b = 4;  %�߶Ȳ���
        z = wblrnd(b,v,[num,1]);
                
end
sca_coeff=z;
