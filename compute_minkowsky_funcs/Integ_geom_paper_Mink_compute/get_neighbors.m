function [nei]=get_neighbors(c_loc,c_c)

% Neighbors counted clockwise from pixel located directly above the
% concerned pixel

nei(1)=c_loc-(c_c+2);
nei(2)=c_loc-(c_c+1);
nei(3)=c_loc+1;
nei(4)=c_loc+(c_c+3);
nei(5)=c_loc+(c_c+2);
nei(6)=c_loc+(c_c+1); 
nei(7)=c_loc-1;
nei(8)=c_loc-(c_c+3);

end

