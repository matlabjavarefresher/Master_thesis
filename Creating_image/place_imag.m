function imag = place_imag(imag, sh, gj1r1_sh,cmb_func)
im_sz=size(imag);
sh_sz=size(sh);
[gr_sh, gj_sh] = fetch_image_indices_in_shape (im_sz,sh_sz,gj1r1_sh);
[li_sh_log,lj_sh_log]=fetch_shape_indices_in_image(im_sz,sh_sz,gj1r1_sh);
im_rq=imag(gr_sh,gj_sh);
sh_rq=sh(li_sh_log,lj_sh_log);
imag(gr_sh,gj_sh) = cmb_func(im_rq, sh_rq);
end

