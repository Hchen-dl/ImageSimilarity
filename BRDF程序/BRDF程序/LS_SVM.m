function [ Pe ] = LS_SVM( data )
X=data;
X=X';
%P=X(1:36,[1:25,31:55,61:85,91:115,121:145,151:175]);  %建模集输入光谱
%P1=X(1:36,[26:30,56:60,86:90,116:120,146:150,176:180]);  %预测集输入光谱
P_Sample=X(1:20,[1:7,10:16,20:26]); 
P_ToTest=X(1:20,[8:9,17:19,27:29]);
n1=P_Sample;
%x1 = [1*ones(1,25),2*ones(1,25),3*ones(1,25),4*ones(1,25),5*ones(1,25),6*ones(1,25)];   %建模集输出类别  % 特别注意：这里的目标与神经网络不同
x1 = [1*ones(1,7),2*ones(1,7),3*ones(1,7)];
n2 = P_ToTest;
x2 = [1*ones(1,2),2*ones(1,3),3*ones(1,3)];   %预测集输出类别
xn_train = n1;          % 训练样本
dn_train = x1;          % 训练目标

xn_test = n2;           % 测试样本
dn_test = x2;           % 测试目标

%---------------------------------------------------
% 参数设置

X = xn_train';
Y = dn_train';
Xt = xn_test';
Yt = dn_test';

type = 'c';
kernel_type = 'RBF_kernel';
gam=1;   %初始赋值
sig2=1;  %初始赋值
%U=zeros(10,10);
%for i=1:10;
    %gam=i;
    %for j=1:10;
        %sig2=j;
    
preprocess = 'preprocess';
codefct = 'code_ECOC';           

% 将“多类”转换成“两类”的编码方案
% 1. Minimum Output Coding (code_MOC) 
% 2. Error Correcting Output Code (code_ECOC)
% 3. One versus All Coding (code_OneVsAll)
% 4. One Versus One Coding (code_OneVsOne) 

%---------------------------------------------------
% 编码

[Yc,codebook,old_codebook] = code(Y,codefct);

%---------------------------------------------------
% 交叉验证优化参数

[gam,sig2] = tunelssvm({X,Yc,type,gam,sig2,kernel_type,preprocess})

%---------------------------------------------------
% 训练与测试

[alpha,b] = trainlssvm({X,Yc,type,gam,sig2,kernel_type,preprocess});           % 训练
Yd0 = simlssvm({X,Yc,type,gam,sig2,kernel_type,preprocess},{alpha,b},Xt);      % 分类
[area, se, deltab, oneMinusSpec, sens, TN, TP, FN, FP] = roc({X,Yc,type,gam,sig2,kernel_type}, figure)
%---------------------------------------------------
% 解码

Yd = code(Yd0,old_codebook,[],codebook);

%---------------------------------------------------
% 结果统计

Result = ~abs(Yd-Yt);               % 正确分类显示为1
Pe= sum(Result)/length(Result); 

end

