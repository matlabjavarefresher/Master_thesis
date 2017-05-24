function [n_fre_verts]=get_new_fre_verts(tmp,nei)

% From the upper right vertex, going clockwise to check which of the four
% vertices are fully free, meaning all neighbousing pixels sharing that
% vertex are unoccupied (or white pixels).


u_r=(1-tmp(nei(1)))*(1-tmp(nei(2)))*(1-tmp(nei(3))); % Checking if upper
                                                     % right vertex is free
l_r=(1-tmp(nei(3)))*(1-tmp(nei(4)))*(1-tmp(nei(5))); 
l_l=(1-tmp(nei(5)))*(1-tmp(nei(6)))*(1-tmp(nei(7)));
u_l=(1-tmp(nei(7)))*(1-tmp(nei(8)))*(1-tmp(nei(1)));

n_fre_verts=u_r+l_r+l_l+u_l; 


end

