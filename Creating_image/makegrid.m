function xy_coord_grid=makegrid(shape_xy_coord_local)
xy_coord_grid = cell(size(shape_xy_coord_local,1), 1);
%xc = num2cell(x, 2);
[xy_coord_grid{:}]=ndgrid(shape_xy_coord_local{:});
% DX=permute(cat(3,DXc{:}), [3, 1, 2]);
xy_coord_grid=permute(cat(3,xy_coord_grid{:}), [3, 2, 1]);
end