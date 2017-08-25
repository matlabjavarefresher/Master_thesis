function xyz_coord_rotated=rotate_grid(xy_coord_grid, theta)
dim=size(xy_coord_grid,1);

switch dim
    case 2
        c = cos(theta);
        s = sin(theta);
        U = [c, -s; s, c];
   case 3
       % The below setup is for an intrinsic rotation 
       R_z= rotate_z(theta(1));
       R_y= rotate_y(theta(2));
       R_x= rotate_x(theta(3));
       U=R_z*R_y*R_x;
end
siz = size(xy_coord_grid);
xyz_coord_rotated=reshape(U*reshape(xy_coord_grid, dim, []), siz);
end


function [R_z]=rotate_z(yaw)
R_z=[cos(yaw) -sin(yaw) 0;sin(yaw) cos(yaw) 0;0 0 1];
end

function [R_y]=rotate_y(pitch)
R_y=[cos(pitch) 0 sin(pitch);0 1 0; -sin(pitch) 0 cos(pitch)];
end

function [R_x]=rotate_x(roll)
R_x=[1 0 0;0 cos(roll) -sin(roll); 0 sin(roll) cos(roll)];
end


