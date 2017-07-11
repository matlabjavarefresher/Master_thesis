function shape_top_left_global=index2global(image_top_left_global, res,...
    shape_top_left_index_global)

shape_top_left_global = (shape_top_left_index_global/res)...
    + image_top_left_global;

end


