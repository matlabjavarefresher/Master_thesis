function shape_top_left_index_global=global2index(image_top_left, res, ...
    shape_top_left_global, round_func)


if nargin<4
    round_func = @round;
end

% Shouldn't this index be distance + 1 instead of just distance ? It is 
% fine because in the next function, we again calculate the distance from 
% this index where a -1 will cancel this +1, no +1 here and no -1 in 
% index2global function, hence it is alright. Note the meshgrid is finally
% done on distances and not indices 

shape_top_left_index_global = round_func((shape_top_left_global-...
    image_top_left)*res);

end

