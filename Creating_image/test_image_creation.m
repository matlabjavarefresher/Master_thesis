%% General image properties

clear
clc

%% Initialising the Image (background for the shapes)

im_rows=1000;
im_cols=1000;

x_u_l=2;
y_u_l=1;
res_x=1/x_u_l;
res_y=1/y_u_l;

im_size=[im_rows,im_cols];
im_res=[res_x,res_y];

img0=zeros(im_size);

shp_type='smooth_convex';  %Other options - 'circle', 'ellipse', 'smooth_convex'
n=200;% Number of shapes required
max_try=10*n; % Max number of tries to place n shapes on the image
ovlp=1; %1 for overlap and 0 for no overlap

%% Generate and display image

switch shp_type
    
    case 'smooth_convex'
        
        a_dist=gendist_create('beta', {2,2}, 'shift',60,'scale', 10);
        r_x= gendist_sample(max_try,a_dist);
        
        b_dist=gendist_create('beta', {2,2}, 'shift',40,'scale', 20);
        r_y= gendist_sample(max_try,b_dist);
        
        th_dist=gendist_create('beta', {2,2}, 'shift',0,'scale',pi/2);
        th= gendist_sample(max_try,th_dist);
        
        pow_dist=gendist_create('beta', {2,2}, 'shift',1.5,'scale',0);
        pow= gendist_sample(max_try,pow_dist);
        
        [img1,shp_count]=create_image(img0,im_res,shp_type,n,max_try,ovlp,r_x,r_y,th,pow);
        disp([num2str(shp_count) ' shapes were placed']);
        
end
%subplot(3,3,1)
imshow(img1);


% %% Lineal path function calculation
% [l_p_x] = lineal_path_calc(img1);
% [l_p_y] = lineal_path_calc(img1');

% l_p=(count_x+count_y)/(tot_count_1+tot_count_2);

% %% Chord length function calculation
% [c_l_x] = chord_length_func_calc(img1);
% [c_l_y] = chord_length_func_calc(img1');
% %
% % c_l=(count_xx+count_yy)/(tot_chords_1+tot_chords_2);
% %
% %% Auto correlation calculation
% [a_c_x] = auto_corr(img1);
% [a_c_y] = auto_corr(img1');
%
% %% Minkowsky functionals calculation
% per1=imPerimeter(img1);
% are1=imArea(img1);
% [ar2,peri2,ec2,cap2]=compute_mink_2d(img1);
% [ar3,per3,ec3]=compute_mink_marchin_sqr(img1,0.5);



% %% Plotting
% subplot(3,3,2);
% plot(1:length(l_p_x),l_p_x);
% title('Lineal path function in x')
% subplot(3,3,3);
% plot(1:length(l_p_y),l_p_y);
% title('Lineal path function in y')
% subplot(3,3,4);
% plot(1:length(c_l_x),c_l_x);
% NumTicks = 11;
% L = get(gca,'XLim');
% set(gca,'XTick',linspace(L(1),L(2),NumTicks))
% title('Chord length function in x');
% subplot(3,3,5)
% plot(1:length(c_l_y),c_l_y);
% NumTicks = 11;
% L = get(gca,'XLim');
% set(gca,'XTick',linspace(L(1),L(2),NumTicks))
% title('Chord length function in y');
% subplot(3,3,6)
% plot(0:length(a_c_x)-1,a_c_x);
% title('Auto correlation w.r.t. distance in x');
% subplot(3,3,7)
% plot(0:length(a_c_y)-1,a_c_y);
% title('Auto correlation w.r.t. distance in y');
%
% % subplot(2,3,6)
% % plot(1:length(c_l),cumsum(c_l));
% % title('Chord length cumsum function in x')