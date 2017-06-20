function IC1R1_SH=global2index(X1Y1_IM, res, X1Y1_SH, round_func)
if nargin<4
    round_func = @round;
end
IC1R1_SH = round_func((X1Y1_SH-X1Y1_IM).*res);
end

