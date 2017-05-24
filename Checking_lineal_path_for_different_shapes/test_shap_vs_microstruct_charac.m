%% General image properties
clear
clc

img_size=[1000,1000];
img=zeros(img_size);
shape_typ='smooth_convex';  %Other options - 'circle', 'ellipse', 'smooth_convex'
n=3;% Number of shapes required
max_try=10*n; % Max number of tries to place n shapes on the image
over_lap=1; %1 for overlap and 0 for no overlap




%% Generate and display image
switch shape_typ
    
    case 'circle'
        
        r_dist=gendist_create('beta', {2,2}, 'shift',50,'scale',20);
        r= round(gendist_sample(max_try,r_dist));
        
        [img,shap_count]=create_image(img,shape_typ,n,max_try,over_lap,r);
        disp([num2str(shap_count) ' shapes were placed']);
        
    case 'ellipse'
        
        a_dist=gendist_create('beta', {2,2}, 'shift',60,'scale', 50);
        r_x= round(gendist_sample(max_try,a_dist));
        
        b_dist=gendist_create('beta', {2,2}, 'shift',60,'scale', 50);
        r_y= round(gendist_sample(max_try,b_dist));
        
        thet_dis=gendist_create('beta', {2,2}, 'shift',45,'scale',90);
        thet= round(gendist_sample(max_try,thet_dis));
        
        [img,shap_count]=create_image(img,shape_typ,n,max_try,over_lap,r_x,r_y,thet);
        disp([num2str(shap_count) ' shapes were placed']);
        
    case 'smooth_convex'
        
        aa_dist=gendist_create('beta', {2,2}, 'shift',60,'scale', 0);
        r_xx= round(gendist_sample(max_try,aa_dist));
        
        bb_dist=gendist_create('beta', {2,2}, 'shift',40,'scale', 0);
        r_yy= round(gendist_sample(max_try,bb_dist));
        
        theta_dist=gendist_create('beta', {2,2}, 'shift',46,'scale',0);
        theta= round(gendist_sample(max_try,theta_dist));
        
        pow_dist=gendist_create('beta', {2,2}, 'shift',2.5,'scale',0);
        pow= gendist_sample(max_try,pow_dist);
        
        
        [img,shap_count]=create_image(img,shape_typ,n,max_try,over_lap,r_xx,r_yy,theta,pow);
        disp([num2str(shap_count) ' shapes were placed']);
        
end
%subplot(3,3,1)
%imshow(img);

% %% Lineal path function calculation
% [l_p_x] = lineal_path_calc(img);
% [l_p_y] = lineal_path_calc(img');

% l_p=(count_x+count_y)/(tot_count_1+tot_count_2);

% %% Chord length function calculation
% [c_l_x] = chord_length_func_calc(img);
% [c_l_y] = chord_length_func_calc(img');
% %
% % c_l=(count_xx+count_yy)/(tot_chords_1+tot_chords_2);
% %
% %% Auto correlation calculation
% [a_c_x] = auto_corr(img);
% [a_c_y] = auto_corr(img');
% 
% %% Minkowsky functionals calculation
% per1=imPerimeter(img);
% are1=imArea(img);
% [ar2,peri2,ec2,cap2]=compute_mink_2d(img);
% [ar3,per3,ec3]=compute_mink_marchin_sqr(img,0.5);



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