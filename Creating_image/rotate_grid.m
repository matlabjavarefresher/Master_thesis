function gxy_sh_rt=rotate_grid(gxy_sh_gr, theta)
dim = size(gxy_sh_gr, 1);
switch dim
    case 2
        c = cos(theta);
        s = sin(theta);
        U = [c, -s; s, c];
    otherwise
        error('not supported yet');
end
siz = size(gxy_sh_gr);
gxy_sh_rt=reshape(U*reshape(gxy_sh_gr, dim, []), siz);
end
