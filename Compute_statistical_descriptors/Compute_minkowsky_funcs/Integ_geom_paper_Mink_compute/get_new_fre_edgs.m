function [n_fre_edgs]=get_new_fre_edgs(tmp,nei)

n_fre_edgs=(1-tmp(nei(1)))+(1-tmp(nei(3)))+(1-tmp(nei(5)))+(1-tmp(nei(7)));

end

