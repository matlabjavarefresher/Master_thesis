% clc;
% clear all;
% srcFiles = dir('C:\Users\prem ratan\Documents\books\academic\UQ_HIWI_PROJECT\Voxel files\Image Stack\*.dcm');
% infile = strcat('C:\Users\prem ratan\Documents\books\academic\UQ_HIWI_PROJECT\Voxel files\Image Stack\',srcFiles(1).name);
% [X,map] = dicomread(infile);
% pixel_2d_mat=double(X);
% dir=2;% direction - 1 for x and 2 for y 
% iter=1;
%hfig = figure;
% %%%% imshow(X,map);
% 
% 
% switch dir
%     
%     % %To get covariance only 1d or 2d
%     % type=1; %1 for 1d and 2 for 2d
%     % C=find_cov(pixel_2d_mat,type);
%     
%     case 1
%         
%         for num=10:500:3010
%             
%             [cor,rows]=get_plots_x(pixel_2d_mat,num);
%             
%             %Getting a matrix of averaged correlation
%             % coefficients (caleld cor) where each matrix row corresponds to one particular pixel
%             % row of the image and plotting average versus distances
%             
%             [me(iter,:)]=avg_corrcof_plots_x(cor);
%             %[mea(iter,:)]=avg_corrcof_plots_y(cor_1);
%             
%             iter=iter+1;
%             
%         end
%         
%     case 2
%         
%         for num=10:500:3010
%             
%             
%             [cor_1,cols]=get_plots_y(pixel_2d_mat,num);
%             
%             %Getting a matrix of averaged correlation
%             % coefficients (caleld cor) where each matrix row corresponds to one particular pixel
%             % row of the image and plotting average versus distances
%             
%             [mea(iter,:)]=avg_corrcof_plots_y(cor_1);
%             
%             iter=iter+1;
%             
%         end
%         
% end
        
%%%% Plotting video x 
% v_x = VideoWriter('x_dir_corvsdist.avi'); 
% v_x.FrameRate = 1;
% open(v_x);
% for i=1:size(me,1)
%     axis([0,1596,-1,1.2]);
%     plot([0:1596],me(i,:));
%     xlabel('Distance between pixels in x direction');
%     ylabel('Correlation coefficient');
%       title('Correlation coefficient vs. distance between pixels');
%     pause(2);
%       frame = getframe(hfig);
%       writeVideo(v_x,frame);
% end
% close(v_x);
% % 
% Plotting video y %%%%%
% v_y = VideoWriter('y_dir_corvsdist.avi');
% v_y.FrameRate = 1;
% open(v_y);
% for i=1:size(mea,1)
%     axis([0,1638,-1,1.2]);
%     plot([0:1638],mea(i,:));
%       xlabel('Distance between pixels in y');
%       ylabel('Correlation coefficient');
%       title('Correlation coefficient vs. distance between pixels');
%    pause(2);
%    frame = getframe(hfig);
%    writeVideo(v_y,frame);
% end
% close(v_y);

% % Getting CDF and pdf plot in y 
N=1639*1330 % total pixels selected - 1330 random column selections
sel=pixel_2d_mat(:,cols);
sorte=sort(sel(:));
figure;
plot (sorte, (1:N)/N)
title('CDF')
xlabel('Pixel color values (greyscale) y direction')
ylabel('CDF')
% 
% % Getting PDF plot
% figure;
% hist=histogram(sorte);
% % Change histogram's color and binwidth, and normalize
% hist.FaceColor='blue';
% hist.BinWidth=hist.BinWidth;
% hist.Normalization='pdf';
% 
% title('PDF')
% xlabel('Pixel color values (greyscale) y direction')
% ylabel('Relative frequency')

% Getting CDF and pdf plot in x 
% N=1390*1597; % total pixels selected - 1390 random row selections
% sel=pixel_2d_mat(rows,:);
% sorte=sort(reshape(sel',1,N));
% figure;
% plot (sorte, (1:N)/N)
% title('CDF')
% xlabel('Pixel color values (greyscale) x direction')
% ylabel('CDF')
% 
% % Getting PDF plot
% figure;
% hist=histogram(sorte);
% % Change histogram's color and binwidth, and normalize
% hist.FaceColor='blue';
% hist.BinWidth=hist.BinWidth;
% hist.Normalization='pdf';
% 
% title('PDF')
% xlabel('Pixel color values (greyscale) x direction')
% ylabel('Relative frequency')











