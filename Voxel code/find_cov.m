function [C] = find_cov( pixel_2d_mat,type)
typ=type;
switch typ;

case 1
ran=unique(ceil(ones(1,1)+(1597*rand(1,1))));
r=pixel_2d_mat(:,ran);
m=mean(r);
change=bsxfun(@minus,r,m); % Difference b/w each pixel and mean of the pixels
C=change*change';

case 2
r = reshape(pixel_2d_mat(1:100,1:100),[1,10000]); % 100 pixels * 100 pixels
m=mean(r);
change=bsxfun(@minus,r,m);
C=change'*change;
end

