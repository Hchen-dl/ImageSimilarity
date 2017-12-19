function [ data_wl ] = Wavelength_Set( wavelength,data )
%WAVELENGTH_SET 设定波长
%   wavelength [in] 选定波长
%   data [in] 数据
%   data_wl [out] 特定波长的数据

if((wavelength<1706)&&(wavelength>400))
    Temp_x=LoadMat('x_1.mat');
    x=Temp_x.x_1;
    for i=1:length(x)
        disp(x(i));
        disp(x(i+1));
        disp(wavelength);
        if ((x(i)-wavelength<=0) && (x(i+1)-wavelength>0))
            data_wl=data(:,i)+(wavelength-x(i))*(data(:,i+1)-data(:,i))./(x(i+1)-x(i));
            break
        end
    end
else
    errordlg('超出范围，请在400-1000nm范围内选择','错误');
    data_wl=0;
end

end

