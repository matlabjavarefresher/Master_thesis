function [c] = c_gen(ab_spec,T,len)

vari= 0.5*(2*pi/T)*ab_spec;
st_de=sqrt(vari);


chk=mod(len,2);
switch chk;
    
    case 0
        
        a(1)=randn(1)*st_de(1);
        a(2:len/2)=randn(len/2-1,1).*st_de(2:len/2)';
        a(len/2+2:len)=a(len/2:-1:2);
        
        b(1)=0;
        b(2:len/2)=randn(len/2-1,1).*st_de(2:len/2)';
        b(len/2+2:len)=-b(len/2:-1:2);
        
        c=a+1j*b;
        
        
    case 1
        
        a(1)=randn(1)*st_de(1);
        a(2:ceil(len/2-1))=randn(ceil(len/2-2),1).*st_de(2:ceil(len/2-1))';
        a(ceil(len/2)+2:len)=a(ceil(len/2-1):-1:2);
        
        b(1)=0;
        b(2:ceil(len/2-1))=randn(ceil(len/2-2),1).*st_de(2:ceil(len/2-1))';
        b(ceil(len/2)+2:len)=-b(ceil(len/2-1):-1:2);
        
        c=a+1j*b;
        
        
end

end

