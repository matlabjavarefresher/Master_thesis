function [are,peri,ech]=compute_march_sqr_mink_incr(cas,a)

% Computes the increments of area, perimeter and Euler characteristic
% for the given configuration (among the 16 configurations given in
% the paper: Utilizing Minkowsky functionals for image analysis, page 11)
% cas.

are=0;
peri=0;
ech=0;

%Extracting sie lengths

a1=a(1);
a2=a(2);
a3=a(3);
a4=a(4);

switch cas
    
    case 1
        are=(a1*a4)/2;
        peri=sqrt((a1^2)+(a4^2));
        ech=1/4;
        
    case 2
        are=((1-a1)*a2)/2;
        peri=sqrt(((1-a1)^2)+(a2^2));
        ech=1/4;
        
    case 3
        are=a2+((a4-a2)/2);
        peri=sqrt(((a4-a2)^2)+1);
        ech=0;
        
    case 4
        are=((1-a2)*(1-a3))/2;
        peri=sqrt(((1-a2)^2)+((1-a3)^2));
        ech=1/4;
        
    case 5
        are=1-(((1-a1)*a2)/2)-(((1-a4)*a3)/2);
        peri=sqrt(((1-a1)^2)+(a2^2))+sqrt(((1-a4)^2)+(a3^2));
        ech=1/2;
        
    case 6
        are=(1-a3)+((a3-a1)/2);
        peri=sqrt(((a3-a1)^2)+1);
        ech=0;
        
    case 7
        are=1-(((1-a4)*a3)/2);
        peri=sqrt(((1-a4)^2)+(a3^2));
        ech=-1/4;
        
    case 8
        are=((1-a4)*a3)/2;
        peri=sqrt(((1-a4)^2)+(a3^2));
        ech=1/4;
        
    case 9
        are=a1+((a3-a1)/2);
        peri=sqrt(((a3-a1)^2)+1);
        ech=0;
        
    case 10
        are=1-(a1*a4*0.5)-((1-a2)*(1-a3)*0.5);
        peri=(sqrt((a1^2)+(a4^2)))+(sqrt(((1-a2)^2)+((1-a3)^2)));
        ech= 0.5;
        
    case 11
        are=1-(((1-a2)*(1-a3))/2);
        peri=sqrt(((1-a2)^2)+((1-a3)^2));
        ech=-1/4;
        
    case 12
        are=(1-a2)+((a2-a4)/2);
        peri=sqrt(((a2-a4)^2)+1);
        ech=0;
        
    case 13
        are=1-(((1-a1)*a2)/2);
        peri=sqrt(((1-a1)^2)+(a2^2));
        ech=-1/4;
        
    case 14
        are=1-((a1*a4)/2);
        peri=sqrt((a1^2)+(a4^2));
        ech=-1/4;
        
    case 15
        are=1;
        peri=0;
        ech=0;

end



end

