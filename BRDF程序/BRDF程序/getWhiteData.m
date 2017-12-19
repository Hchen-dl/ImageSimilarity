function [DSP_data,Data_Class] = getWhiteData(DSP_File_Path)
%   获取白板数据
%   此处显示详细说明
if (strcmp(DSP_File_Path,pwd))
    errordlg('请先选择漫反射板文件','错误');
    return;
elseif (DSP_File_Path(end)~='\')
    DSP_File_Path=[DSP_File_Path,'\'];
end
files=dir([DSP_File_Path,'*.txt']);  %扩展名
n=size(files,1);%获得要处理txt文件的数量
switch(n)
    case 82
        Data_Class=3;
    case 106
        Data_Class=4;
    case 190
        Data_Class=5;
    case 262
        Data_Class=7;
    case 298
        Data_Class=8;
    otherwise
        errordlg('测量数据个数不对,文件丢失或重复','错误');
        Data_Class=-1;
        return;
end
%set(handles.Data_Class_Edit,'string',num2str(Data_Class));
%txt to .mat txt提取，适用txt数目小于10000的程序
Temp_DSP_data=[];
for i = 1:n
    Temp_DSP_Single_data=load([DSP_File_Path files(i).name]);
    Temp_DSP_data=[Temp_DSP_data,Temp_DSP_Single_data(:,2)];
end
%DSP_data=Temp_DSP_data(225:1020,:);%截取波长
DSP_data=Temp_DSP_data';
end

