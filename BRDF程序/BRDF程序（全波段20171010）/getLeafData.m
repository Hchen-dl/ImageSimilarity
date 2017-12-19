function [ Leaf_data] = getLeafData( Leaf_File,Data_Class )
%GETLEAFDATA 此处显示有关此函数的摘要
%   此处显示详细说明
%global Leaf_Mat_SavePath;
%global Leaf_File_Path;
persistent Temp_Data_Class;
if (strcmp(Leaf_File,pwd))
    warndlg('请先选择叶片数据文件','错误');
    return;
elseif (Leaf_File(end)~='\')
    Leaf_File=[Leaf_File,'\'];
end
Temp_files=dir([Leaf_File,'*.txt']);  %扩展名
Temp_File_n=size(Temp_files,1);%获得要处理txt文件的数量
switch(Temp_File_n)
    case 262
        Temp_Data_Class=7;
    case 298
        Temp_Data_Class=8;
    case 106
        Temp_Data_Class=4;
    case 190
        Temp_Data_Class=5;
    case 82
        Temp_Data_Class=3;
    otherwise
        return;
        %warndlg('测量数据个数不对,文件丢失或重复','错误');        
end
if(Temp_Data_Class~=Data_Class)
    warndlg('叶片数据类型与漫反射板数据类型不符，请检查数据','错误');
else
    %txt to .mat txt提取，适用txt数目小于10000的程序
    Temp_Leaf_data=[];
    for i = 1:Temp_File_n
        Temp_Leaf_Single_data=load([Leaf_File Temp_files(i).name]);
        Temp_Leaf_data=[Temp_Leaf_data,Temp_Leaf_Single_data(:,2)];
    end
    %Leaf_data=Temp_Leaf_data(225:1020,:);
    Leaf_data=Temp_Leaf_data';
end
end

