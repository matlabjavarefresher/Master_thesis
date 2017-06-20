function demo_coords

gx1 = [4.5; 2.3];
gx2 = [15.5; 20];
%gx1 = [4.5; 45];
%gx2 = [9; 50];
res = 30; % dots per inch

gn = ceil((gx2-gx1).*res);
imag = zeros( gn' );

%cx = [4 * pi; 3 * exp(1)];
cx = [gx1(1)+1; gx2(2)-1];
a = [5/2; 3.4/2]/0.6;
p = 5;
th = deg2rad(-25);

%[loc_shape, i1, n] = compute_local_shape(gx1, res, a, p, cx, th);
%imag = place_imag(imag, loc_shape, i1);
[loc_shape, i1] = compute_local_shape(gx1, res, a, p, [gx1(1)+1; gx2(2)-1], th);
imag = place_imag(imag, loc_shape, i1);
[loc_shape, i1] = compute_local_shape(gx1, res, a, p, [gx1(1)+1; gx1(2)+1], th);
imag = place_imag(imag, loc_shape, i1);
[loc_shape, i1] = compute_local_shape(gx1, res, a, p, [gx2(1)-1; gx2(2)-1], th);
imag = place_imag(imag, loc_shape, i1);
[loc_shape, i1] = compute_local_shape(gx1, res, a, p, [gx2(1)-1; gx1(2)+1], th);
imag = place_imag(imag, loc_shape, i1);

% multiplot_init(2,1);
% multiplot; 
% spy(loc_shape)
% 
% multiplot; 
% spy(imag)
%imag(imag==0)=2;
surf(imag)
shading interp

function imag = place_imag(imag, loc_shape, i1)
i2=i1+size(loc_shape)'-1;
i=i1(1):i2(1);
j=i1(2):i2(2);
lind1 = i>=1 & i<=size(imag,1);
lind2 = j>=1 & j<=size(imag,2);
gind1 = i1(1) + find(lind1) -1;
gind2 = i1(2) + find(lind2) -1;
imag(gind1, gind2) = imag(gind1, gind2) | loc_shape(lind1, lind2);


function [loc_shape, i1, n] = compute_local_shape(gx1, res, a, p, cx, th)
w = 2*sqrt(sum(a.^2));
n = ceil(res*w)+1;
[x, i1]=compute_local_coords(gx1, res, cx, w, n);

DX = makegrid(bsxfun(@minus, x, cx));
DX = rotate_grid(DX, th);
DX = abs(DX);
loc_shape = shiftdim(sum(abs(bsxfun(@times, DX, 1./a)).^p,1),1)<=1;



function DX=makegrid(x)
DXc = cell(size(x,1), 1);
xc = num2cell(x, 2);
[DXc{:}]=ndgrid(xc{:});
DX=permute(cat(3,DXc{:}), [3, 1, 2]);




function X=rotate_grid(X, theta)
dim = size(X, 1);
switch dim
    case 2
        c = cos(theta);
        s = sin(theta);
        U = [c, s; -s, c];
    otherwise
        error('not supported yet');
end
shp = size(X);
X=reshape(U*reshape(X, dim, []), shp);


function [x, i1]=compute_local_coords(gx1, res, cx, w, n)
xp1 = cx - w/2;
i1 = global2index(gx1, res, xp1, @floor);
x1 = index2global(gx1, res, i1);
x2 = x1 + n / res;
x = bsxfun(@plus, x1, bsxfun(@times, x2-x1, linspace(0, 1, n)));

function i=global2index(gx1, res, x, round_func)
if nargin<4
    round_func = @round;
end
i = round_func((x-gx1)*res);

function x=index2global(gx1, res, i)
x = (i/res) + gx1;


