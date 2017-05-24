function [in_img,ref_img,req_desc] = set_inp_sim_annel()

%% Setting reference image
%fileID = fopen('rand_10X10_matrix.txt','r');
%formatSpec = '%d';
%sizeref = [10 10];
%ref_img = fscanf(fileID,formatSpec,sizeref);
%ref_img = ref_img';

%ref_img=randi([0,1],200,200);


ref=load('C:\Users\prem ratan\Documents\books\academic\Master thesis\Master_thesis\Simu_anneal\Input_data\img.mat');
ref_img=ref.img;

%% Random initial image with the same volume fraction as the reference image

v_frac=length(find(ref_img==1));

ext_indi=randperm(numel(ref_img));

indi=ext_indi(1:v_frac);

in_img=zeros(size(ref_img,1),size(ref_img,2));

in_img(indi)=1;

%in_img=randi([0,1],size(ref_img,1),size(ref_img,2));

%% Required descriptors

req_desc={'lp','cd','s2'};

end

