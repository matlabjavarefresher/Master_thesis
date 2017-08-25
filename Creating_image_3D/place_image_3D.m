function image = place_image_3D(image, shape, shape_top_left, combine_func)

size_image = size(image)';
size_shape = size(shape)';
% The below re-ordering [2;1;3] will matter when this is added to
% shape_top_left to fetch required indices, you want rows to add to x and
% columns to y and slices to z. Right now since resolution is same in all
% directions, can be removed but will be required if res changes as per
% direction
size_shape= size_shape([2;1;3]);

[image_rows_of_shape,image_cols_of_shape,image_slices_of_shape] = fetch_image_indices_of_shape_3D(size_image, size_shape, shape_top_left);
[shape_rows_logical,shape_cols_logical,shape_slices_logical] = fetch_shape_indices_in_image_3D(size_image, size_shape, shape_top_left);

image_part = image(image_rows_of_shape,image_cols_of_shape,image_slices_of_shape);
shape_part = shape(shape_rows_logical,shape_cols_logical,shape_slices_logical);
image(image_rows_of_shape,image_cols_of_shape,image_slices_of_shape) = combine_func(image_part, shape_part);
end

