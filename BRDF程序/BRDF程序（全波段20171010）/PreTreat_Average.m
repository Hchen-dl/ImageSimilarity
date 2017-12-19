function [ data_pretreated ] = PreTreat_Average( data,threshold )
%PRETREAT_AVERAGE 依据均值 剔除 相差超过阈值 的数据点
%   data [in] 数据
%   threshold [in] 阈值 
%   data_pretreated [out] 输出数据

	data_m=mean(data);
	data_pretreated=[];
	for i=1:length(data(:,1))
        diff=(data(i,:)-data_m);
        cdiff=abs(diff./data_m);
        diffmax=max(cdiff);
        if (max(cdiff)<=threshold )
            data_pretreated=[data_pretreated;data(i,:)];
        end
	end
end

