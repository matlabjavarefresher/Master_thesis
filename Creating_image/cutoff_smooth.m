function y=cutoff_smooth(x, res, C)
y=atan(C*(1-x)*max(res))/pi+0.5;
end


