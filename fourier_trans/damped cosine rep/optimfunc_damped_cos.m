function [f, df] = optimfunc(x, y, alpha, omega)
% this function gives the cost functional f and its jacobian df for L2
% fitting the function y to exp(-alpha * x).*cos(omega * x);
dy = y -  exp(-alpha * x).*cos(omega * x);
f = sum(dy.*dy);
dfdalpha = 2 * dot(dy, x.*exp(-alpha * x).*cos(omega * x));
dfdomega = 2 * dot(dy, x.*exp(-alpha * x).*sin(omega * x));
df = [dfdalpha; dfdomega];
