function D =FractalDim(imagePath,kmax)
%%
img=imread(imagePath);
th=graythresh(img);   
binary=im2bw(img,th);
binary=~binary;%����Ϊ�׵ĵ�ʱ��
data=binary;%��ȡ��ֵͼ��
imshow(data);
%%
counts=zeros(1,kmax);
for k=1:kmax
    [width,heigh]=size(data);%ͼ����    
    k2=power(2,k);%�����Ĵ�С����
    rows=1:k2:width;%���ֺ������нű�
    cols=1:k2:heigh;%���ֺ������нű�
    count=0;%������ʼ��
    for row=1:length(rows)
        for col=1:length(cols)
            row1=rows(row);            
            if(row==length(rows))
                row2=width;
            else row2=rows(row+1)-1;
            end
            col1=cols(col);
            if(col==length(cols))
                col2=heigh;
            else col2=cols(col+1)-1;
            end
            
            if(data(row1:row2,col1:col2)==0)%�������жϾ����ǲ���Ҫ�ҵľ����������
                 count=count+1;
            end
        end
    end
    counts(k)=count;
end
x=log(power(2,1:kmax));
y=log(counts);
% x=1:kmax;
% y=counts;
% cor=corrcoef(x,y);
D=-(polyfit(x,y,1));%��Ϻ��ֱ��б�ʺͽؾ�
plot(x,y,'-s');
end
