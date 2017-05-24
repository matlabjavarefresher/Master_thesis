function [sw_img]=swap_pixel_anneal(sw_img)

one_=find(sw_img);
zero_=find(~sw_img);

a=one_(randi(numel(one_)));
b=zero_(randi(numel(zero_)));

sw_img(a)=0;
sw_img(b)=1;


end