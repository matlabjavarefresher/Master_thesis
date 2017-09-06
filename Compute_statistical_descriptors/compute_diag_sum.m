function [d_sum]= compute_diag_sum_mean(B)
d_sum=zeros(size(B,1),1); %A will always be a square matrix
denominator=(size(B,1):-1:1)';
for i=1:size(B,1) 
    d=diag(B,i-1);
    d_sum(i)=sum(d);
end
d_sum=d_sum./denominator;
end  