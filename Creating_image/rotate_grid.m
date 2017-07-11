function xy_coord_rotated=rotate_grid(xy_coord_grid, theta)
dim = size(xy_coord_grid, 1);
switch dim
    case 2
        c = cos(theta);
        s = sin(theta);
        U = [c, -s; s, c];
    otherwise
        error('not supported yet');
end
siz = size(xy_coord_grid);
xy_coord_rotated=reshape(U*reshape(xy_coord_grid, dim, []), siz);
end
