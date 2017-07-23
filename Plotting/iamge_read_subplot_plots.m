%% Reading in descriptors data from .mat files located in a directory, 
% storing them in cells and finally plotting them

clear
files = dir('*.mat');
for i=1:length(files)
  value = getfield(files(i), 'name');
  load(value);
  A_C_X{i} = a_c_x;
  A_C_Y{i} = a_c_y;
  C_L_X{i} = c_l_x;
  C_L_Y{i} = c_l_y;
  L_P_X{i} = l_p_x;
  L_P_Y{i} = l_p_y;
end

% Plotting descriptors stored as cells

for i=7:15
subplot(2,3,1);
plot(1:length(L_P_X{i}),L_P_X{i});
title('Lineal path function in x')
hold on;
subplot(2,3,2);
plot(1:length(L_P_Y{i}),L_P_Y{i});
title('Lineal path function in y')
hold on;
subplot(2,3,3);
plot(1:length(C_L_X{i}),C_L_X{i});
NumTicks = 11;
L = get(gca,'XLim');
set(gca,'XTick',linspace(L(1),L(2),NumTicks))
title('Chord length function in x');
hold on;
subplot(2,3,4)
plot(1:length(C_L_Y{i}),C_L_Y{i});
NumTicks = 11;
L = get(gca,'XLim');
set(gca,'XTick',linspace(L(1),L(2),NumTicks))
title('Chord length function in y');
hold on;
subplot(2,3,5)
plot(0:length(A_C_X{i})-1,A_C_X{i});
title('Auto correlation w.r.t. distance in x');
hold on;
subplot(2,3,6)
plot(0:length(A_C_Y{i})-1,A_C_Y{i});
title('Auto correlation w.r.t. distance in y');
hold on;
end


%% Reading in images stored in .mat data files and computing descriptors
% on them  

files = dir('*.mat');
j=1; % j has been initialised because i need not take continuosly 
     % increasing values like 1:6 but can take 50:7:80 etc. etc.  

% for prous material physical sample use i=50:7:80 etc.
marching_square_threshold=0.5; % default threshold for the compute_mink_marching_sqr function  

for i=1:6
    % For created porous media or created vs generated porous media
    value = getfield(files(i), 'name');
    load(value);
    B=image_out_binary;
    image_set(i,:,:)=image_out_binary;
     
     %% For physical sample
%     A=squeeze(Image_stack(i,:,:));
%     A_gray=mat2gray(A);
%     level=0.3; 
%      B=im2bw(A_gray,level);

    %% Computing
    A_C_X(j,:)=auto_corr(B);
    A_C_Y(j,:)=auto_corr(B');
    C_L_X(j,:) = chord_length_func_calc(B);
    C_L_X_CON(j,:)=conv(C_L_X(j,:),ones(1,25)/25,'same');
    C_L_Y(j,:) = chord_length_func_calc(B');
    C_L_Y_CON(j,:)=conv(C_L_Y(j,:),ones(1,25)/25,'same');
    L_P_X(j,:) = lineal_path_calc(B);
    L_P_Y(j,:) = lineal_path_calc(B');
    mink_crofton(j,:)=[imPerimeter(B),imArea(B), imEuler2d(B)];
    [p,a,e,c_p_a]=compute_mink_reconstruct(B);
    mink_reconstruct(j,:)=[p, a, e];
    [p1,a1,ec1]=compute_mink_marchin_sqr(B,marching_square_threshold);
    mink_marching_square(j,:)=  [p1,a1,ec1];
    j=j+1;
end

%% Plotting all the descriptors corresponding to different images as 
% subplots
image_count=6;
f=figure;
p=uipanel('Parent',f,'BorderType','none');
p.Title='Descriptors for five cross sections of the porous material';
p.TitlePosition='centertop';
p.FontSize=12;
p.FontWeight='bold';
linS = {'-','-','--',':','-.','--'};
linThick=[3,1.5,1.5,1.5,1.5,3];
%colorVec ={'k','r','g','b','y','k'};


for i=1:image_count

subplot(3,3,1,'Parent',p);
p1=plot(1:length(L_P_X(i,1:1000)),L_P_X(i,1:1000),linS{i},'linewidth',linThick(i));%,'Color',colorVec{i});
title('Lineal path function in x')
set(gca,'XTickLabelRotation', 30');
hold on;

subplot(3,3,2,'Parent',p);
p2=plot(1:length(L_P_Y(i,1:1000)),L_P_Y(i,1:1000),linS{i},'linewidth',linThick(i));%,'Color',colorVec{i});
set(gca,'XTickLabelRotation', 30');
title('Lineal path function in y')
hold on;

subplot(3,3,3,'Parent',p);
p3=plot(1:length(C_L_X_CON(i,1:1000)),C_L_X_CON(i,1:1000),linS{i},'linewidth',linThick(i));%,'Color',colorVec{i});
NumTicks = 11;
L = get(gca,'XLim');
set(gca,'XTick',linspace(L(1),L(2),NumTicks))
set(gca,'XTickLabelRotation', 30');
title('Chord length function in x');
hold on;

subplot(3,3,4,'Parent',p)
p4=plot(1:length(C_L_Y_CON(i,1:1000)),C_L_Y_CON(i,1:1000),linS{i},'linewidth',linThick(i));%,'Color',colorVec{i});
NumTicks = 11;
L = get(gca,'XLim');
set(gca,'XTick',linspace(L(1),L(2),NumTicks));
set(gca,'XTickLabelRotation', 30');
title('Chord length function in y');
hold on;

subplot(3,3,5,'Parent',p)
p5=plot(0:length(A_C_X(i,1:1000))-1,A_C_X(i,1:1000),linS{i},'linewidth',linThick(i));%,'Color',colorVec{i});
set(gca,'XTickLabelRotation', 30');
title('S_2 w.r.t. distance in x');
hold on;

subplot(3,3,6,'Parent',p)
p6=plot(0:length(A_C_Y(i,1:1000))-1,A_C_Y(i,1:1000),linS{i},'linewidth',linThick(i));%,'Color',colorVec{i});
set(gca,'XTickLabelRotation', 30');
title('S_2 w.r.t. distance in y');
hold on;

subplot(3,3,7,'Parent',p)
% p7=stem(i,mink_reconstruct(i,1)',linS{i},'linewidth',linThick(i))%,'Color',colorVec{i});
% xlim([0 3*image_count+1]);
% hold on;
% p8=stem(i+image_count,mink_marching_square(i,1)',linS{i},'linewidth',linThick(i))%,'Color',colorVec{i});
% hold on;
 p9=stem(i,mink_crofton(i,1)',linS{i},'linewidth',linThick(i));%,'Color',colorVec{i});
 xlim([0 image_count+1]);
 xlabel('Samples');
 ylabel('Perimeter');
 hold on;
% 
 subplot(3,3,8,'Parent',p)
% p10=stem(i,mink_reconstruct(i,2)',linS{i},'linewidth',linThick(i));
% xlim([0 3*image_count+1]);
% hold on;
% p11=stem(i+image_count,mink_marching_square(i,2)',linS{i},'linewidth',linThick(i));
% hold on;
 p12=stem(i,mink_crofton(i,2)',linS{i},'linewidth',linThick(i));
 xlim([0 image_count+1]);
 xlabel('Samples');
 ylabel('Area');
 hold on;
% 
 subplot(3,3,9,'Parent',p)
% p13=stem(i,mink_reconstruct(i,3)',linS{i},'linewidth',linThick(i));
% xlim([0 3*image_count+1]);
% hold on;
% p14=stem(i+image_count,mink_marching_square(i,3)',linS{i},'linewidth',linThick(i));
% hold on;
 p15=stem(i,mink_crofton(i,3)',linS{i},'linewidth',linThick(i));
 xlim([0 image_count+1]);
 xlabel('Samples');
 ylabel('Euler characteristic');
 hold on;

end

lg=legend('Sample 1','Sample 2','Sample 3','Slice 1','Slice 2','Slice 3');
newPos = [0.01 0.6 0.1 0.3];
newUnits = 'normalized';
set(lg,'Position', newPos,'Units', newUnits);

%% Displaying the images themselves as subplots

first_set_of_5=(20:3:33);
second_set_of_5=(1:7:30);
third_set_of_5=(7:5:29);
fourth_set_of_5=(50:7:80);

ff=figure;
p=uipanel('Parent',ff,'BorderType','none');
p.Title='Five cross sections of the generated porous material';
p.TitlePosition='centertop';
p.FontSize=12;
p.FontWeight='bold';
 
for i=1:6
    % For actual porous media
%     A=squeeze(Image_stack(fourth_set_of_5(i),:,:));
%     A_gray=mat2gray(A);
%     level=graythresh(A_gray)
%     B=im2bw(A_gray,level);
%     else
     %% For generated porous media
    B=squeeze(image_set(i,:,:));
    subplot(2,3,i,'Parent',p);
    imshow(B);
    
end

%hL = legend([p1,p2,p3,p4],{'Data Axes 1','Data Axes 2','Data Axes 3','Data Axes 4'});


exportfig('descriptors_on_r1_s1.pdf',...
'width',27,...
'color','rgb')

fig = gcf;
fig.PaperPositionMode = 'auto';print('descriptors_on_r1_s1','-dpng','-r300');


addpath('D:/MATLAB/PlotPub-2.0');