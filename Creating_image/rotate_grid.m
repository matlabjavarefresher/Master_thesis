function X=rotate_grid(X, theta)
dim = size(X, 1);
switch dim
    case 2
        c = cos(theta);
        s = sin(theta);
        U = [c, -s; s, c];
    otherwise
        error('not supported yet');
end
shp = size(X);
X=reshape(U*reshape(X, dim, []), shp);
end
