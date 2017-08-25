function [ lhs_shape_equation ] = compute_power( lhs_shape_equation_temp,exponent)

switch exponent
    
    case exponent<2
        %lhs_shape_equation= lhs_shape_equation_temp.^exponent;
        lhs_shape_equation= lhs_shape_equation_temp; % If exponent less 
                                                     % than 2, it has to 
                                                     % be one as exponent 
                                                     % assumes only
                                                     % integer values
    otherwise
        lhs_shape_equation=lhs_shape_equation_temp;
        for i=1:exponent-1
            lhs_shape_equation= lhs_shape_equation.*lhs_shape_equation_temp;
        end
       % lhs_shape_equation=lhs_shape_equation.*(lhs_shape_equation_temp.^mod(exponent,1));
end



% %% By roberson@ibd.nrc-cnrc.gc.ca (Walter Roberson)
% 
% 
% exp = uint32(exponent);
% 
% if bitand(exp,1)
%   lhs_shape_equation = lhs_shape_equation_temp;
% else
%   lhs_shape_equation = ones(size(lhs_shape_equation_temp));
% end
% exp = bitshift(exp,-1);
% 
% if exp ~= 0
%   multiplier = lhs_shape_equation_temp;
% end
% 
% while exp ~= 0
%   multiplier = multiplier .* multiplier;
%   if bitand(exp,1)
%     lhs_shape_equation = lhs_shape_equation .* multiplier;
%   end
%   exp = bitshift(exp,-1);
% end



end

