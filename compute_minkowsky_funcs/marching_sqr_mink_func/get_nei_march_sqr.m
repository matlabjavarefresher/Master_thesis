function [nei] = get_nei_march_sqr(i,col_siz)

%Clockwise neighbors 1,2 and 3 corresponding to right, below right and 
%exactly below pixels to the the current pixel

%Passing the current pixel in i as the 4th neighbor as the current pixel 
%position is required in the succeeding functions  

c_loc=i;

nei(1)=c_loc+1;
nei(2)=c_loc+(col_siz+1);
nei(3)=c_loc+(col_siz);
nei(4)=c_loc;

end

