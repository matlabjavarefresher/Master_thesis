function [loc_shape, IC1R1_SH, n] = compute_local_shape(X1Y1_IM, res, a, p, CXY_SH, th,cf)

w = 2*sqrt(sum(a.^2))+4;
n = ceil(res*w)+1;
[X_SH, IC1R1_SH]=compute_local_coords(X1Y1_IM, res, CXY_SH, w, n);

X_SH_C = cellfun(@minus,X_SH,num2cell(CXY_SH),'UniformOutput',false);

DX = makegrid(X_SH_C);
DX = rotate_grid(DX, th);
DX = abs(DX);
lhs_shape_equation=(abs(bsxfun(@times, DX, 1./a)).^p);
loc_shape = cf(shiftdim(sum(lhs_shape_equation,1),1).^(1/p),res);

end

