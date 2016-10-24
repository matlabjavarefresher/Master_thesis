function [cor,ran] = get_plots_x(pixel_2d_mat,num)
% Selecting different rows of pixels and generating avg. correlation coefficients 
% vs. distance b/w pixels plots

%generating random rows to pick
ran=unique(ceil(ones(num,1)+(1638*rand(num,1))));
m=mean(reshape(pixel_2d_mat,size(pixel_2d_mat,1)*size(pixel_2d_mat,2),1));
if size(ran)< 1600
    
size(ran)
p=1;%keeping track of iteration

for i=1:size(ran)
     
    r=pixel_2d_mat(ran(i),:);
    change=bsxfun(@minus,r,m); % Difference b/w each pixel and mean of the pixels
    C=change'*change; % Finding covariance
    sigma=sqrt(diag(C));% Variance
    Cor=C./(sigma*sigma');%Correlation coefficients matrix
    cor_=sum(spdiags(Cor));
    cor(p,1:1597)=cor_(1597:3193)./[1597:-1:1];
    x=[0:1596];
   % figure;
   % plot(x,cor);
    p=p+1;
end

end

end

