function [x_rang_in_img,y_rang_in_img] = global_xy_shap_in_img(shap,img,lef_top_cor)

% Computes the global coordinates of the part of the shape
% that gets placed within the bounds of the image

% Getting the size of the shape and image

s_rws=size(shap,1);
s_clms=size(shap,2);

im_rws=size(img,1);
im_clms=size(img,2);

% Global x,y coordinates of the shape within the image boundaries

x_rang_in_img=(max(1,lef_top_cor(1)):min(im_clms,lef_top_cor(1)+s_clms-1));
y_rang_in_img=(max(1,lef_top_cor(2)):min(im_rws,lef_top_cor(2)+s_rws-1));

end

