function [li_sh_log,lj_sh_log]=fetch_shape_indices_in_image(im_sz,sh_sz,gj1_i1_sh)

gj2i2_sh=gj1_i1_sh+[sh_sz(2);sh_sz(1)]-1;
g_j_sh=gj1_i1_sh(1):gj2i2_sh(1);
g_i_sh=gj1_i1_sh(2):gj2i2_sh(2);

lj_sh_log = g_j_sh>=1 & g_j_sh<=im_sz(2);
li_sh_log = g_i_sh>=1 & g_i_sh<=im_sz(1);
end


