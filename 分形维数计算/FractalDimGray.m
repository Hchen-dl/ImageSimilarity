function D =FractalDimGray(imagePath,s,kmax)
%根据灰度值求分形维数
%imagePath为图片路径
%s为盒子初始尺寸
%kmax为尺寸个数
%%
img=imread(imagePath);%读取rgb图像
grayImageR=img(:,:,1);%读取灰度图
% [width,heigh]=size(grayImageR);%图像宽度
% point=[fix(width/6),fix(heigh/6)];%截取点
% data=grayImageR(point(1):point(1)+M-1,point(2):point(2)+M-1);%截取M*M窗口；
data=grayImageR;
[width,heigh]=size(data);
% imshow(data);
Gmax=max(max(data));%图片像素最大值
% sArr=[2 3 5 7 9 11 13 15];
% counts=zeros(1,length(sArr));
sArr=power(2,0:kmax-1)*s;
counts=zeros(1,kmax);
%%
for k=1:kmax
    s=sArr(k);
    r=s/width;
    h=Gmax*r;
    rows=1:s:width;%划分后矩阵的行脚标
    cols=1:s:heigh;%划分后矩阵的列脚标
    count=int32(0);%计数初始化
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
            smax=max(max(ss));%一次求一维的最值，两次后求得此ss方格内的最大值
            smin=min(min(ss));%同上求得最小值
            nr=int32(smax/h-smin/h+1);%fix(smax/h)-fix(smin/h)+1为此s*s格内的盒子数
            count=count+nr;%
        end
    end
    counts(k)=count;
end
%%
% rArr=sArr/M;
x=log(sArr);
y=log(counts);
D=polyfit(x,y,1);%拟合后的直线斜率和截距
plot(x, polyval(D, x),'-s');
str=sprintf('曲线方程：log(Nr)=(%0.5g)*log(1/r)+(%0.5g)',D(1),D(2));
text(1.5,y(fix(length(x)/2)),str);%标注
end
