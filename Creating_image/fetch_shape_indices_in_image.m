function [shape_rows_logical,shape_cols_logical]=fetch_shape_indices_in_image(size_image, size_shape, shape_top_left)

% Note the size_shape vector here is in [columns;rows] format and this has
% been done in the check_overlap function so that the x coord in 
% shape_top_left could be added to the columns and the y coord to the rows.
% Currently columns=rows in the created shape, so this order shouldn't 
% matter but in the event of the columns and rows not having the same 
% value, then this order would be important. Note the size_image vector is
% in the normal [rows;columns] format.

shape_bottom_right=shape_top_left + size_shape - 1;
shape_cols_global=shape_top_left(1):shape_bottom_right(1);
shape_rows_global=shape_top_left(2):shape_bottom_right(2);

shape_rows_logical = shape_rows_global>=1 & shape_rows_global<=size_image(1);
shape_cols_logical = shape_cols_global>=1 & shape_cols_global<=size_image(2);

end
