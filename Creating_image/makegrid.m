function DX=makegrid(xc)
DXc = cell(size(xc,1), 1);
%xc = num2cell(x, 2);
[DXc{:}]=ndgrid(xc{:});
% DX=permute(cat(3,DXc{:}), [3, 1, 2]);
DX=permute(cat(3,DXc{:}), [3, 2, 1]);
end