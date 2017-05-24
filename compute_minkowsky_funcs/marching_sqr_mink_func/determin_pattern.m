function [cas] = determin_pattern(nei,A,tresh)

cas=0;

if A(nei(4))>tresh
    cas=cas+1;
end

if A(nei(1))>tresh
    cas=cas+2;
end

if A(nei(2))>tresh
    cas=cas+4;
end

if A(nei(3))>tresh
    cas=cas+8;
end

end

