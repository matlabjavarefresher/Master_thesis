function [shape_xy_coord_global, shape_top_left_index_global]=compute_global_coords_of_shape...
    (image_top_left, res, shape_center_global, shape_width, shape_size)


shape_top_left_global = shape_center_global - shape_width/2;  
% Shape top left index is computed by subtracting shape top left coordinates 
% by image top left coordinates and flooring the result. Flooring is done
% to get the index to ensure that we do not miss out any part of the shape
shape_top_left_index_global = global2index(image_top_left, res, shape_top_left_global, @floor);

% The new global x1y1 coordinates  (after flooring and accommodating the 
% resolution i.e. global to index and index to global operations) of the shape
shape_top_left_global = index2global(image_top_left, res, shape_top_left_index_global); 
                                              
% Note shape_size is a scalar because shape size is aXb where a=b
shape_bottom_right_global = shape_top_left_global + shape_size / res;
shape_xy_coord_global {1,1}= bsxfun(@plus, shape_top_left_global(1), bsxfun(@times, shape_bottom_right_global(1)-...
    shape_top_left_global(1), linspace(0, 1,shape_size)));
shape_xy_coord_global {2,1}= bsxfun(@plus, shape_top_left_global(2), bsxfun(@times, shape_bottom_right_global(2)-...
    shape_top_left_global(2), linspace(0, 1,shape_size)));

end


