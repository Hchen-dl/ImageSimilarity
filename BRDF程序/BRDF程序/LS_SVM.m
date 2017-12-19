function [ Pe ] = LS_SVM( data )
X=data;
X=X';
%P=X(1:36,[1:25,31:55,61:85,91:115,121:145,151:175]);  %��ģ���������
%P1=X(1:36,[26:30,56:60,86:90,116:120,146:150,176:180]);  %Ԥ�⼯�������
P_Sample=X(1:20,[1:7,10:16,20:26]); 
P_ToTest=X(1:20,[8:9,17:19,27:29]);
n1=P_Sample;
%x1 = [1*ones(1,25),2*ones(1,25),3*ones(1,25),4*ones(1,25),5*ones(1,25),6*ones(1,25)];   %��ģ��������  % �ر�ע�⣺�����Ŀ���������粻ͬ
x1 = [1*ones(1,7),2*ones(1,7),3*ones(1,7)];
n2 = P_ToTest;
x2 = [1*ones(1,2),2*ones(1,3),3*ones(1,3)];   %Ԥ�⼯������
xn_train = n1;          % ѵ������
dn_train = x1;          % ѵ��Ŀ��

xn_test = n2;           % ��������
dn_test = x2;           % ����Ŀ��

%---------------------------------------------------
% ��������

X = xn_train';
Y = dn_train';
Xt = xn_test';
Yt = dn_test';

type = 'c';
kernel_type = 'RBF_kernel';
gam=1;   %��ʼ��ֵ
sig2=1;  %��ʼ��ֵ
%U=zeros(10,10);
%for i=1:10;
    %gam=i;
    %for j=1:10;
        %sig2=j;
    
preprocess = 'preprocess';
codefct = 'code_ECOC';           

% �������ࡱת���ɡ����ࡱ�ı��뷽��
% 1. Minimum Output Coding (code_MOC) 
% 2. Error Correcting Output Code (code_ECOC)
% 3. One versus All Coding (code_OneVsAll)
% 4. One Versus One Coding (code_OneVsOne) 

%---------------------------------------------------
% ����

[Yc,codebook,old_codebook] = code(Y,codefct);

%---------------------------------------------------
% ������֤�Ż�����

[gam,sig2] = tunelssvm({X,Yc,type,gam,sig2,kernel_type,preprocess})

%---------------------------------------------------
% ѵ�������

[alpha,b] = trainlssvm({X,Yc,type,gam,sig2,kernel_type,preprocess});           % ѵ��
Yd0 = simlssvm({X,Yc,type,gam,sig2,kernel_type,preprocess},{alpha,b},Xt);      % ����
[area, se, deltab, oneMinusSpec, sens, TN, TP, FN, FP] = roc({X,Yc,type,gam,sig2,kernel_type}, figure)
%---------------------------------------------------
% ����

Yd = code(Yd0,old_codebook,[],codebook);

%---------------------------------------------------
% ���ͳ��

Result = ~abs(Yd-Yt);               % ��ȷ������ʾΪ1
Pe= sum(Result)/length(Result); 

end

