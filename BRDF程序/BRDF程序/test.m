function test(wavelength_str,Leaf_File_Path)
%测试叶片角度间相似度和角度内相似度
%
Leaf_File_Path=[Leaf_File_Path,'\图片'];
vector_pictures=getPictureVector(Leaf_File_Path);%获取建模向量
vecScore=zscore(vector_pictures);
% dist=pdist(vecScore,'correlation'); %用 ‘metric’指定的方法计算 X 数据矩阵中对象之间的距离。’
% distD=squareform(dist);
% Z=linkage(dist,'average');%用‘method’参数指定的算法计算系统聚类树。
% I=cluster(Z,3);
% I_diff=find(I'~=Istandard);
%LS_SVM(vector_pictures);
vector_model=vector_pictures(1:2:end,:);
vector_sample=vector_pictures(2:2:end,:);
vector_means=[mean(vector_model(1:3,:));mean(vector_model(4:5,:));mean(vector_model(6:8,:))];
%% 测试角度间的相似度； 
I=getClasses(vector_sample,vector_means);
I=I';
I_standard=[1*ones(1,2),2*ones(1,3),3*ones(1,2)];
I_diff=find(I~=I_standard);
% %% 测试角度内的相似度；
% vector_result2=vector_model(6:10,:);
% vector_catagory=[2 3];
% vector_meansb=getMeans(vector_result2,vector_catagory);%保存类内样本
% vector_result2=vector_sample(4:25,:);
% I1=getClasses(vector_result2,vector_meansb);
% I1=I1';
% I1_standard=[1 1 2 2 ];
% I1_diff=find(I1~=I1_standard);
%% 保存结果
dlmwrite('result.txt',wavelength_str,'-append','delimiter','','roffset',1,'newline','pc');
dlmwrite('result.txt',I_diff,'-append','delimiter',' ','roffset',1,'newline','pc');
%dlmwrite('result.txt',I1_diff,'-append','delimiter',' ','roffset',1,'newline','pc');
% fid=fopen('result.txt','a+');%需修改
% formatSpec='';
% fprintf(fid,wavelength_str);
% fprintf(fid,'角度间:\r\n'); 
% fprintf(fid,'%d\t',I_diff);  
% fprintf(fid,'\r\n角度内:\r\n'); 
% fprintf(fid,'%d\t',I1_diff);  
% fprintf(fid,'\r\n');
% fclose(fid);
end

