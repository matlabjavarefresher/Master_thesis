function [do_add] = check_overlap(shape, image, shape_top_left, overlap_func, shape_count)

size_image=size(image)';
size_shape=size(shape')';

% Fetching image indices containing the shape 
% (with fetch_image_indices_in_shape) and the shape indices that 
% lie within the image (with fetch_shape_indices_in_image)

[image_rows_of_shape,image_cols_of_shape] = fetch_image_indices_of_shape( size_image, size_shape, shape_top_left); 
[shape_rows_logical,shape_cols_logical]=fetch_shape_indices_in_image(size_image, size_shape, shape_top_left);
if isempty(image_rows_of_shape) || isempty(image_cols_of_shape)  
    do_add=0;
    return
end        
image_part = image(image_rows_of_shape,image_cols_of_shape);
shape_part = shape(shape_rows_logical,shape_cols_logical);
do_add = overlap_func(image_part, shape_part, shape_count);

end

