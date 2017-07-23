function [per,ar,ec] = compute_mink_marchin_sqr(img,tresh)

col_img=size(img,2);
row_img=size(img,1);

ind_v=1:col_img*row_img;
req_ind=ind_v(~(mod(ind_v,col_img)==0));

img_temp=img';
A=img_temp(:);

ar=0;
per=0;
ec=0;

for j=1:(col_img-1)*(row_img-1)
    i=req_ind(j);
    [nei] = get_nei_march_sqr(i,col_img);
    [cas] = determin_pattern(nei,A,tresh);
    [a]=compute_side_lengths(nei,A,tresh);
    [are,peri,ech]=compute_march_sqr_mink_incr(cas,a);
    
    %Updating the Mink funcs
    ar=ar+are;
    per=per+peri;
    ec=ec+ech;
    
end


end

