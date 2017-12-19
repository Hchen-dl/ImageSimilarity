function [ output_args ] = PlotFR( Leaf_FR)
%绘制叶片FR图像
%   此处显示详细说明
Temp_x=LoadMat('x_1.mat');
x=Temp_x.x_1;
s=size(Leaf_FR);
angle_position=[0 15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345];
for index=1:s(3)
    figure();
    if(s(1)==72)
        angle_zenith=[15 30 45];
        else angle_zenith=[0 15 30 45];
    end
    tem_FR=Leaf_FR(:,:,index); 
    for angle_index=1:4:s(1) 
        y=tem_FR(angle_index,:);
        plot(x,y); 
        hold on;
        pause(0.05);
        a=mod(angle_index,length(angle_zenith));
        b=(angle_index-a)/length(angle_zenith);
        if(a==0)
            %figure();            
            a_str=num2str(angle_position(b));
            b_str=num2str(angle_zenith(length(angle_zenith)));
        else            
            a_str=num2str(angle_position(b+1));
            b_str=num2str(angle_zenith(a));
        end      
        angle_Str=strcat('(',a_str,',',b_str,')');
        legend(angle_Str);
    end
end

