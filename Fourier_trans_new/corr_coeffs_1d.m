function [mea_y] = corr_coeffs_1d(Y)

%siz=size(Y,1);
Y=sum(spdiags(Y));
mea_y=Y(1:length(Y))./(1:length(Y))

end


