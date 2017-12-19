function [ FR ] = caculateFR( Leaf_Data,DC,DSP_OK,Data_Class)
%UNTITLED 计算叶片FR
%   此处显示详细说明
if isempty(Leaf_Data)
    warndlg('请先读取叶片数据，进行处理，再计算叶片FR');
    return;
end
if isempty(DC)
    warndlg('请先读取漫反射数据，进行处理提取暗电流，再计算叶片FR');
    return;
end
if isempty(DSP_OK)
    warndlg('请先读取漫反射数据，进行校正，再计算叶片FR');
    return;
end
switch(Data_Class)
    case 7
        y=Leaf_Data(1:252,:);
    case 8
        y=Leaf_Data(1:288,:);
    case 3
        y=Leaf_Data(1:72,:);
    case 4
        y=Leaf_Data(1:96,:);
    case 5
        y=Leaf_Data(1:180,:);
    otherwise
        errordlg('测量数据个数不对,文件丢失或重复','错误');
        return
end
Temp_fr=bsxfun(@minus,y,DC);
FR=Temp_fr./DSP_OK;
end

