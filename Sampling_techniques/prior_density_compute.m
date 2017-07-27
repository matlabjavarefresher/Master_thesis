function [p_d] = prior_density_compute(ind,val,prior_distributions)

param_dist=prior_distributions.get_params();
p_d=param_dist{ind}.pdf(val);

end

