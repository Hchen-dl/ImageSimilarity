function test(wavelength_str,Leaf_File_Path)
%����ҶƬ�Ƕȼ����ƶȺͽǶ������ƶ�
%
Leaf_File_Path=[Leaf_File_Path,'\ͼƬ'];
vector_pictures=getPictureVector(Leaf_File_Path);%��ȡ��ģ����
vecScore=zscore(vector_pictures);
% dist=pdist(vecScore,'correlation'); %�� ��metric��ָ���ķ������� X ���ݾ����ж���֮��ľ��롣��
% distD=squareform(dist);
% Z=linkage(dist,'average');%�á�method������ָ�����㷨����ϵͳ��������
% I=cluster(Z,3);
% I_diff=find(I'~=Istandard);
%LS_SVM(vector_pictures);
vector_model=vector_pictures(1:2:end,:);
vector_sample=vector_pictures(2:2:end,:);
vector_means=[mean(vector_model(1:3,:));mean(vector_model(4:5,:));mean(vector_model(6:8,:))];
%% ���ԽǶȼ�����ƶȣ� 
I=getClasses(vector_sample,vector_means);
I=I';
I_standard=[1*ones(1,2),2*ones(1,3),3*ones(1,2)];
I_diff=find(I~=I_standard);
% %% ���ԽǶ��ڵ����ƶȣ�
% vector_result2=vector_model(6:10,:);
% vector_catagory=[2 3];
% vector_meansb=getMeans(vector_result2,vector_catagory);%������������
% vector_result2=vector_sample(4:25,:);
% I1=getClasses(vector_result2,vector_meansb);
% I1=I1';
% I1_standard=[1 1 2 2 ];
% I1_diff=find(I1~=I1_standard);
%% ������
dlmwrite('result.txt',wavelength_str,'-append','delimiter','','roffset',1,'newline','pc');
dlmwrite('result.txt',I_diff,'-append','delimiter',' ','roffset',1,'newline','pc');
%dlmwrite('result.txt',I1_diff,'-append','delimiter',' ','roffset',1,'newline','pc');
% fid=fopen('result.txt','a+');%���޸�
% formatSpec='';
% fprintf(fid,wavelength_str);
% fprintf(fid,'�Ƕȼ�:\r\n'); 
% fprintf(fid,'%d\t',I_diff);  
% fprintf(fid,'\r\n�Ƕ���:\r\n'); 
% fprintf(fid,'%d\t',I1_diff);  
% fprintf(fid,'\r\n');
% fclose(fid);
end

