function [le,dx,T,s_rat] = inp_para(x)
le=length(x);
dx=x(2)-x(1); %sampling interval
T=x(le)-x(1); %fundamental time period
s_rat=1/dx; %sampling rate
end

