function [image_rows_of_shape,image_cols_of_shape,image_slices_of_shape] = fetch_image_indices_of_shape_3D (size_image, size_shape, shape_top_left)

[shape_rows_logical,shape_cols_logical,shape_slices_logical]=fetch_shape_indices_in_image_3D(size_image, size_shape, shape_top_left);

% Below the y coordinate of shape_top_left is added to the rows in  
image_rows_of_shape = shape_top_left(2) + find(shape_rows_logical) -1;
image_cols_of_shape = shape_top_left(1) + find(shape_cols_logical) -1;
image_slices_of_shape = shape_top_left(3) + find(shape_slices_logical) -1;
end

