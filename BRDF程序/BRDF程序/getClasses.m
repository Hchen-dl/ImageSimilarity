function I=getClasses(vector_samples,vector_means)
%% get angles;
angles=zeros(size(vector_samples,1),size(vector_means,1));
for row=1:size(vector_samples,1)
    for col=1:size(vector_means,1)
        
        X=[vector_samples(row,:);vector_means(col,:)];   
        
        tem=corrcoef(X');
        angles(row,col)= tem(1,2);
    end
end
%% get the matching result;
[M,I]=max(angles,[],2);
