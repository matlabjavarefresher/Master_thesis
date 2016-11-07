function [Y] = cov_1d(y)

[Y1,Y2]=meshgrid(y,y);
Y=(Y1-mean(y)).*(Y2-mean(y));


end

