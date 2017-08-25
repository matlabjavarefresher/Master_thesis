function [n_fre_steps]=get_new_steps(img_stps,nei)
% Computes number of steps as per the formula in K Michielsen et al., 
% Integral-geometry morphological image analysis, 2000, page 528.

u_r_steps=img_stps(nei(2))*((1-img_stps(nei(1)))+(1-img_stps(nei(3))));
l_r_steps=img_stps(nei(4))*((1-img_stps(nei(3)))+(1-img_stps(nei(5))));
l_l_steps=img_stps(nei(6))*((1-img_stps(nei(5)))+(1-img_stps(nei(7))));
u_l_steps=img_stps(nei(8))*((1-img_stps(nei(7)))+(1-img_stps(nei(1))));

n_fre_steps=u_r_steps+l_r_steps+l_l_steps+u_l_steps;

end

