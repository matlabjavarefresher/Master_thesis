% Creating an ellipse, circle, triangle, square and hexagon to serve as
% inputs to the functions which compute the Minkowsky functionals. Passing
% these shapes to those functions will tell us how well the perimeter and
% areas of these shapes are being estimated by each of the functions.

cas=4.2; % 1 for ellipse, 2 for circle, 3 for triangle with 1 straight line,
% 3.5 for triangle with steps on all 3 sides 4 for square, 5 for
% hexagon and 6 for triangle as per K Michielsen et al. Integral Geometry
% paper, 7 for infinity shape

siz=[101,101];       % image overall size
circ_rad=25;
ellip_maj_ax=25;
ellip_min_ax=12.5;
sqr_side=25;



switch cas
    
    
    case 1
        x=(-50:50);y=(-50:50);
        xx=x./25;
        xxx=meshgrid(xx,xx);
        yy=y./15;
        yyy=meshgrid(yy,yy);
        resu=xxx.^2+yyy'.^2;
        img=resu<1;
        imshow(img);
        
        
    case 2
        x=(-50:50);y=(-50:50);
        xx=meshgrid(x,x);
        yy=meshgrid(y,y);
        resu=xx.^2+yy'.^2;
        img=resu<676;
        imshow(img);
        
    case 2.1 % circle with 3 X R as case 2
        x=(-150:150);y=(-150:150);
        xx=meshgrid(x,x);
        yy=meshgrid(y,y);
        resu=xx.^2+yy'.^2;
        img=resu<5929;
        imshow(img);
        
    case 2.2 % circle with 9 X R as case 2
        x=(-450:450);y=(-450:450);
        xx=meshgrid(x,x);
        yy=meshgrid(y,y);
        resu=xx.^2+yy'.^2;
        img=resu<52900;
        imshow(img);
        
    case 3
        
        x=(-50:50);y=(50:-1:-50);
        xx=meshgrid(x,x);
        yy=meshgrid(y,y);
        lin_1=yy'<(xx+30);
        lin_2=yy'<(-xx+30);
        lin_3=yy'>0;
        img=(lin_1 & lin_2 & lin_3);
        imshow(img);
        
    case 3.5
        
        x=(-50:50);y=(50:-1:-50);
        xx=meshgrid(x,x);
        yy=meshgrid(y,y);
        lin_1=yy'<(xx+30);
        lin_2=yy'<(-xx+30);
        lin_3=yy'>((-.3*xx)+9);
        img=(lin_1 & lin_2 & lin_3);
        imshow(img);
        
        
        
    case 4
        
        x=(-50:50);y=(-50:50);
        xx=meshgrid(x,x);
        req_x=(xx>-26 & xx<26);
        yy=meshgrid(y,y);
        req_y=(yy>-26 & yy<26);
        img=(req_x & req_y');
        imshow(img)
        
    case 4.1
        
        x=(-150:150);y=(-150:150);
        xx=meshgrid(x,x);
        req_x=(xx>-77 & xx<77);
        yy=meshgrid(y,y);
        req_y=(yy>-77 & yy<77);
        img=(req_x & req_y');
        imshow(img)
        
        
    case 4.2
        
        x=(-450:450);y=(-450:450);
        xx=meshgrid(x,x);
        req_x=(xx>-230 & xx<230);
        yy=meshgrid(y,y);
        req_y=(yy>-230 & yy<230);
        img=(req_x & req_y');
        imshow(img)
        
        
    case 5
        
        %do it later
        
    case 6 % triangle as per K Michielsen et al.
        img=[zeros(2,10);0 0 0 1 1 zeros(1,5); 0 0 ones(1,4) zeros(1,4);...
            0 ones(1,6) zeros(1,3);0 ones(1,6) zeros(1,3); 0 0 ones(1,6)...
            0 0;zeros(1,4) ones(1,5) 0; zeros(1,7) 1 1 0; zeros(1,10)];
        imshow(img);
        
    case 7 % Infinity shape
        img=[0 0 1 1 1 1 zeros(1,10) 1 1 1 1 0;0 ones(1,7) zeros(1,5) ...
            ones(1,8);ones(1,10) 0 ones(1,10);ones(3,21);ones(1,20) 0;...
            0 ones(1,8) 0 0 0 0 ones(1,7) 0; 0 0 0 1 1 1 zeros(1,9) ...
            1 1 1 0 0 0];
        imshow(img);
end