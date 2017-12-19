function D =FractalDim(imagePath,kmax)
%%
img=imread(imagePath);
th=graythresh(img);   
binary=im2bw(img,th);
binary=~binary;%背景为白的的时候
data=binary;%获取二值图像
imshow(data);
%%
counts=zeros(1,kmax);
for k=1:kmax
    [width,heigh]=size(data);%图像宽度    
    k2=power(2,k);%矩阵块的大小定义
    rows=1:k2:width;%划分后矩阵的行脚标
    cols=1:k2:heigh;%划分后矩阵的列脚标
    count=0;%计数初始化
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
            
            if(data(row1:row2,col1:col2)==0)%这里是判断矩阵是不是要找的矩阵的条件。
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
D=-(polyfit(x,y,1));%拟合后的直线斜率和截距
plot(x,y,'-s');
end
