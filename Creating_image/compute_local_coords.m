function [X_SH, IC1R1_SH]=compute_local_coords(X1Y1_IM, res, CXY_SH, w, n)

X1Y1_SH = CXY_SH - w/2;
IC1R1_SH = global2index(X1Y1_IM, res, X1Y1_SH, @floor);
X1_SH = index2global(X1Y1_IM, res, IC1R1_SH);
X2_SH = X1_SH + n ./ res;

% Why not linspace(0,1,round(a)) and linspace(0,1,round(b))

X_SH {1,1}= bsxfun(@plus, X1_SH(1), bsxfun(@times, X2_SH(1)-X1_SH(1), linspace(0, 1,n)));
X_SH {2,1}= bsxfun(@plus, X1_SH(2), bsxfun(@times, X2_SH(2)-X1_SH(2), linspace(0, 1,n)));

end


