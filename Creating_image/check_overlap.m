function [do_add] = check_overlap(shape, image, shape_top_left, overlap_func)

sz_image=size(image)';
sz_shape=size(shape)';

% Fetching image indices containing the shape 
% (with fetch_image_indices_in_shape) and the shape indices that 
% lie within the image (with fetch_shape_indices_in_image)

[gi_shape, gj_shape] = fetch_image_indices_in_shape( sz_image, sz_shape, shape_top_left); 
[li_shape_log,lj_shape_log]=fetch_shape_indices_in_image(sz_image, sz_shape, shape_top_left);
if isempty(gi_shape) || isempty(gj_shape)  
    do_add=0;
    return
end        
image_part = image(gi_shape, gj_shape);
shape_part = shape(li_shape_log, lj_shape_log);
do_add = overlap_func(image_part, shape_part);

end

