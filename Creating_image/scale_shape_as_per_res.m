function [scld_shp]=scale_shape_as_per_res(shp,res)

% Scales the given shape (shp) to the required resolution (res)

old_size=size(shp);

new_size = res.*old_size;

r_ind = min(round((((1:new_size(1))-0.5)./res(1))+0.5),old_size(1)); 
 
c_ind = min(round((((1:new_size(2))-0.5)./res(2))+0.5),old_size(2));

scld_shp=shp(r_ind,c_ind);

end



