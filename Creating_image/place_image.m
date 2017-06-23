function image = place_image(image, shape, shape_top_left, combine_func)

sz_image = size(image)';
sz_shape = size(shape)';
[gi_shape, gj_shape] = fetch_image_indices_in_shape(sz_image, sz_shape, shape_top_left);
[li_shape_log,lj_shape_log] = fetch_shape_indices_in_image(sz_image, sz_shape, shape_top_left);

image_part = image(gi_shape, gj_shape);
shape_part = shape(li_shape_log, lj_shape_log);
image(gi_shape, gj_shape) = combine_func(image_part, shape_part);
end

