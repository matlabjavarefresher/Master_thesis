function y=cutoff_smooth(x, res, C)
p = 0.02;
C1 = 2*tan(pi/2*(1-p));
y=atan(C1*(1-x)*res/C)/pi+0.5;
end


