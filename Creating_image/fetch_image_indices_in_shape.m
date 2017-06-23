function [gr_sh, gj_sh] = fetch_image_indices_in_shape (im_sz,sh_sz,gj1i1_sh)

[li_sh_log,lj_sh_log]=fetch_shape_indices_in_image(im_sz,sh_sz,gj1i1_sh);

gj_sh = gj1i1_sh(1) + find(lj_sh_log) -1;
gr_sh = gj1i1_sh(2) + find(li_sh_log) -1;

end

