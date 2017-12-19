function vector_result=getModlePictureVector(filepath)
%filepath 图片所在文件夹/the directory of the pictures
% pics=dir(strcat(filepath,'\*.png'));
pics=dir(strcat(filepath,'\*.jpg'));
vector_result=zeros(length(pics),5);
for index=1:length(pics)
    filename=strcat(filepath,'\',pics(index).name);    
    %tem_index=num2str(index);
    %filepath=strcat('E:\FirstYear\ImageSimilarity\Codes\picturesSource\pic',tem_index,'.jpg');
    img = imread( filename);
%     img=rgb2gray(img);
%     img=double(img);
%     A=svd(img);
%     vector_result(index,:)=A(1:20)';
    hsv = rgb2hsv( img );
    V = hsv(:,:,3);
    distribution=tabulate(V(:));
    plot(distribution(:,1),distribution(:,3));
    s=size(distribution);
    result=zeros(1,5);
    for n=1:s(1,1)
        if distribution(n,1)<0.2
        result(1,1)=result(1,1)+distribution(n,3);
        elseif distribution(n,1)<0.4
            result(1,2)=result(1,2)+distribution(n,3);
        elseif distribution(n,1)<0.6
            result(1,3)=result(1,3)+distribution(n,3);
        elseif distribution(n,1)<0.8
            result(1,4)=result(1,4)+distribution(n,3);
        else
            result(1,5)=result(1,5)+distribution(n,3);        
        end
    end
    vector_result(index,:)=result;
end
end