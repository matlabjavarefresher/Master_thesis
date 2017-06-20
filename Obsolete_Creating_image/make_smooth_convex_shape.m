function [shap]=make_smooth_convex_shape(a,b,loc,n,ang)

% % Producing shapes based on the equation ((x-loc(1))/a)^n +
% % ((y-loc(2))/b)^n <= 1; where x and y are coordinates, a and b are
% % semi-major and minor axes and loc is the center coordinate set.

c_x=loc(1);
c_y=loc(2);

% Required width of the shape to allow for shape rotation so as
% to include the whole shape (preventing cutting-off of any portion of
% the shape)

w=2*sqrt(a^2+b^2);

% Computing the beginning and end of the shape in global coords

X1=floor(c_x-w/2);
Y1=floor(c_y-w/2);


X2=ceil(c_x+w/2);
Y2=ceil(c_y+w/2);

% Fetching the shape's local coordinates

x=(X1:X2)-(c_x);

y=(Y1:Y2)-(c_y);

[xx,yy]=meshgrid(x,y);

% To rotate the shape by the given angle (ang)

rot_mat=[cos(ang),-sin(ang);sin(ang),cos(ang)];

xr=(rot_mat(1,1)*xx)+(rot_mat(1,2)*yy);

yr=(rot_mat(2,1)*xx)+(rot_mat(2,2)*yy);

shap=(((abs(xr)/a).^n) + ((abs(yr)/b).^n))...
    <= (ones(size(xx)));

end



