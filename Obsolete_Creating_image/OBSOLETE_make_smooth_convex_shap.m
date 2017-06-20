function [shap]=make_smooth_convex_shap(a,b,n,theta)

% Producing shapes based on the equation ((x-c)/a)^n +
% ((y-c)/a)^n <= 1; where x and y are coordinates, a and b are semi-major
% and minor axes and c is the center coordinate set.

ang=deg2rad(theta);

rot_mat=[cos(ang),-sin(ang);sin(ang),cos(ang)];

% Semi major (r_x) and minor axes (r_y)

r_x=max(a,b);
r_y=min(a,b);

% Getting the max. size of the shape by computing the the size of the
% hypotenuse formed by the semi-major and semi-minor axes

shap_siz=2*ceil(sqrt((r_x^2)+(r_y^2)));

% Placing the shape at the center of the
% square (c_x=c_y) to allow rotation
% afterwards

c_x=((shap_siz/2)+1);
c_y=c_x;

[x_cord_shap,y_cord_shap]=meshgrid((1:shap_siz+1),(1:shap_siz+1));

% Subtracting the center from the coordinates before multiplying with the
% rotation matrix

rot_coord=rot_mat*[x_cord_shap(1:end)-c_x;y_cord_shap(1:end)-c_y];

% Adding the center to the rotated coordinates

x_rot_coord=reshape(rot_coord(1,:),size(x_cord_shap))+c_x;

y_rot_coord=reshape(rot_coord(2,:),size(y_cord_shap))+c_y;

% Shape equation

shap=(((abs(x_rot_coord-c_x)./r_x).^n) + ((abs(y_rot_coord-c_y)./r_y).^n))...
    <= (ones(shap_siz+1));

%figure;
%imshow(shap);

end

