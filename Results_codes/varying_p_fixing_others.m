clear all;
clc;

% Defining a, b, p and theta

img=zeros(1000);
n=100;
max_try=10*n;
over_lap=1;
shape_typ='smooth_convex';

a=60*ones(max_try,1);
b=40*ones(max_try,1);
theta_dist=gendist_create('beta', {2,2}, 'shift',0,'scale',30);
theta= gendist_sample(max_try,theta_dist);
p=logspace2(2,100,6)'*ones(1,max_try);

%Initialising sizes
l_p_x = zeros(size(p,2),size(img,2));
l_p_y = zeros(size(p,2),size(img,1));
c_l_x_con=zeros(size(p,2),size(img,2));
c_l_y_con= zeros(size(p,2),size(img,1));
a_c_x=zeros(size(p,2),size(img,2));
a_c_y=zeros(size(p,2),size(img,1));
imag=zeros(size(p,2),size(img,1),size(img,2));

for i=1:size(p,1)
    
    [img1,shap_count]=create_image(img,shape_typ,n,max_try,over_lap,a,b,theta,p(i,:));
    disp([num2str(shap_count) ' shapes were placed']);
    
    % Lineal path function calculation
    
    l_p_x(i,:) = lineal_path_calc(img1);
    
    l_p_y(i,:) = lineal_path_calc(img1');
    
    % Chord length density calculation
    
    c_l_x = chord_length_func_calc(img1);
    c_l_x_con(i,:)=conv(c_l_x,ones(1,15)/15,'same');
    
    [c_l_y] = chord_length_func_calc(img1');
    c_l_y_con(i,:)=conv(c_l_y,ones(1,15)/15,'same');
    
    % Auto correlation calculation
    
    [a_c_x(i,:)] = auto_corr(img1);
    [a_c_y(i,:)] = auto_corr(img1');
    
    imag(i,:,:)=img1;
    
end

%% Cutting off l_p_x and c_l_f_con due to lack of activity after n=400

c_o_l=400;
l_p_x=l_p_x(:,1:c_o_l);
l_p_y=l_p_y(:,1:c_o_l);
c_l_x_con=c_l_x_con(:,1:c_o_l);
c_l_y_con=c_l_y_con(:,1:c_o_l);

%% Plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
title('Shapes for different p');

for i=1:size(p,1)
    img2=squeeze(imag(i,:,:));
    subplot(2,3,i);
    imshow(img2);
    title(['p = ' num2str(floor(p(i,1)))]);
end


figure;

%% Plotting l_p_f
for i=1:size(p,1)
    subplot(2,3,i)
    plot(1:length(l_p_x(i,:)),l_p_x(i,:),'r',1:length(l_p_y(i,:)),l_p_y(i,:),'g');
    title(['p = ' num2str(floor(p(i,1)))]);
    xlabel('Lineal path');
    ylabel('Probability');
    xlabh = get(gca,'XLabel');
    set(xlabh,'Position',get(xlabh,'Position') - ((1-i)==0)*[0 0.027 0] +  [0 .05 0]);
    % + ((1-i)==0)*[0 0.001 0]
    legend('X direction','Y direction');
end

figure;

%% Plotting c_l_f
for i=1:size(p,1)
    subplot(2,3,i)
    plot(1:length(c_l_x_con(i,:)),c_l_x_con(i,:),'r',1:length(c_l_y_con(i,:)),c_l_y_con(i,:),'g');
    title(['p = ' num2str(floor(p(i,1)))]);
    xlabel('Chord length');
    ylabel('Probability');
    xlabh = get(gca,'XLabel');
    set(xlabh,'Position',get(xlabh,'Position') - ((1-i)==0)*[0 0.002 0] + [0 .0045 0]);
    legend('X direction','Y direction');
end

figure;

%% Plotting auto_corr
for i=1:size(p,1)
    subplot(2,3,i)
    plot(1:length(a_c_x(i,:)),a_c_x(i,:),'r',1:length(a_c_y(i,:)),a_c_y(i,:),'g');
    title(['p = ' num2str(floor(p(i,1)))]);
    xlabel('Inter pixel distance');
    ylabel('Correlation');
    xlabh = get(gca,'XLabel');
    get(xlabh,'Position')
    set(xlabh,'Position',get(xlabh,'Position') - ((1-i)==0)*[0 0.0001 0] + [0 .0002 0]);
    legend('X direction','Y direction');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
plot(1:length(a_c_x(1,:)),a_c_x(1,:),'r:')%,'r:',1:length(a_c_y(1,:)),a_c_y(1,:),'g:','Linewidth',1);
hold on;
plot(1:length(a_c_x(2,:)),a_c_x(2,:),'r--')%,'r--',1:length(a_c_y(2,:)),a_c_y(2,:),'g--','Linewidth',1);
hold on;
plot(1:length(a_c_x(3,:)),a_c_x(3,:),'r')%,'r',1:length(a_c_y(3,:)),a_c_y(3,:),'g','Linewidth',1);
hold on;
plot(1:50:length(a_c_x(4,:)),a_c_x(4,1:50:end),'r*')%,1:70:length(a_c_y(4,:)),a_c_y(4,1:70:end),'g*','Markersize',8);
hold on;
plot(1:60:length(a_c_x(5,:)),a_c_x(5,1:60:end),'ro')%,1:90:length(a_c_y(5,:)),a_c_y(5,1:90:end),'go','Markersize',8);
hold on;
plot(1:70:length(a_c_x(6,:)),a_c_x(6,1:70:end),'rs')%,1:110:length(a_c_y(6,:)),a_c_y(6,1:110:end),'gs','Markersize',8);
hold on;
plot(1:length(a_c_x(4,:)),a_c_x(4,:),'r')%,'r',1:length(a_c_y(4,:)),a_c_y(4,:),'g','Linewidth',1);
hold on;
plot(1:length(a_c_x(5,:)),a_c_x(5,:),'r')%,'r',1:length(a_c_y(6,:)),a_c_y(6,:),'g','Linewidth',1);
hold on;
plot(1:length(a_c_x(6,:)),a_c_x(6,:),'r')%,'r',1:length(a_c_y(6,:)),a_c_y(6,:),'g','Linewidth',1);
hold on;
title('Correlation versus distance in x')
xlabel('Inter pixel distance');
ylabel('Correlation');
legend (['p = ' num2str(floor(p(1,1)))],['p = ' num2str(floor(p(2,1)))],['p = ' num2str(floor(p(3,1)))],['p = ' num2str(floor(p(4,1)))],['p = ' num2str(floor(p(5,1)))],['p = ' num2str(floor(p(6,1)))]);


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
plot(1:length(a_c_y(1,:)),a_c_y(1,:),'g:','Linewidth',1.5)%,'r:',1:length(a_c_y(1,:)),a_c_y(1,:),'g:','Linewidth',1.5);
hold on;
plot(1:length(a_c_y(2,:)),a_c_y(2,:),'g--')%,'r--',1:length(a_c_y(2,:)),a_c_y(2,:),'g--','Linewidth',1);
hold on;
plot(1:length(a_c_y(3,:)),a_c_y(3,:),'g')%,'r',1:length(a_c_y(3,:)),a_c_y(3,:),'g','Linewidth',1);
hold on;
plot(1:50:length(a_c_y(4,:)),a_c_y(4,1:50:end),'g*')%,1:70:length(a_c_y(4,:)),a_c_y(4,1:70:end),'g*','Markersize',8);
hold on;
plot(1:60:length(a_c_y(5,:)),a_c_y(5,1:60:end),'go')%,1:90:length(a_c_y(5,:)),a_c_y(5,1:90:end),'go','Markersize',8);
hold on;
plot(1:length(a_c_y(6,:)),a_c_y(6,:),'g','Linewidth',1.5)%,'r',1:length(a_c_y(6,:)),a_c_y(6,:),'g','Linewidth',1);
hold on;
title('Correlation versus distance in y')
xlabel('Inter pixel distance');
ylabel('Correlation');
legend (['p = ' num2str(floor(p(1,1)))],['p = ' num2str(floor(p(2,1)))],['p = ' num2str(floor(p(3,1)))],['p = ' num2str(floor(p(4,1)))],['p = ' num2str(floor(p(5,1)))],['p = ' num2str(floor(p(6,1)))]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

figure;
plot(1:length(l_p_x(1,:)),l_p_x(1,:),'r')%,'r:',1:length(a_c_y(1,:)),a_c_y(1,:),'g:','Linewidth',1);
hold on;
plot(1:length(l_p_x(2,:)),l_p_x(2,:),'r--')%,'r--',1:length(a_c_y(2,:)),a_c_y(2,:),'g--','Linewidth',1);
hold on;
plot(1:length(l_p_x(3,:)),l_p_x(3,:),'r:')%,'r',1:length(a_c_y(3,:)),a_c_y(3,:),'g','Linewidth',1);
hold on;
plot(1:50:length(l_p_x(4,:)),l_p_x(4,1:50:end),'r-.')%,1:70:length(a_c_y(4,:)),a_c_y(4,1:70:end),'g*','Markersize',8);
hold on;
plot(1:60:length(l_p_x(5,:)),l_p_x(5,1:60:end),'r--','Linewidth',1.5)%,1:90:length(a_c_y(5,:)),a_c_y(5,1:90:end),'go','Markersize',8);
hold on;
plot(1:70:length(l_p_x(6,:)),l_p_x(6,1:70:end),'r','Linewidth',1.5)%,1:110:length(a_c_y(6,:)),a_c_y(6,1:110:end),'gs','Markersize',8);
hold on;
title('Lineal path in x')
xlabel('Lineal path');
ylabel('Probability');
legend (['p = ' num2str(floor(p(1,1)))],['p = ' num2str(floor(p(2,1)))],['p = ' num2str(floor(p(3,1)))],['p = ' num2str(floor(p(4,1)))],['p = ' num2str(floor(p(5,1)))],['p = ' num2str(floor(p(6,1)))]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
plot(1:length(l_p_y(1,:)),l_p_y(1,:),'g')%,'r:',1:length(a_c_y(1,:)),a_c_y(1,:),'g:','Linewidth',1);
hold on;
plot(1:length(l_p_y(2,:)),l_p_y(2,:),'g--')%,'r--',1:length(a_c_y(2,:)),a_c_y(2,:),'g--','Linewidth',1);
hold on;
plot(1:length(l_p_y(3,:)),l_p_y(3,:),'g:')%,'r',1:length(a_c_y(3,:)),a_c_y(3,:),'g','Linewidth',1);
hold on;
plot(1:50:length(l_p_y(4,:)),l_p_y(4,1:50:end),'g-.')%,1:70:length(a_c_y(4,:)),a_c_y(4,1:70:end),'g*','Markersize',8);
hold on;
plot(1:60:length(l_p_y(5,:)),l_p_y(5,1:60:end),'g--','Linewidth',1.5)%,1:90:length(a_c_y(5,:)),a_c_y(5,1:90:end),'go','Markersize',8);
hold on;
plot(1:70:length(l_p_y(6,:)),l_p_y(6,1:70:end),'g','Linewidth',1.5)%,1:110:length(a_c_y(6,:)),a_c_y(6,1:110:end),'gs','Markersize',8);
hold on;
title('Lineal path in y')
xlabel('Lineal path');
ylabel('Probability');
legend (['p = ' num2str(floor(p(1,1)))],['p = ' num2str(floor(p(2,1)))],['p = ' num2str(floor(p(3,1)))],['p = ' num2str(floor(p(4,1)))],['p = ' num2str(floor(p(5,1)))],['p = ' num2str(floor(p(6,1)))]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
plot(1:length(c_l_x_con(1,:)),c_l_x_con(1,:),'r')%,'r:',1:length(a_c_y(1,:)),a_c_y(1,:),'g:','Linewidth',1);
hold on;
plot(1:length(c_l_x_con(2,:)),c_l_x_con(2,:),'r--')%,'r--',1:length(a_c_y(2,:)),a_c_y(2,:),'g--','Linewidth',1);
hold on;
plot(1:length(c_l_x_con(3,:)),c_l_x_con(3,:),'r:','Linewidth',1.5)%,'r',1:length(a_c_y(3,:)),a_c_y(3,:),'g','Linewidth',1);
hold on;
plot(1:length(c_l_x_con(4,:)),c_l_x_con(4,:),'r-.')%,1:70:length(a_c_y(4,:)),a_c_y(4,1:70:end),'g*','Markersize',8);
hold on;
plot(1:length(c_l_x_con(5,:)),c_l_x_con(5,:),'r--','Linewidth',1.5)%,1:90:length(a_c_y(5,:)),a_c_y(5,1:90:end),'go','Markersize',8);
hold on;
plot(1:length(c_l_x_con(6,:)),c_l_x_con(6,:),'r','Linewidth',1.5)%,1:110:length(a_c_y(6,:)),a_c_y(6,1:110:end),'gs','Markersize',8);
hold on;
title('Chord length density in x')
xlabel('Chord length');
ylabel('Probability');
legend (['p = ' num2str(floor(p(1,1)))],['p = ' num2str(floor(p(2,1)))],['p = ' num2str(floor(p(3,1)))],['p = ' num2str(floor(p(4,1)))],['p = ' num2str(floor(p(5,1)))],['p = ' num2str(floor(p(6,1)))]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

figure;
plot(1:length(c_l_y_con(1,:)),c_l_y_con(1,:),'g')%,'r:',1:length(a_c_y(1,:)),a_c_y(1,:),'g:','Linewidth',1);
hold on;
plot(1:length(c_l_y_con(2,:)),c_l_y_con(2,:),'g--')%,'r--',1:length(a_c_y(2,:)),a_c_y(2,:),'g--','Linewidth',1);
hold on;
plot(1:length(c_l_y_con(3,:)),c_l_y_con(3,:),'g:','Linewidth',1.5)%,'r',1:length(a_c_y(3,:)),a_c_y(3,:),'g','Linewidth',1);
hold on;
plot(1:length(c_l_y_con(4,:)),c_l_y_con(4,:),'g-.')%,1:70:length(a_c_y(4,:)),a_c_y(4,1:70:end),'g*','Markersize',8);
hold on;
plot(1:length(c_l_y_con(5,:)),c_l_y_con(5,:),'g--','Linewidth',1.5)%,1:90:length(a_c_y(5,:)),a_c_y(5,1:90:end),'go','Markersize',8);
hold on;
plot(1:length(c_l_y_con(6,:)),c_l_y_con(6,:),'g','Linewidth',1.5)%,1:110:length(a_c_y(6,:)),a_c_y(6,1:110:end),'gs','Markersize',8);
hold on;
title('Chord length density in y')
xlabel('Chord length');
ylabel('Probability');
legend (['p = ' num2str(floor(p(1,1)))],['p = ' num2str(floor(p(2,1)))],['p = ' num2str(floor(p(3,1)))],['p = ' num2str(floor(p(4,1)))],['p = ' num2str(floor(p(5,1)))],['p = ' num2str(floor(p(6,1)))]);

%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%
% %legend('a','b','c');
% % for i=1:size(p,1)
% %     plot(1:length(a_c_x(i,:)),a_c_x(i,:),'r',1:length(a_c_y(i,:)),a_c_y(i,:),'g');
% %     hold on;
% %     %title(['p = ' num2str(i+1)]);
% %     %get(xlabh,'Position')
% %     %set(xlabh,'Position',get(xlabh,'Position') + ((1-i)==0)*[0 0.0042 0] + [0 .0025 0]);
% %
% %     %xlabh = get(gca,'XLabel');
% %     %set(xlabh,'Position',get(xlabh,'Position') + ((1-i)==0)*[0 0.001 0] + [0 .05 0]);
% %     %legend('X direction','Y direction');
% % end