function [ Dist ] = dist( x,y )
[X,Y]=meshgrid(x,y);
Dist=abs(X-Y);
end

