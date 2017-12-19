function [ ] = Plot_xyz( flag,z,dc,v,dt)
%PLOT_XYZ 作图
%   flag [in] 作图类型（0为归一化，1为作图）
%   z [in] 作图数据
%   dc [in] 归一化时为测量次数，作叶片图时为数据分类(天顶角)
%   修改v为wavelength（陈海）
%   v [in] 等值线参数
%   dt[] 
x=[];y=[];
if(flag==0)
    switch dc
        case 7
            for i=0:pi/18:35*pi/18 %方位角 每隔10度测量一个
                for j=pi/18:pi/18:7*pi/18 %天顶角 每隔10度测一个 共7组数据
                    x=[x 400*sin(j)*cos(i)];
                    y=[y 400*sin(j)*sin(i)];%x,y值换做极坐标值
                end
            end
       case 8
            for i=0:pi/18:35*pi/18 %方位角 每隔10度测量一个
                for j=0:pi/18:7*pi/18 %天顶角 每隔10度测一个 共7组数据
                    x=[x 400*sin(j)*cos(i)];
                    y=[y 400*sin(j)*sin(i)];%x,y值换做极坐标值
                end
            end
        case 3
        for i=0:pi/12:23*pi/12 %方位角 每隔15度测量一个
            for j=pi*15/180:pi*15/180:45*pi/180 %天顶角 每隔15度测一个 共3组数据
                x=[x 400*sin(j)*cos(i)];
                y=[y 400*sin(j)*sin(i)];%x,y值换做极坐标值
            end
        end
       case 4
           for i=0:pi/12:23*pi/12 %方位角 每隔10度测量一个
                for j=15*pi/180:pi*15/180:6*pi/18 %天顶角 每隔15度测一个 共4组数据 15 30 45 60
                    x=[x 400*sin(j)*cos(i)];
                    y=[y 400*sin(j)*sin(i)];%x,y值换做极坐标值
                end
            end
        case 5
            for i=0:pi/18:35*pi/18 %方位角 每隔10度测量一个
                for j=0:pi*15/180:6*pi/18 %天顶角 每隔10度测一个 共7组数据
                    x=[x 400*sin(j)*cos(i)];
                    y=[y 400*sin(j)*sin(i)];%x,y值换做极坐标值
                end
            end
        otherwise
            errordlg('数据类型错误','错误');
    end
else
    switch dc
        case 0
            if(dt==7)
                for i=0:pi/18:35*pi/18 %方位角 每隔10度测量一个
                    for j=pi/18:pi/18:7*pi/18 %天顶角 每隔10度测一个 共7组数据
                        x=[x 400*sin(j)*cos(i)];
                        y=[y 400*sin(j)*sin(i)];%x,y值换做极坐标值
                    end
                end
            elseif(dt==4)
                for i=0:pi/12:23*pi/12 %方位角 每隔15度测量一个
                    for j=pi*15/180:pi*15/180:6*pi/18 %天顶角 每隔15度测一个 共4组数据
                        x=[x 400*sin(j)*cos(i)];
                        y=[y 400*sin(j)*sin(i)];%x,y值换做极坐标值
                    end
                end
            elseif(dt==3)
                for i=0:pi/12:23*pi/12 %方位角 每隔15度测量一个
                    for j=15*pi/180:pi*15/180:45*pi/180 %天顶角 每隔15度测一个 共3组数据 15 30 45
                        x=[x 400*sin(j)*cos(i)];
                        y=[y 400*sin(j)*sin(i)];%x,y值换做极坐标值
                    end
                end
            else
                errordlg('数据类型错误','错误');
            end            
        case {10,30,45}
            if (dt==8)
                for i=0:pi/18:35*pi/18 %方位角 每隔10度测量一个
                    for j=0:pi/18:7*pi/18 %天顶角 每隔10度测一个 共8组数据
                        x=[x 400*sin(j)*cos(i)];
                        y=[y 400*sin(j)*sin(i)];%x,y值换做极坐标值
                    end
                end
            elseif(dt==4)
                for i=0:pi/12:23*pi/12 %方位角 每隔10度测量一个
                    for j=0*pi/180:pi*15/180:45*pi/180 %天顶角 每隔15度测一个 共4组数据 0 15 30 45
                        x=[x 400*sin(j)*cos(i)];
                        y=[y 400*sin(j)*sin(i)];%x,y值换做极坐标值
                    end
                end
            elseif(dt==5)
                for i=0:pi/18:35*pi/18 %方位角 每隔10度测量一个
                    for j=0:pi*15/180:6*pi/18 %天顶角 每隔15度测一个 共5组数据 0 15 30 45 60
                        x=[x 400*sin(j)*cos(i)];
                        y=[y 400*sin(j)*sin(i)];%x,y值换做极坐标值
                    end
                end
            else
                errordlg('数据类型错误','错误');
            end  
    end
end
[X,Y]=meshgrid(min(x):max(x),min(y):max(y));
Z = griddata(x,y,z,X,Y);
%Z+叶片文件夹+波长+角度（dt）;

contourf(X,Y,Z,dt);
hold on;
%colormap (gray);
%colorbar;
hold on;

%画点
if(dt==7)||(dt==8)
    for i=0:pi/18:7*pi/18
        x1=[];y1=[];
        for j=0:pi/18:2*pi
            x1=[x1 400*sin(i)*cos(j)];
            y1=[y1 400*sin(i)*sin(j)];
        end
        plot(x1,y1,'.k','MarkerSize',4)
        hold on;
        axis equal;
    end
elseif (dt==4)||(dt==3)
    for i=0:pi*15/180:6*pi/18
        x1=[];y1=[];
        for j=0:pi/18:2*pi
            x1=[x1 400*sin(i)*cos(j)];
            y1=[y1 400*sin(i)*sin(j)];
        end
        plot(x1,y1,'.k','MarkerSize',4)
        hold on;
        axis equal;
    end
else
    errordlg('数据类型错误','错误');
end
% 
% 
% 
% % 坐标最外圈
% xr=[];yr=[];
% for m=0:pi/72:2*pi
%     xr=[xr 400*sin(9*pi/18)*cos(m)];
%     yr=[yr 400*sin(9*pi/18)*sin(m)];
% end
% plot(xr,yr,'-k','MarkerSize',10)
% hold on;
% 
% % 圆中十字交叉线
% xq=-400*sin(9*pi/18):10:400*sin(9*pi/18);
% yq=zeros(length(xq),1);
% plot(xq,yq,'.k','MarkerSize',4.5);
% hold on;
% plot(yq,xq,'.k','MarkerSize',4.5);
% xq=-400*sin(9*pi/18)*sqrt(2)/2:10:400*sin(9*pi/18)*sqrt(2)/2;
% plot(xq,xq,'.k','MarkerSize',4.5);
% hold on;
% plot(xq,-xq,'.k','MarkerSize',4.5);
% hold on;

%%画五角星
% if(flag==1)
%     y4=0;x4=-400*sin(dc*pi/180);
%     plot(x4,y4,'p','MarkerFaceColor','r','MarkerSize',16);
%     axis off;
%     hold on;
% end

end

