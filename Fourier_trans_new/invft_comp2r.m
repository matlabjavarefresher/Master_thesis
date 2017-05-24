function [spec] = invft_comp2r(in_sig,len)
% in_sig is the input signal - a vector
% This function fourier tranfroma a real sequence into 
% another real sequence. It needs a symmetric input signal 
% to work, in which a[-n]=a[n].

        n=len/2-0.5;
        
kk=0;

for k=-n:n
    sum=0;
    ti=0;
    for t=-n:n
        sum=sum+in_sig(ti+1)*exp(1j*2*pi*k*t/len);
        ti=ti+1;
    end
    spec(kk+1)=1/len*sum;
    kk=kk+1;
end

end