function [circ]=make_circle(r)

dia=2*r;

c_x=r+1;
c_y=c_x;

y_c_loc=(1:dia+1)'*ones(1,dia+1);
x_c_loc=y_c_loc';

circ=(((x_c_loc-c_x).^2) + ((y_c_loc-c_y).^2)) <= ((dia/2)*ones(dia+1)).^2;

end

