function [ad] = check_overlap(ovlp,loc_shape,imag,IC1R1_SH)
ad=0;

switch ovlp
    
    case 1
        
        ad=1;
        
    case 0
        
        [I_R_SH_REQ, I_C_SH_REQ] = fetch_image_indices_in_shape (imag,loc_shape,IC1R1_SH);
        [I_R_SH_LOG,I_C_SH_LOG]=fetch_shape_indices_in_image(imag,loc_shape,IC1R1_SH);
        
        ad=~any(any(allow_no_overlap(imag(I_R_SH_REQ,I_C_SH_REQ), loc_shape(I_R_SH_LOG,I_C_SH_LOG))));
        
    otherwise
        
        [I_R_SH_REQ, I_C_SH_REQ] = fetch_image_indices_in_shape (imag,loc_shape,IC1R1_SH);
        [I_R_SH_LOG,I_C_SH_LOG]=fetch_shape_indices_in_image(imag,loc_shape,IC1R1_SH);
         
        ad=allow_partial_overlap(imag(I_R_SH_REQ,I_C_SH_REQ), loc_shape(I_R_SH_LOG,I_C_SH_LOG),ovlp);
        
end

end

