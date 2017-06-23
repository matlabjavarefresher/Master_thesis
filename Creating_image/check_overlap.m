function [do_add] = check_overlap(ovlp,sh,imag,gj1i1_sh,ov_fn,res,am_bm)

do_add=0;

switch ovlp
    
    case 1
        
        do_add=1;
        
    case 0
        im_sz=size(imag);
        sh_sz=size(sh);
        
        % Fetching image indices containing the shape 
        % (with fetch_image_indices_in_shape) and the shape indices that 
        % lie within the image (with fetch_shape_indices_in_image)
        
        [gr_sh, gj_sh] = fetch_image_indices_in_shape (im_sz,sh_sz,gj1i1_sh); 
        [li_sh_log,lj_sh_log]=fetch_shape_indices_in_image(im_sz,sh_sz,gj1i1_sh);
        if isempty(gr_sh) || isempty(gj_sh)  
            do_add=0;
            return
        end        
        im_rq=imag(gr_sh,gj_sh);
        sh_rq=sh(li_sh_log,lj_sh_log);
        do_add=ov_fn(im_rq,sh_rq,res,am_bm);
        
        %  ad=~any(any(allow_no_overlap(imag(I_R_SH_REQ,I_C_SH_REQ), sh(I_R_SH_LOG,I_C_SH_LOG))));
        
        
        
        
end

end

