function [ad]=check_overlap(over_lap,img,shap,lef_top_cor)

ad=0; %Initialising

switch over_lap
    
    case 1
        
        ad=1;
        
    case 0
        
        [x_rang_in_img,y_rang_in_img] = global_xy_shap_in_img(shap,img,lef_top_cor);
        
        % Contents of the image area occupied by the shape
        
        shap_bound_img=img(y_rang_in_img,x_rang_in_img);
        siz_shap_on_img=size(shap_bound_img);
        
        % Logical arrays (x and y) corresponding to the local coordinates
        % of the shape that lies within the image
        
        [loc_x,loc_y] = local_xy_shap_in_img(shap,img,lef_top_cor);
        
        % Comparing the part of the image (extracted as shap_bound_img)
        % corresponding to the potential location of the shape on the
        % image with the part of the shape that would be placed within
        % the image bounds
        
        ad= ~(any(any( shap_bound_img & reshape(shap(loc_x & loc_y),siz_shap_on_img))));
        
end

end

