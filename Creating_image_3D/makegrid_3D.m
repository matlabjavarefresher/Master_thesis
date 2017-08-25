function xyz_coord_grid=makegrid_3D(shape_xyz_coord_local)
xyz_coord_grid = cell(size(shape_xyz_coord_local,1), 1);

%xc = num2cell(x, 2);
[xyz_coord_grid{:}]=ndgrid(shape_xyz_coord_local{:});
siz=size(xyz_coord_grid{1});
temporary_1=cellfun(@(x) reshape(x,siz(1),[],1),xyz_coord_grid,'un',0);
temporary_2=cat(3,temporary_1{:});
% DX=permute(cat(3,DXc{:}), [3, 1, 2]);
xyz_coord_grid=permute(temporary_2, [3, 2, 1]);
end