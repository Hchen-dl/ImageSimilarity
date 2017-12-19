function [ data_wl ] = Wavelength_Set( wavelength,data )
%WAVELENGTH_SET �趨����
%   wavelength [in] ѡ������
%   data [in] ����
%   data_wl [out] �ض�����������

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
    errordlg('������Χ������400-1000nm��Χ��ѡ��','����');
    data_wl=0;
end

end

