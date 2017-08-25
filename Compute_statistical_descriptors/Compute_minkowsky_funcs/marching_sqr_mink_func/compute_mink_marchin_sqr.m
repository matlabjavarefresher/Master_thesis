function [per,ar,ec] = compute_mink_marchin_sqr(image,threshold,template_length)

col=size(image,2);
row=size(image,1);

image_indices_vector=1:col*row;
% required_indices contains a vector of indices of the image corresponding
% to the positions on the image (here image positions is a vector from one 
% to number of pixels in the image) where the template needs to be placed
required_indices=image_indices_vector(~(mod(image_indices_vector,col)==0));

img_temp=image';
A=img_temp(:);

ar=0;
per=0;
ec=0;

for j=1:(col-1)*(row-1)
    i=required_indices(j);
    [nei] = get_nei_march_sqr(i,col);
    [cas] = determin_pattern(nei,A,threshold);
    [a]=compute_side_lengths(nei,A,threshold);
    [are,peri,ech]=compute_march_sqr_mink_incr(cas,a);
    
    %Updating the Mink funcs
    ar=ar+are;
    per=per+peri;
    ec=ec+ech;
    
end


end

