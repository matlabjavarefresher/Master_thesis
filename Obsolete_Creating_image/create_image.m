function [imag,shp_count]=create_image(imag,res,NS,ovlp,max_try,shp_type,X1Y1_IM,S,cf,cof,varargin)

shp_count=0;
attmpt=0;


switch shp_type
    
    case 'smooth_convex'
        S_sam=S.sample(max_try);
        a=S_sam(1,:);
        b=S_sam(2,:);
        th=S_sam(3,:);
        pow=S_sam(4,:);
        C_XY=[S_sam(5,:);S_sam(6,:)];
        
        
        while (shp_count<NS && attmpt<max_try)
            
            attmpt=attmpt+1;
            
            [loc_shape, IC1R1_SH] = compute_local_shape(X1Y1_IM, res, [a(attmpt);b(attmpt)], pow(attmpt), C_XY(:,attmpt), th(attmpt),cf);
            
            [ad]=check_overlap(ovlp,loc_shape,imag,IC1R1_SH);
            
            if ad==0
                continue;
            end
            
            imag = place_imag(imag, loc_shape, IC1R1_SH,cof);
            
            shp_count=shp_count+1;
            
        end
        
end


end

