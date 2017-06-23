clear
clc

%% Initialising the Image (background for the shapes)

gx1y1 = [3; 4.5];
gx2y2 = [1000; 1000];

res=1;

gn = ceil((gx2y2-gx1y1).*res);
img0 = zeros(gn')';

sh_tp='smooth_convex';  % 'smooth_convex', Other options if and when required
ns=30;% Number of shapes required
mx_tr=10*ns; % Max number of tries to place ns shapes on the image
ov=0; %1 for allow overlap, 0 for no overlap and anything b/w 0 and 1 for
% partial overlap
% cutoff_func= @cutoff_sharp;
cut_fn= @(x,res)cutoff_smooth(x,res,20);
%combinator_func= @combine_sum1;
comb_fn= @combine_sum2;
ov_fn = @(im1,im2,res,am_bm) allow_absolute_overlap(im1,im2,res,am_bm,0.8);

%% Generate and display image

switch sh_tp
    case 'smooth_convex'
        
        mn_pow = 2; mx_pow = 10;
        %min_pow = 1.0; max_pow = 7.05;
        S=SimParamSet();
        S.add(SimParameter('a_dist',translate(BetaDistribution(2,2), 60, 10)));
        S.add(SimParameter('b_dist',translate(BetaDistribution(2,2), 40, 20)));
        S.add(SimParameter('theta_dist',translate(BetaDistribution(2,2), 0, pi/2)));
        S.add(SimParameter('pow_dist',translate(BetaDistribution(2,2), (mn_pow+mx_pow)/2, (mx_pow-mn_pow)/2)));
        %S.add(SimParameter('pow_dist',translate(ExponentialDistribution(0.5), min_pow)));
        S.add(SimParameter('C_X',UniformDistribution(-0.2*(size(img0,2)/res),1.2*(size(img0,2)/res))));
        S.add(SimParameter('C_Y',UniformDistribution(-0.2*(size(img0,1)/res),1.2*(size(img0,1)/res))));
        
        [img1,sh_cnt]=create_image(img0,res,ns,ov,mx_tr,sh_tp,gx1y1,S,cut_fn,comb_fn,ov_fn);
        
        disp([num2str(sh_cnt) ' shapes were placed']);
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