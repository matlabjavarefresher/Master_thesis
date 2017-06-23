function [sh, gj1i1_sh, ln] = compute_local_shape(gx1y1, res, a, p, gcxy_sh, th,cf)

w = 2*sqrt(sum(a.^2))+4;
ln = ceil(res*w)+1;
[gxy_sh, gj1i1_sh]=compute_global_coords_of_shape(gx1y1, res, gcxy_sh, w, ln);

gxy_sh_cl = cellfun(@minus,gxy_sh,num2cell(gcxy_sh),'UniformOutput',false);

gxy_sh_gr = makegrid(gxy_sh_cl);
gxy_sh_rot = rotate_grid(gxy_sh_gr, th);
gxy_sh = abs(gxy_sh_rot);
lhs_sh_eq=(abs(bsxfun(@times, gxy_sh, 1./a)).^p);
sh = cf(shiftdim(sum(lhs_sh_eq,1),1).^(1/p),res);

end

