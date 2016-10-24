% 
% % imshow(mean_pixels,[]); mean_pixels=uint16(mean_arr);
% srcFiles = dir('C:\Users\prem ratan\Documents\books\academic\UQ_HIWI_PROJECT\Voxel files\Image Stack\*.dcm');
% 
% N=10;% number of images required
% 
% % Read in the 2d images and collect them into a 3d matrix
% for i=1:N
%     infile = strcat('C:\Users\prem ratan\Documents\books\academic\UQ_HIWI_PROJECT\Voxel files\Image Stack\',srcFiles(i).name);
%     [X,map] = dicomread(infile);
%     Collec(:,:,i)= double(X);
% end
% 
% % Finding mean at each pixel(mean image)
% mean_arr=mean(Collec,3);
% 
% % Finding how much each image varies from the mean image
% for i=1:N
%     difference_images(:,:,i)=Collec(:,:,i)-mean_arr;
% end
% 
% % Converting difference images(2-d pixel matrices) into difference vectors
% % - sizee of [1639,1597] to a size of [1639*1597,1]
% for i=1:N
%     difference_vectors(:,i)=reshape(difference_images(:,:,i),[1639*1597,1]);
%end
% 
% 
% covariance=(1/(1639*1597))*(difference_vectors'*difference_vectors);
% 
% % Finding correlation matrix 
% %correlat_int_1= difference_vectors.^2;
% 
% 
% 
% 
% [V,D]=eig(covariance);
% 
% Getting the eigen images
% for i=1:N
%     eig_image(:,i)=difference_vectors*V(:,i);
% end
% 
% for i=1:N
%     fin_eig_images(:,:,i)=reshape(eig_image(:,i),[1639,1597]);
% end
% 
% for i=1:N
%     converted=uint16(fin_eig_images(:,:,i));
%     figure;
%     imshow(converted,[]);
% end

%%%Trying corr_coeff on my own
%%correlation_denom= mean((difference_vectors.^2),2);
%%normalised_difference_vec= bsxfun(@rdivide,difference_vectors , correlation_denom(:,1));

%%correl_coeffs= (normalised_difference_vec*normalised_difference_vec);

% corr_coeff=corrcoef(difference_vectors);


% %%% Distance matrix
% x_ax=[1:1639];
% y_ax=[1:1597];
% z_ax=[1:N];
% [X,Y,Z] = meshgrid(x_ax,y_ax,z_ax);
% F = sqrt(X.^2 + Y.^2 + Z.^2);
% [F1,F2] = ndgrid(F,F);



















