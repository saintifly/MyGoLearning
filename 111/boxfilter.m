function sum=boxfilter(patch_darkchanel,r)
   
[m,n]=size(patch_darkchanel);


sum_row = cumsum(patch_darkchanel,1);

sum=zeros(m,n);

sum(1:r+1,:) = sum_row(r+1:2*r+1,:);
sum(r+2:m-r,:) = sum_row(2*r+2:m,:)-sum_row(2:m-2*r,:);
sum(m-r+1:m,:) = ones(r,1)*sum_row(m,:)-sum_row(m-2*r+1:m-r,:);

sum_array= cumsum(sum,2);

sum(:,1:r+1) = sum_array(:,r+1:2*r+1);
sum(:,r+2:n-r) = sum_array(:,2*r+2:n)-sum_array(:,2:n-2*r);
sum(:,n-r+1:n) = sum_array(:,n)*ones(1,r)-sum_array(:,n-2*r+1:n-r);



