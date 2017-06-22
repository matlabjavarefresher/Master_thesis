function [ad] = allow_partial_overlap(im1, im2,ovlp)
 
im=im1.*im2;

% ovlp_extent0=sum(sum(im))/numel(im);

ovlp_extent1=sum(sum(im))/numel(im>0);

% ovlp_extent2=sum(sum(im==0))/numel(im);

% ovlp_extent3=sum(sum(im1()))/numel(im1>0);  

ad = ovlp_extent1<ovlp;

% ad=(1-ovlp_extent2)<ovlp & (ovlp_extent3 <ovlp);

end