
clc;
clear all;

srcFiles = dir('C:\Users\prem ratan\Documents\books\academic\UQ_HIWI_PROJECT\Voxel files\Image Stack\*.dcm');
infile = strcat('C:\Users\prem ratan\Documents\books\academic\UQ_HIWI_PROJECT\Voxel files\Image Stack\',srcFiles(1).name);
[X,map] = dicomread(infile);

for i = 1 : 10
    a=X(2^i,:);
    b=double(a);
    x=[1:1597];
    figure;
    subplot(10,1,i)
    plot(x,b);
    
%     figure;
%     imhist(a);
    
%     maxi=max(maxim');
%     level = graythresh(X);
%     BW = im2bw(X,map,level);
%     fname = sprintf('converted_%d.dcm', i);
% %   destfile= strcat('converted_', num2str(i));
%     dicomwrite(BW,fname);

end




