function [add,shape_top_left_index_global]=query_new_shape_center(shape,...
    shape_center_global, image, overlap_func, shape_count)

shape_size=size(shape)';
% This re-ordering is done because we subtract shape_size from
% shape_center_global below, to subtract rows from y dimension, columns
% from x and slices from z.
shape_size=shape_size([2;1;3]);
% Subtracting 1 to move from indices to distances/lengths
shape_lengths=shape_size-1; 
% Adding 1 to move from distances/lengths to indices. Round is used to
% fix the given shape to the nearest top-left index based on the given
% center and shape.
shape_top_left_index_global=round(shape_center_global - (shape_lengths)/2 + 1);
add=check_overlap_3D(shape, image, shape_top_left_index_global, overlap_func, shape_count);

end

