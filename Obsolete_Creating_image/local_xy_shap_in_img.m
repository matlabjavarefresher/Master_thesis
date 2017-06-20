function [x_ind,y_ind] = local_xy_shap_in_img(shap,img,lef_top_cor)

% Getting the size of the shape and image

s_rws=size(shap,1);
s_clms=size(shap,2);

im_rws=size(img,1);
im_clms=size(img,2);


% Setting the x,y bounds of the image as vectors for comparison with
% the shape's global coordinates

X_min=ones(1,s_clms);
X_max=im_clms*ones(1,s_clms);

Y_min=ones(1,s_rws);
Y_max=im_rws*ones(1,s_rws);

% global x,y coordinates of the shape

X_coord=(lef_top_cor(1):1:lef_top_cor(1)+(s_clms-1));
Y_coord=(lef_top_cor(2):1:lef_top_cor(2)+(s_rws-1));

% local x,y coordinates of the shape

x_coord=1:s_clms;
y_coord=1:s_rws;

% Indices of the shape that lie within the image boundaries

x_ind= x_coord(X_coord>=X_min & X_coord<=X_max);
y_ind= y_coord(Y_coord>=Y_min & Y_coord<=Y_max);

end

