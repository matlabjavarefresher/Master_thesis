function [go_nogo]=chk_if_shape_in_image(img,lef_top_cor,shap)

x_rang_shap=(lef_top_cor(1):1:lef_top_cor(1)+(size(shap,2)-1));
y_rang_shap=(lef_top_cor(2):1:lef_top_cor(2)+(size(shap,1)-1));

x_min_img=ones(1,size(shap,2));
x_max_img=size(img,2)*ones(1,size(shap,2));

y_min_img=ones(1,size(shap,1));
y_max_img=size(img,1)*ones(1,size(shap,1));

[c,d]=meshgrid((x_rang_shap>=x_min_img & x_rang_shap<=x_max_img),...  
    (y_rang_shap>=y_min_img & y_rang_shap<=y_max_img)); % Meshgrid of shape
                                                        % coordinates within
                                                        % the boundaries of
                                                        % the main image 


go_nogo=any(shape(c & d));  % checking if the shape coordinates obtained 
                            % from the above step contain a 1 value in the 
                            % shape array


% YOU MAY USE FIND HERE TO GET WHETHER THERE ARE ANY ELEMENTS IN SHAPE THAT
% WILL INDEED GO INTO THE MAIN IMAGE

% else if (c_x<0 && ((c_x+(size(shap,2)))<= size(img,2))) && (c_x<0 && ((c_x+(size(shap,2)))<= size(img,2))) 
%         
%         
% x2=
% 
% y1=
% y2=
% 
% req_img_area=img(y1:y2,x1:x2);
% 
% shape_bound=(x_c_glo>0 & x_c_glo<=siz(1)) & (y_c_glo>0 & y_c_glo<=siz(2));
% 
% shape_in_img=shape_bound & shap;
% 
% go_nogo=any(any(shape_in_img));
% 
% x_in_img = x_c_glo.*shape_in_img;
% x_in_img=x_in_img(x_in_img~=0);
% y_in_img = y_c_glo.*shape_in_img;
% y_in_img=y_in_img(y_in_img~=0);


end

