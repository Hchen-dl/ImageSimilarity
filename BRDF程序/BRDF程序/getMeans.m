function vector_means=getMeans(vector_results,vector_catagory)
%vector_results:要求均值的矩阵;
%vector_catagory:所求均值的节点，如：想求1~5；6~10的均值则vector_catagory=[5，10];
%% init
vector_means=zeros(size(vector_catagory,2),size(vector_results,2));
start_row=0;
end_row=0;
%% caculate the means;
for group=1:size(vector_catagory,2)
    start_row=end_row+1;
    end_row=vector_catagory(group);
    vector_means(group,:)=mean(vector_results(start_row:end_row,:),1);
end