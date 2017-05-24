function [a_c_wrt_dist] = extract_corr_wrt_dist(a_c_coeff)

% extracting 

siz=size(a_c_coeff,1);
diags=spdiags(a_c_coeff,(-(siz-1):1:siz-1));
req_diags=diags(:,siz:end);
a_c_wrt_dist=(sum(req_diags,1))./(siz:-1:1);

end

