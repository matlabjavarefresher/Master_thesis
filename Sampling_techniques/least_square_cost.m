function [cost] = least_square_cost(a, b, w_v)
least_square_difference=sqrt((a-b).^2);
sum_vec=sum(least_square_difference,2);
cost=w_v'*sum_vec;
end

