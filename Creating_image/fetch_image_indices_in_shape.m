function [gi_shape, gj_shape] = fetch_image_indices_in_shape (sz_image,sz_shape, shape_top_left)

[li_shape_log,lj_shape_log]=fetch_shape_indices_in_image(sz_image,sz_shape,shape_top_left);

gi_shape = shape_top_left(1) + find(li_shape_log) -1;
gj_shape = shape_top_left(2) + find(lj_shape_log) -1;

end

