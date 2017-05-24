function [loc_rws,loc_cols] = local_xy_shap_in_img(shap,img,lef_top_cor)

% Getting the size of the shape and image

s_rws=size(shap,1);
s_clms=size(shap,2);

im_rws=size(img,1);
im_clms=size(img,2);


% Setting the x,y bounds of the image as vectors for comparison with
% the shape's global coordinates

x_min_img=ones(1,s_clms);
x_max_img=im_clms*ones(1,s_clms);

y_min_img=ones(1,s_rws);
y_max_img=im_rws*ones(1,s_rws);

% global x,y coordinates of the shape

x_rang_shap=(lef_top_cor(1):1:lef_top_cor(1)+(s_clms-1));
y_rang_shap=(lef_top_cor(2):1:lef_top_cor(2)+(s_rws-1));

% Logical values of the shape that lies within the image boundaries

[loc_rws,loc_cols]=meshgrid((x_rang_shap>=x_min_img & x_rang_shap<=x_max_img),...
    (y_rang_shap>=y_min_img & y_rang_shap<=y_max_img));

end

