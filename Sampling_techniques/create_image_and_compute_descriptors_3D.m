function [ mean_descriptors ] = create_image_and_compute_descriptors_3D( model_params, cutoff_func, combine_func, overlap_func, model_runs_per_sample)

im_in=model_params.Results.image_in;
res=model_params.Results.resolution;
nsh=model_params.Results.num_shapes;
max_try=model_params.Results.max_tries;
itl=model_params.Results.image_top_left;
S=model_params.Results.shape_specific_properties;
image_set=zeros(model_runs_per_sample,size(im_in,1),size(im_in,2),size(im_in,3));

for i=1:model_runs_per_sample
[image,~]=create_image_3D(im_in, res, nsh, max_try, itl, S, cutoff_func, combine_func, overlap_func);
image_binary=image>0.5;
image_set(i,:,:,:)=image_binary;
%figure;
%view_3D(image_binary);
end

[mean_descriptors]=compute_descriptors_average(image_set);
% descriptors= compute_descriptors(image_binary);

end

