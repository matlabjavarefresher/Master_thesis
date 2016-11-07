clear;
clc;

%% Setting up the input signal
cor_func = @(x) exp(-x.^2);  % Correlation function
x=linspace(0,10);



%% Generation of several realisations of random fields and 
%  computing Covariance and Correlation
n=1000; %Number of random fields required
[Y_mc,y] = cov_monte_carlo(cor_func,x,n);
cor_cof=corr_coeffs_1d(Y_mc);



%% Plotting
figure;
subplot(2,2,1);
plot(x,cor_func(x)); % Correlation coefficients versus distance 
title('Initial correlation function');
subplot(2,2,2);
surf(x,x,Y_mc); % Covariance of y plot
title(['Covariance of ',int2str(n),' random fields']);
subplot(2,2,3);
plot(x,cor_cof); % Correlation coefficients versus distance 
title('Correlation coefficients versus distance');
subplot(2,2,4);
plot(linspace(0,length(y)),y,'-r*');%plotting average of n Random fields
title(['Average of ',int2str(n),' random fields']);






