function [s_2]=auto_corr_probability(A)
% A=A-mean(A(:));
diags_sum=zeros(size(A,2),1);
for i=1:size(A,1)
    row=A(i,:);
    mat=row'*row;
    mat_req=triu(mat);
    diags_sum(:,i)=compute_diag_sum_mean(mat_req);
end
s_2=mean(diags_sum,2);
end


