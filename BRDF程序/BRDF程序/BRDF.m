   function varargout = BRDF(varargin)
% BRDF MATLAB code for BRDF.fig
%      BRDF, by itself, creates a new BRDF or raises the existing
%      singleton*.
%
%      H = BRDF returns the handle to a new BRDF or the handle to
%      the existing singleton*.
%
%      BRDF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BRDF.M with the given input arguments.
%
%      BRDF('Property','Value',...) creates a new BRDF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BRDF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BRDF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BRDF

% Last Modified by GUIDE v2.5 29-Aug-2017 09:47:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BRDF_OpeningFcn, ...
                   'gui_OutputFcn',  @BRDF_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before BRDF is made visible.
function BRDF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BRDF (see VARARGIN)

% Choose default command line output for BRDF
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BRDF wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global Old_FilePath;
global Old_SavePath;
global DSP_File_Path;
global DSP_Mat_SavePath;
global Leaf_File_Path;
global Leaf_Mat_SavePath;
global IsDefined_Wavelength;
Old_FilePath=pwd;%pwdΪ��ǰ����Ŀ¼��
Old_SavePath=pwd;
DSP_File_Path=pwd;
DSP_Mat_SavePath=pwd;
Leaf_File_Path=pwd;
Leaf_Mat_SavePath=pwd;
IsDefined_Wavelength=0;

% --- Outputs from this function are returned to the command line.
function varargout = BRDF_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- �򿪰װ壨Diffuse reflection plate�������ļ�
function DSP_File_Open_Callback(hObject, eventdata, handles)
% hObject    handle to DSP_File_Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DSP_File_Path;
global Old_FilePath;
DSP_File_Path=uigetdir(Old_FilePath);
if(DSP_File_Path~=0)
    Old_FilePath=DSP_File_Path;
    set(handles.InfoText,'string',strcat('�Ѵ�������������ļ�λ�ã�',DSP_File_Path));
else
    warndlg('��ѡ��������������ļ���','����');
end
0
0;
0%0 0-0-0-0 ����DSP���ݱ���λ��.
function DSP_Mat_Save_Path_Callback(hObject, eventdata, handles)
% hObject    handle to DSP_Mat_Save_Path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Old_SavePath;
global Old_FilePath;
global DSP_Mat_SavePath;
if(Old_FilePath~=0)
    Old_SavePath=Old_FilePath;
end
DSP_Mat_SavePath = uigetdir(Old_SavePath);
if (DSP_Mat_SavePath~=0)
    Old_SavePath=DSP_Mat_SavePath;
end
set(handles.InfoText,'string',strcat('��ѡ�񱣴������������λ�ã�',DSP_Mat_SavePath));

% --- ��ȡtxt�ļ��е����ݣ��������mat�ļ�
function DSP_2Mat_Callback(hObject, eventdata, handles)
% hObject    handle to DSP_2Mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DSP_Mat_SavePath;
global DSP_File_Path;
global Data_Class;
global DSP_Data;
if (strcmp(DSP_File_Path,pwd))
    errordlg('����ѡ����������ļ�','����');
    return;
elseif (DSP_File_Path(end)~='\')
    DSP_File_Path=[DSP_File_Path,'\'];
    if (DSP_Mat_SavePath==0)
        DSP_Mat_SavePath=DSP_File_Path;
    elseif (DSP_Mat_SavePath(end)~='\')
        DSP_Mat_SavePath=[DSP_Mat_SavePath,'\'];
    end
end
files=dir([DSP_File_Path,'*.txt']);  %��չ��
n=size(files,1);%���Ҫ����txt�ļ�������
switch(n)
    case 154
        Data_Class=4;
    case 190
        Data_Class=5;
    case 262
        Data_Class=7;
    case 298
        Data_Class=8;
    otherwise
        errordlg('�������ݸ�������,�ļ���ʧ���ظ�','����');
        Data_Class=-1;
        return;
end
set(handles.Data_Class_Edit,'string',num2str(Data_Class));

%txt to .mat txt��ȡ������txt��ĿС��10000�ĳ���
Temp_DSP_Data=[];
for i = 1:n
    Temp_DSP_Single_data=load([DSP_File_Path files(i).name]);
    Temp_DSP_Data=[Temp_DSP_Data,Temp_DSP_Single_data(:,2)];
end
DSP_Data=Temp_DSP_Data(225:1020,:);%��ȡ����
DSP_Data=DSP_Data';

DSP_Prefix_Num=DSP_File_Path(length(DSP_File_Path)-3:length(DSP_File_Path)-1);
DSP_Mat_Full_SavePath=strcat(DSP_Mat_SavePath,DSP_Prefix_Num,'.mat');
save (DSP_Mat_Full_SavePath,'DSP_Data');
set(handles.InfoText,'string',strcat('�ѱ��������������Ϊ��',DSP_Mat_Full_SavePath));


% --- �����������ݽ���Ԥ����
function DSP_Pre_Treatment_Callback(hObject, eventdata, handles)
% hObject    handle to DSP_Pre_Treatment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Coefficient=3.0423;
co8=[1	0.9848	0.9397	0.8660	0.7660	0.6429	0.5	0.3420];
co7=[0.9848	0.9397	0.8660	0.7660	0.6429	0.5	0.3420];
co5=[1	0.9659258	0.8660254	0.70710678 0.5];
co4=[0.9659258	0.8660254	0.70710678 0.5];

global DSP_Data;
global DSP_OK;
global Data_Class;
global DC;

switch(Data_Class)
    case 4
        DC=mean(DSP_Data(145:154,:));% DC for Dark_current
        DSP_Choose=zeros(36,length(DSP_Data));
        j=1;
        for i=3:4:144
            DSP_Choose(j,:)=DSP_Data(i,:); 
            j=j+1;
        end
        DSP_PT1=PreTreat_Average(DSP_Choose,0.25);
        DSP_PT2=PreTreat_Average(DSP_PT1,0.15);
        DSP_PTED=mean(DSP_PT2);
        DSP_PTED=repmat(DSP_PTED,36,1);
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
        for i=1:796        
            DSP_OK(:,i)=DSP_OK(:,i).*ph(i);
        end
set(handles.InfoText,'string','����������ݴ��������');

% --- ��ҶƬ�����ļ�
function Leaf_File_Open_Callback(hObject, eventdata, handles)
% hObject    handle to Leaf_File_Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in Leaf_2Mat.
global Leaf_File_Path;
global Old_FilePath;
Leaf_File_Path=uigetdir(Old_FilePath);
if(Leaf_File_Path~=0)
    Old_FilePath=Leaf_File_Path;
    set(handles.InfoText,'string',strcat('�Ѵ�ҶƬ�����ļ�λ�ã�',Leaf_File_Path));
else
	warndlg('��ѡ��ҶƬ�����ļ���','����');
end

% --- ����ҶƬ���ݱ���λ��.
function Leaf_Mat_Save_Path_Callback(hObject, eventdata, handles)
% hObject    handle to Leaf_Mat_Save_Path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Old_SavePath;
global Old_FilePath;
global Leaf_Mat_SavePath;
if(Old_FilePath~=0)
    Old_SavePath=Old_FilePath;
end
Leaf_Mat_SavePath = uigetdir(Old_SavePath);
if (Leaf_Mat_SavePath~=0)
    Old_SavePath=Leaf_Mat_SavePath;
end
set(handles.InfoText,'string',strcat('��ѡ�񱣴�ҶƬ������λ�ã�',Leaf_Mat_SavePath));

% --- ��ȡtxt�ļ��е����ݣ��������mat�ļ�
function Leaf_2Mat_Callback(hObject, eventdata, handles)
% hObject    handle to Leaf_2Mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Leaf_Mat_SavePath;
global Leaf_File_Path;
global Data_Class;
global Leaf_Data;
if (strcmp(Leaf_File_Path,pwd))
    errordlg('����ѡ��ҶƬ�����ļ�','����');
    return;
elseif (Leaf_File_Path(end)~='\')
    Leaf_File_Path=[Leaf_File_Path,'\'];
end

if (Leaf_Mat_SavePath==0)
    Leaf_Mat_SavePath=Leaf_File_Path;
elseif (Leaf_Mat_SavePath(end)~='\')
    Leaf_Mat_SavePath=[Leaf_Mat_SavePath,'\'];
end
    
Temp_files=dir([Leaf_File_Path,'*.txt']);  %��չ��
Temp_File_n=size(Temp_files,1);%���Ҫ����txt�ļ�������
switch(Temp_File_n)
    case 262
        Temp_Data_Class=7;
    case 298
        Temp_Data_Class=8;
    case 154
        Temp_Data_Class=4;
    case 190
        Temp_Data_Class=5;
    otherwise
        errordlg('�������ݸ�������,�ļ���ʧ���ظ�','����');
        Data_Class=-1;
        return;
end
if(Temp_Data_Class~=Data_Class)
    errordlg('ҶƬ������������������������Ͳ�������������','����');
    return;
else
    %txt to .mat txt��ȡ������txt��ĿС��10000�ĳ���
    Temp_Leaf_Data=[];
    for i = 1:Temp_File_n
        Temp_Leaf_Single_data=load([Leaf_File_Path Temp_files(i).name]);
        Temp_Leaf_Data=[Temp_Leaf_Data,Temp_Leaf_Single_data(:,2)];
    end
    Leaf_Data=Temp_Leaf_Data(225:1020,:);
    Leaf_Data=Leaf_Data';
    
    Leaf_Prefix_Num=Leaf_File_Path(length(Leaf_File_Path)-3:length(Leaf_File_Path)-1);
    Leaf_Mat_Full_SavePath=strcat(Leaf_Mat_SavePath,Leaf_Prefix_Num,'.mat');
    save (Leaf_Mat_Full_SavePath,'Leaf_Data');
    set(handles.InfoText,'string',strcat('�ѱ���ҶƬ����Ϊ��',Leaf_Mat_Full_SavePath));
end

% --- ����FR
function Compute_FR_Callback(hObject, eventdata, handles)
% hObject    handle to Compute_FR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DSP_File_Path;
global DSP_Data;
global Data_Class;
global DSP_OK;
global DC;
persistent DSP_File_Path_0;
persistent DSP_File_Path_30;
persistent DSP_File_Path_45;

global Leaf_File_Path;
persistent Leaf_File;
global Leaf_Data;

global Leaf_FR_0;
global Leaf_FR_30;
global Leaf_FR_45;

persistent Leaf_Path_0;
persistent Leaf_Path_30;
persistent Leaf_Path_45;
persistent Leaf_FR_index;
%   
% DSP_File_Path_0=[DSP_File_Path,'\0��'];
% DSP_File_Path_30=[DSP_File_Path,'\30��'];
DSP_File_Path_30=DSP_File_Path
% DSP_File_Path_45=[DSP_File_Path,'\45��'];
% Leaf_Path_0=[Leaf_File_Path,'\0��\'];
% Leaf_Path_30=[Leaf_File_Path,'\30��\'];
Leaf_Path_30=Leaf_File_Path
% Leaf_Path_45=[Leaf_File_Path,'\45��\'];

%  %0��
%  [DSP_Data,Data_Class]=getWhiteData(DSP_File_Path_0);
%  [DSP_OK,DC]=DSP_Pre_Treatment(DSP_Data,Data_Class);
%  DSP_Normalization(Data_Class);  
%  SampleCount1=GetSampleCount(Leaf_Path_0,Data_Class);
%  Leaf_FR_0=zeros(72,512,SampleCount1);
%  Leaf_FR_index=0;
%  LeafDirs=dir(Leaf_Path_0);
%  for index=1:length(LeafDirs) 
%      if(LeafDirs(index).isdir)
%      Leaf_File=strcat(Leaf_Path_0,LeafDirs(index).name);
%      Temp_files=dir([Leaf_File,'\*.txt']);  %��չ��
%      Temp_File_n=size(Temp_files,1);
%          if(Temp_File_n==82)
%          Leaf_FR_index=Leaf_FR_index+1;
%          Leaf_Data=getLeafData(Leaf_File,Data_Class);
%          Leaf_FR_0(:,:,Leaf_FR_index)=caculateFR(Leaf_Data,DC,DSP_OK,Data_Class);
%          end
%      end
%  end
%  FR_Mat_Full_SavePath=strcat(Leaf_Path_0,'FR_0','.mat');
%  save (FR_Mat_Full_SavePath,'Leaf_FR_0');
 
 %30��
 [DSP_Data,Data_Class]=getWhiteData(DSP_File_Path_30);
 [DSP_OK,DC]=DSP_Pre_Treatment(DSP_Data,Data_Class);
 DSP_Normalization(Data_Class);
 SampleCount2=GetSampleCount(Leaf_Path_30,Data_Class);
 Leaf_FR_30=zeros(96,512,SampleCount2);
 Leaf_FR_index=0;
 LeafDirs=dir(Leaf_Path_30);     
 for index=1:length(LeafDirs) 
     if(LeafDirs(index).isdir)
     Leaf_File=strcat(Leaf_Path_30,'\',LeafDirs(index).name);
     Temp_files=dir([Leaf_File,'\*.txt']);  %��չ��
     Temp_File_n=size(Temp_files,1);
         if(Temp_File_n==106)
           Leaf_FR_index=Leaf_FR_index+1;
           Leaf_Data=getLeafData(Leaf_File,Data_Class);
           Leaf_FR_30(:,:,Leaf_FR_index)=caculateFR(Leaf_Data,DC,DSP_OK,Data_Class);
         end
     end           
 end    
FR_Mat_Full_SavePath=strcat(Leaf_Path_30,'FR_30','.mat');
 save (FR_Mat_Full_SavePath,'Leaf_FR_30');
%  %45��
%  [DSP_Data,Data_Class]=getWhiteData(DSP_File_Path_45);
%  [DSP_OK,DC]=DSP_Pre_Treatment(DSP_Data,Data_Class);
%  DSP_Normalization(Data_Class);   
%  SampleCount3=GetSampleCount(Leaf_Path_45,Data_Class);
%  Leaf_FR_45=zeros(96,512,SampleCount3);
%  Leaf_FR_index=0;
%  LeafDirs=dir(Leaf_Path_45);     
%  for index=1:length(LeafDirs) 
%      if(LeafDirs(index).isdir)
%      Leaf_File=strcat(Leaf_Path_45,LeafDirs(index).name);
%      Temp_files=dir([Leaf_File,'\*.txt']);  %��չ��
%      Temp_File_n=size(Temp_files,1);
%          if(Temp_File_n==106)
%              Leaf_FR_index=Leaf_FR_index+1;
%              Leaf_Data=getLeafData(Leaf_File,Data_Class);
%              Leaf_FR_45(:,:,Leaf_FR_index)=caculateFR(Leaf_Data,DC,DSP_OK,Data_Class);
%          end
%      end      
%  end  
%  FR_Mat_Full_SavePath=strcat(Leaf_Path_45,'FR_45','.mat');
%  save (FR_Mat_Full_SavePath,'Leaf_FR_45');

function DSP_Normalization_Callback(hObject, eventdata, handles)
% hObject    handle to DSP_Normalization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

co8=[1 0.9848 0.9397 0.8660 0.7660 0.6429 0.5 0.3420];
co7=[0.9848 0.9397 0.8660 0.7660 0.6429 0.5 0.3420];
co5=[1	0.9659258	0.8660254	0.70710678 0.5];
co4=[1  0.9659258	0.8660254	0.70710678];

data_class=get(handles.Data_Class_Edit,'string');
data_class=str2num(data_class);
cla(handles.axes1);
axes(handles.axes1);
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
    case 5
        for i=1:5
            temp_z0=(1.3938*co5(i)-0.2127)/co5(i)*0.992/3.0669;
            temp_z1=[temp_z1 temp_z0];
        end
    otherwise
        errordlg('�������ʹ���','����');
end
v=temp_z1;
z=repmat(temp_z1,1,36);
Plot_xyz( 0,z,data_class,v, data_class);

% --- ����DSPͼ��
function Plot_DSP_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_DSP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DSP_OK;
global Data_Class;
if (isempty(DSP_OK))
    errordlg('û���ҵ�����������ݣ����ȡ������������ļ����д��������ͼ','����');
    return;    
else
    Wavelength=get(handles.Wavelength_Edit,'string');
    Wavelength=str2num(Wavelength);
    % for Wavelength=400:1000
    % DSP_WL= Wavelength_Set(Wavelength,DSP_OK);
    %
    %
    % end
    DSP_WL=Wavelength_Set(Wavelength,DSP_OK);
end
cla(handles.axes2);
axes(handles.axes2);
switch get(handles.popupmenu1,'Value')
    case 1
        Light_Zenith_Angle=0;
    case 2
        Light_Zenith_Angle=10;
    case 3
        Light_Zenith_Angle=30;
    case 4
        Light_Zenith_Angle=45;
end
z=DSP_WL';
Plot_xyz( 1,z,Light_Zenith_Angle,Wavelength,Data_Class);

% ---��ҶƬͼ��
function Plot_FR_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_FR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FR;
global Data_Class;
if (isempty(FR))    
    errordlg('û���ҵ�ҶƬBRDF���ݣ����ȡҶƬ�����ļ����д��������ͼ','����');
else
    Wavelength=get(handles.Wavelength_Edit,'string');
    Wavelength=str2num(Wavelength);
    % for Wavelength=400:1000
    % FR_WL=Wavelength_Set(Wavelength,FR);
    % end
    FR_WL=Wavelength_Set(Wavelength,FR);
end
cla(handles.axes1);
axes(handles.axes1);
hold on;

switch get(handles.popupmenu1,'Value')
    case 1
        Light_Zenith_Angle=0;
    case 2
        Light_Zenith_Angle=10;
    case 3
        Light_Zenith_Angle=30;
    case 4
        Light_Zenith_Angle=45;
end
z=FR_WL';
Plot_xyz( 1,z,Light_Zenith_Angle,Wavelength,Data_Class);

% ---����DSP����
function Save_DSP_Callback(hObject, eventdata, handles)
% hObject    handle to Save_DSP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes2 =handles.axes2;
if isempty(axes2)
   errordlg('�װ�����û��ͼ��','����');
end
newFig = figure('numbertitle','off','name','�������');%����ֱ�ӱ���axes2�ϵ�ͼ�������ѣ����Ա������½���figure�е���ͼ
newAxes = copyobj(axes2,newFig);%��axes2�е���ͼ���Ƶ��½���figure��
set(newAxes,'Units','default','Position','default');%����ͼ��ʾ��λ��
colormap (gray);
colorbar;
[filename,pathname] = uiputfile({ '*.jpg','figure type(*.jpg)'}, '����ͼ��');
if isequal(filename,0)||isequal(pathname,0)
    return
else
    fpath=fullfile(pathname,filename);
end
f = getframe(newFig);
f = frame2im(f);
imwrite(f, fpath);
set(handles.InfoText,'string',strcat('�������ͼ���ѱ���λ��',fpath));

% --- ����ҶƬͼ��
function Save_FR_Callback(hObject, eventdata, handles)
% hObject    handle to Save_FR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes1 =handles.axes1; 
if isempty(axes1)
   errordlg('ҶƬ����û��ͼ��','����');
end
newFig = figure('numbertitle','off','Visible','off','name','ҶƬFR');%����ֱ�ӱ���axes1�ϵ�ͼ�������ѣ����Ա������½���figure�е���ͼ
newAxes = copyobj(axes1,newFig); %��axes1�е���ͼ���Ƶ��½���figure��
set(newAxes,'Units','default','Position','default');%����ͼ��ʾ��λ��
%colormap (gray);
%colorbar;
[filename,pathname] = uiputfile({ '*.jpg','figure type(*.jpg)'}, '����ͼ��');
if isequal(filename,0)||isequal(pathname,0)
    return;
else
    fpath=fullfile(pathname,filename);
end
f = getframe(newFig);
f = frame2im(f);
imwrite(f, fpath);
set(handles.InfoText,'string',strcat('ҶƬͼ���ѱ���Ϊ��',fpath));


% --- �򿪹��ڽ���
function About_Button_Callback(hObject, eventdata, handles)
% hObject    handle to About_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
about;


% --- ���ͼ��
function Clear_Fig_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Clear_Fig_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes1 =handles.axes1; %ȡ��axes1�ľ��
axes2 =handles.axes2;
button=questdlg('ȷ����յ�ǰͼ��ô��','����ȷ��','Yes','No','No') ;
if strcmp(button,'Yes')
    if ~isempty(axes1)
        cla(axes1,'reset')
    end
    if ~isempty(axes2)
        cla(axes2,'reset')
    end
elseif strcmp(button,'No')
   return;
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1



function Wavelength_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Wavelength_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Wavelength_Edit as text
%        str2double(get(hObject,'String')) returns contents of Wavelength_Edit as a double


% --- Executes on button press in btn_createImage.
function btn_createImage_Callback(hObject, eventdata, handles)
global DSP_File_Path;

global IsDefined_Wavelength;
persistent wavelength_str;
global Leaf_File_Path;
global Leaf_FR_0;
global Leaf_FR_30;
global Leaf_FR_45;
persistent Leaf_Path_0;
persistent Leaf_Path_30;
persistent Leaf_Path_45;
persistent Picture_File_Path;
%Leaf_Path_0=[Leaf_File_Path,'\0��\'];
%Leaf_Path_30=[Leaf_File_Path,'\30��\'];
%Leaf_Path_45=[Leaf_File_Path,'\45��\'];
set(handles.InfoText,'string','���ڶ�ȡҶƬFR���ݣ�');
% Leaf_FR_0_t=load(strcat(Leaf_Path_0,'FR_0','.mat'));
% Leaf_FR_0=Leaf_FR_0_t.Leaf_FR_0;
% Leaf_FR_30_t=load(strcat(Leaf_Path_30,'FR_30','.mat'));
% Leaf_FR_30=Leaf_FR_30_t.Leaf_FR_30;
Leaf_FR_30_t=load(strcat(Leaf_File_Path,'FR_30','.mat'));
Leaf_FR_30=Leaf_FR_30_t.Leaf_FR_30;
% Leaf_FR_45_t=load(strcat(Leaf_Path_45,'FR_45','.mat'));
% Leaf_FR_45=Leaf_FR_45_t.Leaf_FR_45;

set(handles.InfoText,'string','ҶƬFR���ݶ�ȡ��ϣ���ʼ����ͼƬ');


%for Wavelength=897:1705
for Wavelength=897:1705   
    %ɾ��֮ǰ���ڵ�ͼ��
     delete(strcat(Picture_File_Path,'\ͼƬ\*.jpg'));
     %�Ƿ�ѡ������
     if(IsDefined_Wavelength) 
        Wavelength=get(handles.Wavelength_Edit,'string');
        Wavelength=str2num(Wavelength);
     end
%      SaveImage(handles,Leaf_FR_0,Wavelength,Picture_File_Path,1);
     SaveImage(handles,Leaf_FR_30,Wavelength,Picture_File_Path,3); 
%      SaveImage(handles,Leaf_FR_45,Wavelength,Picture_File_Path,4); 
     wavelength_str=num2str(Wavelength);
     set(handles.InfoText,'string',strcat(wavelength_str,'������ҶƬͼ���ѱ��档'));   
     test(wavelength_str,Picture_File_Path);%����ͼƬ���ƶȲⶨ
     %�ж��Ƿ�ѡ���Զ��岨����
     if(IsDefined_Wavelength)
        return;
     end
end


% --- Executes during object creation, after setting all properties.
function InfoText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InfoText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in btn_Stop.
function btn_Stop_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% �޸ĺ�ı���ͼ����
function SaveImage(handles,Leaf_FR,Wavelength,Leaf_Folder,Angle_Value)
global Data_Class;
persistent FR;
Leaf_Folder=[Leaf_Folder,'\ͼƬ\'];
if ~exist(Leaf_Folder,'dir')
mkdir(Leaf_Folder);
end
figure(1);
%figure('visible','off');
sizeFR=size(Leaf_FR);
for index=1:sizeFR(3)
    FR=Leaf_FR(:,:,index);
%          if(index<SampleCount1)                
%                 Angle_Value=1;
%          else if (index<SampleCount1+SampleCount2)
%                 Angle_Value=3;
%              else
%                 Angle_Value=4;
%              end
%          end 
if (isempty(FR))    
    errordlg('û���ҵ�ҶƬBRDF���ݣ����ȡҶƬ�����ļ����д��������ͼ','����');
else
    FR_WL=Wavelength_Set(Wavelength,FR);
end
% cla(handles.axes1);
% axes(handles.axes1);
hold on;
switch Angle_Value %��Ҫ�޸�global popupmenul
    case 1
        Light_Zenith_Angle=0;
    case 2
        Light_Zenith_Angle=10;
    case 3
        Light_Zenith_Angle=30;
    case 4
        Light_Zenith_Angle=45;
end
z=FR_WL';
clf;
if(Angle_Value==1)
    Data_Class=3;
else
    Data_Class=4;
end
Plot_xyz( 1,z,Light_Zenith_Angle,Wavelength,Data_Class);
axis off;
wavelength_str=num2str(Wavelength);
index_str=num2str(index,'%03d');
angle_str=num2str(Light_Zenith_Angle);
Leaf_Path=strcat(Leaf_Folder,angle_str,'_',index_str,'_',wavelength_str,'.jpg');%_
saveas(gca,Leaf_Path);
set(handles.InfoText,'string',strcat('ҶƬͼ���ѱ���Ϊ��',Leaf_Path));
%  close(gca);
%  axes1 =handles.axes1; 
%  if isempty(axes1)
%     errordlg('ҶƬ����û��ͼ��','����');
%  end
% 
%  newFig = figure('numbertitle','off','Visible','off','name','ҶƬFR');%����ֱ�ӱ���axes1�ϵ�ͼ�������ѣ����Ա������½���figure�е���ͼ
%  newAxes = copyobj(axes1,newFig); %��axes1�е���ͼ���Ƶ��½���figure��
%  set(newAxes,'Units','default','Position','default');%����ͼ��ʾ��λ��,���򽫻ᱣ���ͼƬ����ʾ��ͼƬ��С��һ�£�
%  f = getframe(newFig);
%  f = frame2im(f);
%  wavelength_str=num2str(Wavelength);
% index_str=num2str(index);
% Leaf_Path=strcat(Leaf_Folder,index_str,'_',wavelength_str,'.jpg');%_45��ʾ30�Ƚ�
% % saveas(h,Leaf_Path);
%  imwrite(f,Leaf_Path);

end
close(figure(1));


% --- Executes on button press in checkbox_ChooseWave.
function checkbox_ChooseWave_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_ChooseWave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IsDefined_Wavelength;
if ( get(hObject,'Value') )
IsDefined_Wavelength = 1;
else
IsDefined_Wavelength= 0;
end
% Hint: get(hObject,'Value') returns toggle state of checkbox_ChooseWave
