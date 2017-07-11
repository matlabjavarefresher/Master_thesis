function [shape, shape_top_left_index_global, shape_size] = compute_local_shape(image_top_left, res, a_b, exponent, shape_center_global, theta,cutoff_func)

shape_width = 2*sqrt(sum(a_b.^2))+4;
shape_size = ceil(res*shape_width)+1;
[shape_xy_coord_global, shape_top_left_index_global]=compute_global_coords_of_shape(image_top_left, res, shape_center_global, shape_width, shape_size);

shape_xy_coord_local = cellfun(@minus,shape_xy_coord_global,num2cell(shape_center_global),'UniformOutput',false);

xy_coord_grid = makegrid(shape_xy_coord_local);
xy_coord_rotated = rotate_grid(xy_coord_grid, theta);
shape_xy_coord_local = abs(xy_coord_rotated);
lhs_shape_equation=(abs(bsxfun(@times, shape_xy_coord_local, 1./a_b)).^exponent);
shape = cutoff_func(shiftdim(sum(lhs_shape_equation,1),1).^(1/exponent),res);

end

