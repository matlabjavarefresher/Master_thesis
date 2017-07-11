function shape_top_left_index_global=global2index(image_top_left, res, ...
    shape_top_left_global, round_func)

if nargin<4
    round_func = @round;
end

shape_top_left_index_global = round_func((shape_top_left_global-...
    image_top_left)*res);

end

