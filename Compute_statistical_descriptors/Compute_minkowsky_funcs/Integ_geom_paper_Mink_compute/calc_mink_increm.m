function [ar_ea_inc,peri_inc,ec_inc] = calc_mink_increm(n_fre_edgs,n_fre_verts)

% Computing Mink funcs increments using the formula specified in 
% INTEGRAL-GEOMETRY MORPHOLOGICAL IMAGE ANALYSIS, K.Michielsen et al., 2000 

ar_ea_inc=1;
peri_inc=-4+(2*n_fre_edgs);
ec_inc=1+(-1*n_fre_edgs)+(1*n_fre_verts);

%ar_ea_inc_cor=1-n_fre_steps;
%peri_inc_cor=-4+(2*n_fre_edgs)-(((2-sqrt(2))/2)*n_fre_steps);

%corr_ar_per=[ar_ea_inc_cor;peri_inc_cor];

end


