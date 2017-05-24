function [img]=add_shape(img,shap,lef_top_cor)

% Fetching the global xy coordinates of the shape that would be placed
% within the bounds of the image

[x_rang_in_img,y_rang_in_img] = global_xy_shap_in_img(shap,img,lef_top_cor);

% Getting the size of the image onto which the shape will get placed

siz_shap_on_img=size(img(y_rang_in_img,x_rang_in_img));

% Logical array (loc_xy) with 1's corresponding to the local coordinates
% of the shape that lies within the image

[loc_x,loc_y] = local_xy_shap_in_img(shap,img,lef_top_cor);
loc_xy=loc_x & loc_y;

% Adding the extracted shape (part of the shape that would get placed
% within the image bounds) to the extracted image (part of the image that
% would be occupied by the shape)

img(y_rang_in_img,x_rang_in_img)=img(y_rang_in_img,x_rang_in_img) | reshape(shap(loc_xy),...
    siz_shap_on_img);

end

