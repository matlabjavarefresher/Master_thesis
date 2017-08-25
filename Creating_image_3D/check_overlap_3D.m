function [do_add] = check_overlap_3D(shape, image, shape_top_left, overlap_func, shape_count)

size_image=size(image)';
size_shape=size(shape)'; 
% The below re-ordering [2;1;3] will matter when this is added
% to shape_top_left to fetch required indices, you want rows to add to x
% and columns to y and slices to z. Right now since resolution is same in
% all directions, can be removed but will be required if res changes as per
% direction
size_shape=size_shape([2;1;3]);          

% Fetching image indices containing the shape 
% (with fetch_image_indices_in_shape) and the shape indices that 
% lie within the image (with fetch_shape_indices_in_image)

[image_rows_of_shape,image_cols_of_shape,image_slices_of_shape] = fetch_image_indices_of_shape_3D( size_image, size_shape, shape_top_left); 
[shape_rows_logical,shape_cols_logical,shape_slices_logical]=fetch_shape_indices_in_image_3D(size_image, size_shape, shape_top_left);
if isempty(image_rows_of_shape) || isempty(image_cols_of_shape) ||  isempty(image_slices_of_shape) 
    do_add=0;
    return
end        
image_part = image(image_rows_of_shape,image_cols_of_shape,image_slices_of_shape);
shape_part = shape(shape_rows_logical,shape_cols_logical,shape_slices_logical);
do_add = overlap_func(image_part, shape_part, shape_count);

end

