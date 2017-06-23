function gj1i1_sh=global2index(gx1y1, res, gx1y1_sh, round_func)
if nargin<4
    round_func = @round;
end
gj1i1_sh = round_func((gx1y1_sh-gx1y1)*res);
end

