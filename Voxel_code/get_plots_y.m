function [cor,ran] = get_plots_y(pixel_2d_mat,num)
% Selecting different columns of pixels and generating avg. correlation
% coefficients vs. distance b/w pixels plots

%generating random columns to pick
ran=unique(ceil(ones(num,1)+(1596*rand(num,1))));
m=mean(reshape(pixel_2d_mat,size(pixel_2d_mat,1)*size(pixel_2d_mat,2),1));
if size(ran)< 1550
    
size(ran)
p=1;%keeping track of iteration

for j=1:size(ran)
    col=pixel_2d_mat(:,ran(j));
    change=bsxfun(@minus,col,m); % Difference b/w each pixel and mean of the pixels
    C=change*change'; % Finding covariance
    sigma=sqrt(diag(C));
    Cor=C./(sigma*sigma');
    cor_=sum(spdiags(Cor));
    cor(p,1:1639)=cor_(1639:3277)./[1639:-1:1];
    y=[0:1638];
%   figure;
%   plot(y,cor);
    p=p+1;
end

end

end

