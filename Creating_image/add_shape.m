function [imag]=add_shape(imag,sh_ap,lef_top_cor)

% Fetching the global xy coordinates of the shape that would be placed
% within the bounds of the image

[X_co,Y_co] = global_xy_shap_in_img(sh_ap,imag,lef_top_cor);

% Local coordinates of the shape that lies within the image

[x_co,y_co] = local_xy_shap_in_img(sh_ap,imag,lef_top_cor);

% Adding the extracted shape (part of the shape that would get placed
% within the image bounds) to the extracted image (part of the image that
% would be occupied by the shape)

imag(Y_co,X_co)=imag(Y_co,X_co) | sh_ap(y_co,x_co);

end

