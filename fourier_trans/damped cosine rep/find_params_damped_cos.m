function [alpha_est, omega_est, L2_error] = find_params_damped_cos(x, y, varargin)

% The function fits the signal Y(X) (with a decaying oscillation around zero)
% to the form:
%
% Y(X)=ampl*exp(-alpha*x).*sin(omega*x + phi1)
%
% by identifying the parameters:

% -alpha (ALPHA_EST)
% -omega (OMEGA_EST)

%
% Input parameters:
% y(x): signal
% do_opt: TRUE/FALSE TRUE: parameters are first estimated then L2 fitted
%                    FALSE:parameters are only estimated
% n:    Cut off the first part of the signal till element 'n'
% By Noemi Friedman and Elmar Zander

options=varargin2options(varargin,mfilename);
[do_opt, options]=get_option(options,'do_opt', true);
[n, options]=get_option(options,'n',1);
check_unsupported_options(options);

% Cut off the first part of signal
xn = x(n);
x = x(n:end) - xn;
y = y(n:end);
%% Estimate parameters

% Get zero points of signal ZERO_LOC and Y value at the peaks
[zero_ind, zero_dir] = zero_find(y);
peak_ind = peak_find(y);
zero_loc = (zero_ind-1) * (x(2)-x(1));

% Estimate frequency of the signal from regression from the zero points
i=0:(length(zero_ind)-1);
zero_fit=polyfit(i, zero_loc, 1); %linear regression

dt = zero_fit(1);  % halved period time T/2
omega_est = pi / dt;  %frequency

% Estimated decaying rate of the signal
j=0:(length(peak_ind)-1);
yp = abs(y(round(peak_ind)));
peak_fit=polyfit(j*dt, -log(yp), 1);
alpha_est = peak_fit(1);


%% L2 fit 
% optimize the parameters with quasi_newton starting from the estimated
% values, by minimising the L2 norm of the error
if do_opt
    func = @(p)(optimfunc_damped_cos(x, y, p(1), p(2)));
    p0=[alpha_est; omega_est];
    H0=eye(2);
    newton_opts.abstol = 1e-6;
    newton_opts.verbosity = 0;
    [p,flag,iter] = minfind_quasi_newton(func, p0, H0, newton_opts);
    
    alpha_est = p(1);
    omega_est = p(2);
    
end
 y_pt=exp(-alpha_est*x).*cos(omega_est*x);
 L2_error= norm(y-y_pt)/norm(y);
