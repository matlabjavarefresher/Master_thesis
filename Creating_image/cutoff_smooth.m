function y=cutoff_smooth(x, res)
y=atan(0.2*(1-x)*max(res))/pi+0.5;
end


