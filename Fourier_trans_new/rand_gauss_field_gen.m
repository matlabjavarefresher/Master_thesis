function [ y,ab_spec,c,s_rat] = rand_gauss_field_gen(cor_func,x)

%% Setting up the input signal
inp=feval(cor_func,x); % Generating input signal
[len,dx,T,s_rat]=inp_para(x); % Generating input signal's parameters

%% FFT of input signal
spec=fft(inp);
ab_spec=abs(spec);


%% Setting the input for the inverse Fourier transform (IFFT)
c=c_gen(ab_spec,T,len);

%% Generating the random gaussian field
y=ifft(c);


end

