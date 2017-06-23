function [li_shape_log,lj_shape_log]=fetch_shape_indices_in_image(sz_image, sz_shape, shape_top_left)

shape_bottom_right=shape_top_left + sz_shape - 1;
gi_shape=shape_top_left(1):shape_bottom_right(1);
gj_shape=shape_top_left(2):shape_bottom_right(2);

li_shape_log = gi_shape>=1 & gi_shape<=sz_image(1);
lj_shape_log = gj_shape>=1 & gj_shape<=sz_image(2);
end
