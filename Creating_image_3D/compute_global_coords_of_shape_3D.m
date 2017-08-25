function [shape_xyz_coord_global, shape_top_left_index_global]=compute_global_coords_of_shape_3D...
    (image_top_left, res, shape_center_global, shape_width, shape_size)

shape_top_left_global = shape_center_global - shape_width/2;  
shape_top_left_index_global = global2index(image_top_left, res, shape_top_left_global, @floor);

% The new global x1y1 coordinates  (after flooring, global to index
% and index to global operations) of the shape
shape_top_left_global = index2global(image_top_left, res, shape_top_left_index_global); 
                                              
% Note shape_size is a scalar because shape size is aXb where a=b
shape_bottom_right_global = shape_top_left_global + shape_size / res;
shape_xyz_coord_global {1,1}= bsxfun(@plus, shape_top_left_global(1), bsxfun(@times, shape_bottom_right_global(1)-...
    shape_top_left_global(1), linspace(0, 1,shape_size)));
shape_xyz_coord_global {2,1}= bsxfun(@plus, shape_top_left_global(2), bsxfun(@times, shape_bottom_right_global(2)-...
    shape_top_left_global(2), linspace(0, 1,shape_size)));
shape_xyz_coord_global {3,1}= bsxfun(@plus, shape_top_left_global(3), bsxfun(@times, shape_bottom_right_global(3)-...
    shape_top_left_global(3), linspace(0, 1,shape_size)));

end


