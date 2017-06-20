function im1 = combine_sum2(im1, im2)
im1 = im1 + im2 - im1.*im2;
%im1 = min((im1.^2+im2.^2)-(im1.*im2), 1);
end
