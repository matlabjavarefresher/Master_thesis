function gxy_sh_gr=makegrid(gxy_sh_cl)
gxy_sh_gr = cell(size(gxy_sh_cl,1), 1);
%xc = num2cell(x, 2);
[gxy_sh_gr{:}]=ndgrid(gxy_sh_cl{:});
% DX=permute(cat(3,DXc{:}), [3, 1, 2]);
gxy_sh_gr=permute(cat(3,gxy_sh_gr{:}), [3, 2, 1]);
end