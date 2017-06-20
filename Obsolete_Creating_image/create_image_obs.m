function [img,shp_count]=create_image_obs(img,res,shp_type,n,max_try,ovlp,varargin)

shp_count=0;
attmpt=0;
c_x=SimParameter('c_x',UniformDistribution(-0.2*size(img,2),1.2*size(img,2)));
c_y=SimParameter('c_y',UniformDistribution(-0.2*size(img,1),1.2*size(img,1)));
c_xy_set=SimParamSet();
c_xy_set.add_parameter(c_x,c_y);
c_xy=c_xy_set.sample(max_try)';

switch shp_type
    
    case 'smooth_convex'
        
        a=varargin{1};
        b=varargin{2};
        th=varargin{3};
        pow=varargin{4};
        
        
        while (shp_count<n && attmpt<max_try)
            
            attmpt=attmpt+1;
            
            [shap]=make_smooth_convex_shape(a(attmpt),b(attmpt),c_xy(attmpt,:),pow(attmpt),th(attmpt));
                  
            [scaled_shape]=scale_shape_as_per_res(shap,res);
            
            [a_,b_]=scale_dimns_as_per_res(res,a(attmpt),b(attmpt));
            
            [l_t_c]=get_l_t_c(c_xy(attmpt,:),a_,b_);
            
            [ad]=check_overlap(ovlp,img,scaled_shape,l_t_c);
            
            if ad==0
                continue;
            end
            
            [img]=add_shape(img,scaled_shape,l_t_c);
            
            shp_count=shp_count+1;
            
        end
        
end


end

