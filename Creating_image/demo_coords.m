function demo_coords


X1Y1_IM = [1; 1];
X2Y2_IM = [10; 10];
%gx1 = [4.5; 45];
%gx2 = [9; 50];
res = 1; % pixels per inch

N = ceil((X2Y2_IM-X1Y1_IM).*res);
imag = zeros( N' );

%cx = [4 * pi; 3 * exp(1)];
% cx = [gx1(1)+1; gx2(2)-1];
a = [40; 20];
p = 2;
th = deg2rad(0);
ovlp=0;

%[loc_shape, i1, n] = compute_local_shape(gx1, res, a, p, cx, th);
%imag = place_imag(imag, loc_shape, i1);
[loc_shape, IR1C1_SH] = compute_local_shape(X1Y1_IM, res, a, p, [X1Y1_IM(1)+1; X2Y2_IM(2)-1], th);
[ad]=check_overlap(ovlp,loc_shape,imag);
imag = place_imag(imag, loc_shape, IR1C1_SH);
% [loc_shape, i1] = compute_local_shape(gx1, res, a, p, [gx1(1)+1; gx1(2)+1], th);
% imag = place_imag(imag, loc_shape, i1);
% [loc_shape, i1] = compute_local_shape(gx1, res, a, p, [gx2(1)-1; gx2(2)-1], th);
% imag = place_imag(imag, loc_shape, i1);
% [loc_shape, i1] = compute_local_shape(gx1, res, a, p, [gx2(1)-1; gx1(2)+1], th);
% imag = place_imag(imag, loc_shape, i1);

%multiplot_init(2,1);
%multiplot;
%spy(loc_shape)

%multiplot;
%spy(imag)
%imag(imag==0)=2;
imshow(imag)
figure
surf(imag)
shading interp
end



































