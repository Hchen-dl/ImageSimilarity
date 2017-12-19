function test(Leaf_File_Path)
%测试叶片角度间相似度和角度内相似度
%
persistent path_0;
persistent path_30;
persistent path_45;
path_0=strcat(Leaf_File_Path,'\0度\图片');
path_30=strcat(Leaf_File_Path,'\30度\图片');
path_45=strcat(Leaf_File_Path,'\45度\图片');
%获取建模样本
vector_result1=getModlePictureVector(path_0);
vector_result2=getModlePictureVector(path_30);
vector_result3=getModlePictureVector(path_45);
vector_catagory=[4 5 13 19 23];
vector_meansb=getMeans(vector_result2,vector_catagory);%保存类内样本
%% 测试角度间的相似度； 
vector_mean1=mean(vector_result1,1);
vector_mean2=mean(vector_result2,1);
vector_mean3=mean(vector_result3,1);
vector_means=[vector_mean1;vector_mean2;vector_mean3];
%获取待测样本
vector_result1=getSamplePictureVector(path_0);
vector_result2=getSamplePictureVector(path_30);
vector_result3=getSamplePictureVector(path_45);
vector_results=[vector_result1;vector_result2;vector_result3];
I=getClasses(vector_results,vector_means);
I=I';
I_standard=[1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3];%需修改
I_diff=find(I~=I_standard);
%% 测试角度内的相似度；
I1=getClasses(vector_result2,vector_meansb);
I1=I1';
I1_standard=[1 1 1 2 2 3 3 3 3 3 3 3 4 4 4 4 4 4 4 5 5 5 ];
I1_diff=find(I1~=I1_standard);
%% 保存结果
fid=fopen('F:\徐洲师兄\我的文件\毕业论文\BRDF程序.1207\result.txt','a+');%需修改
fprintf(fid,'%d\t',I_diff);  
fprintf(fid,'\t角度间\r\n');  
fprintf(fid,'%d\t',I1_diff);  
fprintf(fid,'\t角度内\r\n');  
fclose(fid);
end

