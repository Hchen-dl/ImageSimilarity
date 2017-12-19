function [ DSP_OK,DC ] = DSP_Pre_Treatment( DSP_Data,Data_Class )
%DSP_PRE_TREATMENT 预处理
%   此处显示详细说明
Coefficient=3.0423;
co8=[1	0.9848	0.9397	0.8660	0.7660	0.6429	0.5	0.3420];
co7=[0.9848	0.9397	0.8660	0.7660	0.6429	0.5	0.3420];
co5=[1	0.9659258	0.8660254	0.70710678 0.5];
co4=[0.9659258	0.8660254	0.70710678 0.5];
co3=[0.8660254	0.70710678 0.5];
switch(Data_Class)
    case 3
        DC=mean(DSP_Data(73:82,:));% DC for Dark_current
        DSP_Choose=zeros(24,length(DSP_Data));
        j=1;
        for i=2:3:72
            DSP_Choose(j,:)=DSP_Data(i,:); 
            j=j+1;
        end
        DSP_PT1=PreTreat_Average(DSP_Choose,0.25);
        DSP_PT2=PreTreat_Average(DSP_PT1,0.15);
        DSP_PTED=mean(DSP_PT2);
        DSP_PTED=repmat(DSP_PTED,24,1);
        DSP_OK=[];
        for i=1:length(DSP_PTED(:,1)) 
            Temp_DSP=((DSP_PTED(i,:)-DC)'*co3)';
            Temp_DSP=Temp_DSP.*Coefficient;
            DSP_OK=[DSP_OK ; Temp_DSP];
        end 
    case 4
        DC=mean(DSP_Data(97:106,:));% DC for Dark_current
        DSP_Choose=zeros(24,length(DSP_Data));
        j=1;
        for i=3:4:96
            DSP_Choose(j,:)=DSP_Data(i,:); 
            j=j+1;
        end
        DSP_PT1=PreTreat_Average(DSP_Choose,0.25);
        DSP_PT2=PreTreat_Average(DSP_PT1,0.15);
        DSP_PTED=mean(DSP_PT2);
        DSP_PTED=repmat(DSP_PTED,24,1);
        DSP_OK=[];
        for i=1:length(DSP_PTED(:,1)) 
            Temp_DSP=((DSP_PTED(i,:)-DC)'*co4)';
            Temp_DSP=Temp_DSP.*Coefficient;
            DSP_OK=[DSP_OK ; Temp_DSP];
        end 
	case 5
        DC=mean(DSP_Data(181:190,:));% DC for Dark_current
        DSP_Choose=zeros(36,length(DSP_Data));
        j=1;
        for i=3:5:144
            DSP_Choose(j,:)=DSP_Data(i,:);  
            j=j+1;
        end
        DSP_PT1=PreTreat_Average(DSP_Choose,0.25);
        DSP_PT2=PreTreat_Average(DSP_PT1,0.15);
        DSP_PTED=mean(DSP_PT2);
        DSP_PTED=repmat(DSP_PTED,36,1);
        DSP_OK=[];
        for i=1:length(DSP_PTED(:,1)) 
            Temp_DSP=((DSP_PTED(i,:)-DC)'*co5)';
            Temp_DSP=Temp_DSP.*Coefficient;
            DSP_OK=[DSP_OK ; Temp_DSP];
        end 
    case 7
        DC=mean(DSP_Data(253:262,:));% DC for Dark_current
        DSP_Choose=zeros(36,length(DSP_Data));
        j=1;
        for i=3:7:252
            DSP_Choose(j,:)=DSP_Data(i,:);  
            j=j+1;
        end
        DSP_PT1=PreTreat_Average(DSP_Choose,0.25);
        DSP_PT2=PreTreat_Average(DSP_PT1,0.15);
        DSP_PTED=mean(DSP_PT2);
        DSP_PTED=repmat(DSP_PTED,36,1);
        DSP_OK=[];
        for i=1:length(DSP_PTED(:,1)) 
            Temp_DSP=((DSP_PTED(i,:)-DC)'*co7)';
            Temp_DSP=Temp_DSP.*Coefficient;
            DSP_OK=[DSP_OK ; Temp_DSP];
        end     
    case 8
        DC=mean(DSP_Data(289:298,:));% DC for Dark_current
        DSP_Choose=zeros(36,length(DSP_Data));
        j=1;
        for i=4:8:288
            DSP_Choose(j,:)=DSP_Data(i,:); 
            j=j+1;
        end
        DSP_PT1=PreTreat_Average(DSP_Choose,0.25);
        DSP_PT2=PreTreat_Average(DSP_PT1,0.15);
        DSP_PTED=mean(DSP_PT2);
        DSP_PTED=repmat(DSP_PTED,36,1);
        DSP_OK=[];
        for i=1:length(DSP_PTED(:,1)) 
            Temp_DSP=((DSP_PTED(i,:)-DC)'*co8)';
            Temp_DSP=Temp_DSP.*Coefficient;
            DSP_OK=[DSP_OK ; Temp_DSP];
        end 
    
end
        Temp_ph=LoadMat('ph.mat');
        ph=Temp_ph.ph;
        for i=1:512
            DSP_OK(:,i)=DSP_OK(:,i).*ph(i);
        end
%set(handles.InfoText,'string','漫反射板数据处理已完成');
end

