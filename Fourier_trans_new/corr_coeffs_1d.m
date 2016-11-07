function [mea_y] = corr_coeffs_1d(Y)
siz=size(Y,1);
Y=sum(spdiags(Y));
mea_y=Y(1:siz)./(1:siz);

end


