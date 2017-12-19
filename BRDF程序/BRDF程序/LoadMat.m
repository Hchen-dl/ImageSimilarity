function [ mat_data ] = LoadMat( mat_name )
%LOADMAT 载入mat文件
%   mat_name  [int] mat文件名称
%   mat_data   [] mat数据

Folder = pwd;

if Folder(end)~='\'
    Folder=[Folder,'\'];
end
mat_full_name=strcat(Folder, mat_name);
if(exist(mat_full_name,'file')==0)
    errordlg(strcat( Folder,' 目录下',mat_full_name,'不存在'),'错误');
    return;
else
    mat_data=load (mat_full_name);
end

end

