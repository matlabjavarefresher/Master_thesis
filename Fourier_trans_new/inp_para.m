function [len,dx,T,s_rat] = inp_para(x)
len=length(x);
dx=x(2)-x(1);%sampling interval
T=max(x); %fundamental time period
s_rat=1/dx;%sampling rate
end

