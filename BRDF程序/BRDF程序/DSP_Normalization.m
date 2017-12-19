function [ output_args ] = DSP_Normalization( data_class )
%DSP_NOMALIZATION 此处显示有关此函数的摘要
%   此处显示详细说明
co8=[1 0.9848 0.9397 0.8660 0.7660 0.6429 0.5 0.3420];
co7=[0.9848 0.9397 0.8660 0.7660 0.6429 0.5 0.3420];
co5=[1	0.9659258	0.8660254	0.70710678 0.5];
co4=[1  0.9659258	0.8660254	0.70710678];
co3=[0.9659258	0.8660254	0.70710678];

%data_class=get(handles.Data_Class_Edit,'string');
%data_class=str2num(data_class);
%cla(handles.axes1);
%axes(handles.axes1);
hold on;
temp_z0=[];
temp_z1=[];
switch data_class
    case 7
        for i=1:7
            temp_z0=(1.3938*co7(i)-0.2127)/co7(i)*0.992/3.0669;
            temp_z1=[temp_z1 temp_z0];
        end
    case 8
        for i=1:8
            temp_z0=(1.3938*co8(i)-0.2127)/co8(i)*0.992/3.0669;
            temp_z1=[temp_z1 temp_z0];
        end
    case 4
        for i=1:4
            temp_z0=(1.3938*co4(i)-0.2127)/co4(i)*0.992/3.0669;
            temp_z1=[temp_z1 temp_z0];
        end
    case 3
        for i=1:3
            temp_z0=(1.3938*co3(i)-0.2127)/co3(i)*0.992/3.0669;
            temp_z1=[temp_z1 temp_z0];
        end
    case 5
        for i=1:5
            temp_z0=(1.3938*co5(i)-0.2127)/co5(i)*0.992/3.0669;
            temp_z1=[temp_z1 temp_z0];
        end
    otherwise
        errordlg('数据类型错误','错误');
end
v=temp_z1;
z=repmat(temp_z1,1,24);
Plot_xyz( 0,z,data_class,v, data_class);
end