function D =FractalDimGray(imagePath,s,kmax)
%���ݻҶ�ֵ�����ά��
%imagePathΪͼƬ·��
%sΪ���ӳ�ʼ�ߴ�
%kmaxΪ�ߴ����
%%
img=imread(imagePath);%��ȡrgbͼ��
grayImageR=img(:,:,1);%��ȡ�Ҷ�ͼ
% [width,heigh]=size(grayImageR);%ͼ����
% point=[fix(width/6),fix(heigh/6)];%��ȡ��
% data=grayImageR(point(1):point(1)+M-1,point(2):point(2)+M-1);%��ȡM*M���ڣ�
data=grayImageR;
[width,heigh]=size(data);
% imshow(data);
Gmax=max(max(data));%ͼƬ�������ֵ
% sArr=[2 3 5 7 9 11 13 15];
% counts=zeros(1,length(sArr));
sArr=power(2,0:kmax-1)*s;
counts=zeros(1,kmax);
%%
for k=1:kmax
    s=sArr(k);
    r=s/width;
    h=Gmax*r;
    rows=1:s:width;%���ֺ������нű�
    cols=1:s:heigh;%���ֺ������нű�
    count=int32(0);%������ʼ��
    for row=1:length(rows)
        for col=1:length(cols)
            row1=rows(row);            
            if(row==length(rows))
                row2=width;
%                 row2=M;
            else row2=rows(row+1)-1;
            end
            col1=cols(col);
            if(col==length(cols))
%                 col2=M;
                col2=heigh;
            else col2=cols(col+1)-1;
            end
            ss=data(row1:row2,col1:col2);
            smax=max(max(ss));%һ����һά����ֵ�����κ���ô�ss�����ڵ����ֵ
            smin=min(min(ss));%ͬ�������Сֵ
            nr=int32(smax/h-smin/h+1);%fix(smax/h)-fix(smin/h)+1Ϊ��s*s���ڵĺ�����
            count=count+nr;%
        end
    end
    counts(k)=count;
end
%%
% rArr=sArr/M;
x=log(sArr);
y=log(counts);
D=polyfit(x,y,1);%��Ϻ��ֱ��б�ʺͽؾ�
plot(x, polyval(D, x),'-s');
str=sprintf('���߷��̣�log(Nr)=(%0.5g)*log(1/r)+(%0.5g)',D(1),D(2));
text(1.5,y(fix(length(x)/2)),str);%��ע
end
