function [ar_ea_inc,peri_inc,ec_inc,tmp,nei]=mink_2d_free(i,tmp,col_img)

c_r= ceil(i/col_img); % Current row of concerned pixel in tmp, where tmp is 
                     % img with plain b.c's

c_c= i-((c_r-1)*col_img); % Current column of concerned pixel in tmp 

c_loc=(col_img+3)+((c_r-1)*col_img)+((c_r-1)*2)+c_c; % Current location of 
                                                    % concerned pixel in tmp
                                             
[nei]=get_neighbors(c_loc,col_img); %get 8 neighbors of the concerned pixel

[n_fre_edgs]=get_new_fre_edgs(tmp,nei);

[n_fre_verts]=get_new_fre_verts(tmp,nei);

[ar_ea_inc,peri_inc,ec_inc] = calc_mink_increm(n_fre_edgs,n_fre_verts);
                                             
tmp(c_loc)=1; % Adding the concerned pixel to the tmp image 

end

