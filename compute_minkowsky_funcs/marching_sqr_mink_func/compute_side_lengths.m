function [a]=compute_side_lengths(nei,A,tresh)

% Computing side lengths a1, a2, a3, a4 as described in Utilizing Minkowsky
% functionals for image analysis, page 15, Mantz et al., 2008, Online at 
% stacks.iop.org/JSTAT/2008/P12015

        a1 = (A(nei(4))-tresh) / (A(nei(4)) - A(nei(1)));
        a2 = (A(nei(1))-tresh) / (A(nei(1)) - A(nei(2)));
        a3 = (A(nei(3))-tresh) / (A(nei(3)) - A(nei(2))); 
        a4 = (A(nei(4))-tresh) / (A(nei(4)) - A(nei(3)));
        
        a=[a1;a2;a3;a4];

end

