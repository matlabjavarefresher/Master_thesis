function [ descriptors ] = create_image_and_compute_descriptors( image_in, res, x_1, max_tries, image_top_left,S,cutoff_func,combine_func,overlap_func )

[image,~]=create_image(image_in, res, x_1, max_tries, image_top_left,S,cutoff_func,combine_func,overlap_func);
image_gray=mat2gray(image);        
image_binary=image_gray>0.5;

descriptors= compute_descriptors(image_binary);


end

