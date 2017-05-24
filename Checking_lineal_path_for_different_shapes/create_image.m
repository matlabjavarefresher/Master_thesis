function [img,shap_count]=create_image(img,shape_typ,n,max_try,over_lap,varargin)

shap_count=0;
attmpt=0;
l_t_c_x=SimParameter('l_t_c_x',UniformDistribution(-0.2*size(img,2),1.2*size(img,2)));
l_t_c_y=SimParameter('l_t_c_y',UniformDistribution(-0.2*size(img,1),1.2*size(img,1)));
l_t_c_set=SimParamSet();
l_t_c_set.add_parameter(l_t_c_x,l_t_c_y);
lef_top_cor=round(l_t_c_set.sample(max_try, 'mode', 'qmc'))';

switch shape_typ
    
    case 'circle'
        
        r=varargin{1};
        
        while (shap_count<n && attmpt<max_try)
            attmpt=attmpt+1;
            [circ]=make_circle(r(attmpt));
            
            [ad]=check_overlap(over_lap,img,circ,lef_top_cor(attmpt,:));
            
            if ad==0
                continue;
            end
            
            [img]=add_shape(img,circ,lef_top_cor(attmpt,:));
            shap_count=shap_count+1;
        end
        
    case 'ellipse'
        
        a=varargin{1};
        b=varargin{2};
        theta=varargin{3};
        
        while (shap_count<n && attmpt<max_try)
            attmpt=attmpt+1;
            [shap]=make_ellipse(a(attmpt),b(attmpt),theta(attmpt));
            
            [ad]=check_overlap(over_lap,img,shap,lef_top_cor(attmpt,:));
            
            if ad==0
                continue;
            end
            
            [img]=add_shape(img,shap,lef_top_cor(attmpt,:));
            shap_count=shap_count+1;
            
        end
        
        
    case 'smooth_convex'
        
        a=varargin{1};
        b=varargin{2};
        theta=varargin{3};
        pow=varargin{4};
        
        
        while (shap_count<n && attmpt<max_try)
            attmpt=attmpt+1;
            [shap]=make_smooth_convex_shap(a(attmpt),b(attmpt),pow(attmpt),theta(attmpt));
            
            [ad]=check_overlap(over_lap,img,shap,lef_top_cor(attmpt,:));
            
            if ad==0
                continue;
            end
            
            [img]=add_shape(img,shap,lef_top_cor(attmpt,:));
            %figure;
            %imshow(img);
            shap_count=shap_count+1;
        end
        
end


end

