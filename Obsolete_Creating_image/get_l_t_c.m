function [ltc_ind]=get_l_t_c(c_l,a_in,b_in)

% Computes the left top corner of the shape for the given center
% coordinates c_locs_ol_ltc

% Getting the shape width

w=2*sqrt(a_in^2+b_in^2);

% Fetching the beginning of the shape (index) in global indices

x1=floor(c_l(1)-w/2);
y1=floor(c_l(2)-w/2);

ltc_ind(1)=x1+1;
ltc_ind(2)=y1+1;

end

