function [shape, shape_top_left_index_global] = compute_local_shape_3D(image_top_left, res, a_b_c, exponent, shape_center_global, theta,cutoff_func)

shape_width = 2*sqrt(sum(a_b_c.^2))+6; % To ensure shape is large enough to
                                       % contain the whole shape even after
                                       % rotation 
shape_size = ceil(res*shape_width)+1;  % Adding 1 to convert distance to 
                                       % number of indices
[shape_xyz_coord_global, shape_top_left_index_global]=compute_global_coords_of_shape_3D(image_top_left, res, shape_center_global, shape_width, shape_size);

shape_xyz_coord_local = cellfun(@minus,shape_xyz_coord_global,num2cell(shape_center_global),'UniformOutput',false);

xyz_coord_grid = makegrid_3D(shape_xyz_coord_local);
xyz_coord_rotated = rotate_grid(xyz_coord_grid, theta);
shape_xyz_coord_local = abs(xyz_coord_rotated);
lhs_shape_equation_temp=bsxfun(@times, shape_xyz_coord_local, 1./a_b_c);
% Using for loop because .^ takes a lot of time
exponent=round(exponent); % Using integer values for exponent
lhs_shape_equation=compute_power(lhs_shape_equation_temp,exponent);
%lhs_shape_equation=lhs_shape_equation_temp.^exponent;
shape_in_row_slice_column_format=reshape(sum(lhs_shape_equation,1),[shape_size,shape_size,shape_size]);
shape_in_row_column_slice_format=permute(shape_in_row_slice_column_format,[1,3,2]);
shape = cutoff_func(shape_in_row_column_slice_format.^(1/exponent),res);

end

