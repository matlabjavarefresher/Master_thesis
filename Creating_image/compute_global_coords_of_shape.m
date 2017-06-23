function [gxy_sh, gj1i1_sh]=compute_global_coords_of_shape(gx1y1, res, gcxy_sh, w, ln)

gx1y1_sh = gcxy_sh - w/2;% The initial global x1y1 coordinates of the shape  
gj1i1_sh = global2index(gx1y1, res, gx1y1_sh, @floor);
gx1y1_sh = index2global(gx1y1, res, gj1i1_sh); % The new global x1y1 
                                              % coordinates  (after
                                              % flooring, global to index
                                              % and index to global 
                                              % operations) of the
                                              % shape 

gx2y2_sh = gx1y1_sh + ln ./ res;
gxy_sh {1,1}= bsxfun(@plus, gx1y1_sh(1), bsxfun(@times, gx2y2_sh(1)-...
    gx1y1_sh(1), linspace(0, 1,ln)));
gxy_sh {2,1}= bsxfun(@plus, gx1y1_sh(2), bsxfun(@times, gx2y2_sh(2)-...
    gx1y1_sh(2), linspace(0, 1,ln)));

end


