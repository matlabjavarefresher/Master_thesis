function [ mean_descriptors ] = compute_descriptors_average_3D(image_set)

rows=size(image_set,2);
cols=size(image_set,3);
slices=size(image_set,4);
max_size=max([rows,cols,slices]);
num_images=size(image_set,1);

descriptors_set=zeros(num_images,11,max_size);

for i=1:num_images
    image=squeeze(image_set(i,:,:,:));
    descriptors_set(i,:,:)=compute_descriptors(image); 
end

sum_descriptor_set=squeeze(sum(descriptors_set,1));
mean_descriptors=sum_descriptor_set/num_images;
    
end

