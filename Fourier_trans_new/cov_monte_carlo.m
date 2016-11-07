function [Y,y] = cov_monte_carlo( cor_func,x,n)

for i=1:n
    y(i,:)=rand_gauss_field_gen(cor_func,x);
    Y(:,:,i)=cov_1d(y(i,:));
end

y=mean(y,1);
Y=mean(Y,3);

end

