function vector_result=getModlePictureVector(filepath)
%filepath 图片所在文件夹/the directory of the pictures
pics=dir(strcat(filepath,'\*.jpg'));
vector_result=[];
for index=2:2:length(pics)
    filename=strcat(filepath,'\',pics(index).name);
    %tem_index=num2str(index);
    %filepath=strcat('E:\FirstYear\ImageSimilarity\Codes\picturesSource\pic',tem_index,'.jpg');
    img = imread( filename);
    hsv = rgb2hsv( img );
    %H = hsv( :,:,1);
    %S = hsv( :,:,2);
    V = hsv(:,:,3);
    distribution=tabulate(V(:));
    s=size(distribution);
    result=zeros(1,20);
    for n=1:s(1,1)
        if distribution(n,1)<0.05 
        result(1,1)=result(1,1)+distribution(n,3);
        elseif distribution(n,1)<0.1
            result(1,2)=result(1,2)+distribution(n,3);
        elseif distribution(n,1)<0.15
            result(1,3)=result(1,3)+distribution(n,3);
        elseif distribution(n,1)<0.20
            result(1,4)=result(1,4)+distribution(n,3);
        elseif distribution(n,1)<0.25
            result(1,5)=result(1,5)+distribution(n,3);
        elseif distribution(n,1)<0.30
            result(1,6)=result(1,6)+distribution(n,3);
        elseif distribution(n,1)<0.35
            result(1,7)=result(1,7)+distribution(n,3);
            elseif distribution(n,1)<0.40
            result(1,8)=result(1,8)+distribution(n,3);
            elseif distribution(n,1)<0.45
            result(1,9)=result(1,9)+distribution(n,3);
            elseif distribution(n,1)<0.5
            result(1,10)=result(1,10)+distribution(n,3);
            elseif distribution(n,1)<0.55
            result(1,11)=result(1,11)+distribution(n,3);
            elseif distribution(n,1)<0.60
            result(1,12)=result(1,12)+distribution(n,3);
            elseif distribution(n,1)<0.65
            result(1,13)=result(1,13)+distribution(n,3);
            elseif distribution(n,1)<0.40
            result(1,14)=result(1,14)+distribution(n,3);
            elseif distribution(n,1)<0.75
            result(1,15)=result(1,15)+distribution(n,3);
            elseif distribution(n,1)<0.8
            result(1,16)=result(1,16)+distribution(n,3);
            elseif distribution(n,1)<0.85
            result(1,17)=result(1,17)+distribution(n,3);
            elseif distribution(n,1)<0.9
            result(1,18)=result(1,18)+distribution(n,3);
            elseif distribution(n,1)<0.95
            result(1,19)=result(1,19)+distribution(n,3);
        else 
            result(1,20)=result(1,20)+distribution(n,3);
        end
    end
    vector_result=[vector_result
    result];
end
end
