function [ SampleCount ] = GetSampleCount( FolderPath,DataClass)
%��ȡ���ļ����µ�
%   �˴���ʾ��ϸ˵��
SampleCount=0;
switch DataClass
    case 3
         LeafDirs=dir(FolderPath);     
         for index=1:length(LeafDirs) 
             if(LeafDirs(index).isdir)
             Leaf_File=strcat(FolderPath,LeafDirs(index).name);
             Temp_files=dir([Leaf_File,'\*.txt']);  %��չ��
             Temp_File_n=size(Temp_files,1);
                 if(Temp_File_n==82)
                     SampleCount=SampleCount+1;
                 end
             end
         end
    case 4
        LeafDirs=dir(FolderPath);     
         for index=1:length(LeafDirs) 
             if(LeafDirs(index).isdir)
             Leaf_File=strcat(FolderPath,LeafDirs(index).name);
             Temp_files=dir([Leaf_File,'\*.txt']);  %��չ��
             Temp_File_n=size(Temp_files,1);
                 if(Temp_File_n==106)
                     SampleCount=SampleCount+1;
                 end
             end
         end
end

