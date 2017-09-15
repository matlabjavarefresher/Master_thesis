[model_params,cutoff_func,combine_func,overlap_func]=...
initialise_image_creation_model_3D('num_shapes',408.6,...
'initial_shapes',26.6,'min_overlap',18045,'a_dist',[24.25;11.98],'b_dist',...
[23.83;14.53],'c_dist',[24.34;15.4],'ellipsoid_fraction',0.777);
% [model_params,cutoff_func,combine_func,overlap_func]=...
% initialise_image_creation_model_3D('num_shapes',408.6,...
% 'initial_shapes',26.6,'min_overlap',18045,'a_dist',[21.42;11.75],'b_dist',...
% [25.77;14.82],'c_dist',[21.64;14.35],'ellipsoid_fraction',0.777);
% [model_params,cutoff_func,combine_func,overlap_func]=...
% initialise_image_creation_model_3D('num_shapes',382,...
% 'initial_shapes',34,'min_overlap',15400,'a_dist',[21.42;11.75],'b_dist',...
% [25.77;14.82],'c_dist',[21.64;14.35],'ellipsoid_fraction',0.741);
im_in=model_params.Results.image_in;
res=model_params.Results.resolution;
nsh=model_params.Results.num_shapes;
max_try=model_params.Results.max_tries;
itl=model_params.Results.image_top_left;
S=model_params.Results.shape_specific_properties;model_runs_per_sample=1;
image_set=zeros(model_runs_per_sample,size(im_in,1),size(im_in,2),size(im_in,3));
least_square_costs=zeros(11,20);
image_bins=zeros(3,300,300,300);
ib=1;
for j=1:10
for i=1:model_runs_per_sample
[image,~]=create_image_3D(im_in, res, nsh, max_try, itl, S, cutoff_func, combine_func, overlap_func);
image_binary=image>0.5;
image_set(i,:,:,:)=image_binary;
%figure;
%view_3D(image_binary);
end
[mean_descriptors_gen]=compute_descriptors_average_3D(image_set);
lsc=least_square_cost(mean_descriptors_gen,mean_descriptors_tla,ones(11,1));
least_square_costs(:,j)=lsc;
if sum(lsc) <6
    image_bins(ib,:,:,:)=image_binary;
    ib=ib+1;
end
end