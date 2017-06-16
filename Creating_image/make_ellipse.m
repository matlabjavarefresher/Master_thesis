function [shap]=make_ellipse(a,b,theta)

% Setting the rotation matrix

ang=deg2rad(theta);

rot_mat=[cos(ang),-sin(ang);sin(ang),cos(ang)];

% Semi major (r_x) and minor axes (r_y)

r_x=max(a,b);
r_y=min(a,b);

% Setting the background array for the shape with a size equal to
% (major axis + 1) * (major axis + 1)

shap_siz=2*r_x;

% Placing the shape at the center of the
% square (c_x=c_y) to allow rotation
% afterwards

c_x=(r_x+1);
c_y=(r_x+1);

[x_cord_shap,y_cord_shap]=meshgrid((1:shap_siz+1),(1:shap_siz+1));

% Subtracting the center from the coordinates before multiplying with the
% rotation matrix

rot_coord=rot_mat*[x_cord_shap(1:end)-c_x;y_cord_shap(1:end)-c_y];

% Adding the center to the rotated coordinates

x_rot_coord=reshape(rot_coord(1,:),size(x_cord_shap))+c_x;

y_rot_coord=reshape(rot_coord(2,:),size(y_cord_shap))+c_y;

% Ellipse equation

shap=((((x_rot_coord-c_x)./r_x).^2) + (((y_rot_coord-c_y)./r_y).^2))...
    <= (ones(shap_siz+1));


end

