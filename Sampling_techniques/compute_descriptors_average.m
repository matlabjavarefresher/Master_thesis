function [ mean_descriptors ] = compute_descriptors_average(image_set)

rows=size(image_set,2);
cols=size(image_set,3);
max_size=max(rows,cols);
num_images=size(image_set,1);

descriptor_set=zeros(num_images,7,max_size);

for i=1:num_images
    
    image=squeeze(image_set(i,:,:));
    descriptor_set(i,:,:)=compute_descriptors(image); 
end

sum_descriptor_set=squeeze(sum(descriptor_set,1));
mean_descriptors=sum_descriptor_set/num_images;
    
end

