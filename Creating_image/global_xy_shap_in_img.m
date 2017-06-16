function [X_cord,Y_cord] = global_xy_shap_in_img(shap_in,img_in,ltc_in)

% Computes the global coordinates of the part of the shape
% that gets placed within the bounds of the image

% Getting the size of the shape and image

s_rws=size(shap_in,1);
s_clms=size(shap_in,2);

im_rws=size(img_in,1);
im_clms=size(img_in,2);

% Global x,y coordinates of the shape within the image boundaries

X_cord=(max(1,ltc_in(1)):min(im_clms,ltc_in(1)+s_clms-1));
Y_cord=(max(1,ltc_in(2)):min(im_rws,ltc_in(2)+s_rws-1));

end

