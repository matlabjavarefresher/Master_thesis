function [a_new,b_new]=scale_dimns_as_per_res(reso,a_old,b_old)

% Scales the dimensions in the inputs to the required resoluton as
% given in reso which contains resolutions in x and y directions
% in res(1) and res(2) respectively

a_new = reso(1)*a_old;
b_new = reso(2)*b_old;

% locatn(1)=reso(1)*loca(1);
% locatn(2)=reso(2)*loca(2);

end

