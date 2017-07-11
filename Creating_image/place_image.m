function image = place_image(image, shape, shape_top_left, combine_func)

sz_image = size(image)';
sz_shape = size(shape)';
[image_rows_of_shape,image_cols_of_shape] = fetch_image_indices_of_shape(sz_image, sz_shape, shape_top_left);
[shape_rows_logical,shape_cols_logical] = fetch_shape_indices_in_image(sz_image, sz_shape, shape_top_left);

image_part = image(image_rows_of_shape,image_cols_of_shape);
shape_part = shape(shape_rows_logical,shape_cols_logical);
image(image_rows_of_shape,image_cols_of_shape) = combine_func(image_part, shape_part);
end

