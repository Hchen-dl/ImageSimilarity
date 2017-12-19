function [ SampleCount ] = GetSampleCount( FolderPath,DataClass)
%获取该文件夹下的
%   此处显示详细说明
SampleCount=0;
switch DataClass
    case 3
         LeafDirs=dir(FolderPath);     
         for index=1:length(LeafDirs) 
             if(LeafDirs(index).isdir)
             Leaf_File=strcat(FolderPath,LeafDirs(index).name);
             Temp_files=dir([Leaf_File,'\*.txt']);  %扩展名
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
             Temp_files=dir([Leaf_File,'\*.txt']);  %扩展名
             Temp_File_n=size(Temp_files,1);
                 if(Temp_File_n==106)
                     SampleCount=SampleCount+1;
                 end
             end
         end
end

