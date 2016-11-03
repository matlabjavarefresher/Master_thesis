%%Setting up input signal
cor_func = @(x) exp(-x.^2); %Correlation function
x=linspace(0,10);
len=length(x);
dx=x(2)-x(1);%sampling interval
T=max(x); %fundamental time period
s_rat=1/dx;%sampling rate

%% DFT of input signal
spec=disft(cor_func(x),len);
ab_spec=abs(spec);

%%  Plot DFT: check
plot((0:length(x)-1)*s_rat/length(x),ab_spec);%plotting dft of cor_func


%% Generating random field

vari= 0.5*(2*pi/T)*abs(spec);
st_de=sqrt(vari);

a(1:len/2-1)=randn(len/2-1,1).*st_de(1:len/2-1)';
a(len/2+2:len)=a(len/2-1:-1:1);

b(1:len/2-1)=randn(len/2-1,1).*st_de(1:len/2-1)';
b(len/2+2:len)=-b(len/2-1:-1:1);

c=a+1j*b;
r_g_fld=invft(c,len);
y=abs(r_g_fld);

%% Checking correlation of obtained field

[Y1,Y2]=meshgrid(y,y);
Y=sum(spdiags(Y1.*Y2));
mea_y=Y(1:100)./(1:100);
plot(linspace(0,10),Y(1:100));
figure
plot(linspace(0,10),mea_y);
figure;
plot(linspace(0,10),cor_func(x),'b*');










