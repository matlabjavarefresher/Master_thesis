function [do_add] = allow_absolute_overlap(im1, im2,res,am_bm,c)

ov_lim=(res^2)*4*am_bm(1)*am_bm(2)*c;

% Here the term absolute means that the computation of the overlap extent
% below is based only on the scalar product of im1 and im2 and it is not
% relative (i.e. the product is not divided by the number of those elements
% in the intersection region of im1 and im2 with values greater than 0)

im=im1.*im2;
d_p=sum(im(:))
am_bm(1);
am_bm(2);
ov_lim
do_add=d_p<ov_lim;

% % ovlp_extent0=sum(sum(im))/numel(im);
% % ovlp_extent1=sum(sum(im))/numel(im>0);
%
%  ovlp_extent2=sum(sum(im==0))/numel(im);
%
%  ovlp_extent3=sum(sum(im1(im1 & im2)))/numel(im1(im1 & im2)>0);
%
% % ad = ovlp_extent1<ovlp;
%
% ad=(1-ovlp_extent2)<ovlp & (ovlp_extent3 <ovlp);

end