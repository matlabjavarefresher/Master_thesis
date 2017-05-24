function [ y,ab_spec,c,s_rat] = rand_gauss_field_gen(cor_func,x)

%% Setting up the input signal
inp=feval(cor_func,x); % Generating input signal
 
[le,dx,T,s_rat]=inp_para(x); % Generating input signal's parameters

%% FFT of input signal
%spec=fft(inp); % earlier
%ab_spec=real(spec); % earlier
spec=real(disft_r2r(inp,le)); % spectrum anyway real valued
% req_spec=abs(spec(1:le));

%% Setting the input for the inverse Fourier transform (IFFT)
%c=c_gen(ab_spec,T,le);
%c=c_gen(req_spec,T,le);
c=c_gen(spec,T,le);

%% Generating the random gaussian field
y=ifft(c);


end

