function [ad]=check_overlap(over_lap,imj,s_hap,ltc_in)

ad=0; %Initialising

switch over_lap
    
    case 1
        
        ad=1;
        
    case 0
        
        [XC,YC] = global_xy_shap_in_img(s_hap,imj,ltc_in);
        
        % Contents of the image area occupied by the shape
        
        img_content=imj(YC,XC);
            
        % Local coordinates of the shape that lies within the image
        
        [xc,yc] = local_xy_shap_in_img(s_hap,imj,ltc_in);
        
        % Contents of the shape that lies within the image
        
        shp_content=s_hap(yc,xc);
        
        
        % Comparing the part of the image (extracted as shap_bound_img)
        % corresponding to the potential location of the shape on the
        % image with the part of the shape that would be placed within
        % the image bounds
        
        ad= ~(any(any( img_content & shp_content)));
        
end

end

