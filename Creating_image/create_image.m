function [image,shape_count,image_store]=create_image(image, res, num_shapes, max_tries, image_top_left, S, ...
    cutoff_func, combine_func, overlap_func, varargin)

shape_count = 0;
iter = 0;
store=1; % Used to store resulting image after the placement of each 
         % batch of 100 shapes
% ss=S.sample(max_tries,'mode','qmc'); % comment this for normal MC sampling
ss=S.sample(max_tries);  % Uncomment this for normal MC sampling
while (shape_count<num_shapes && iter<max_tries)
      s=ss(:,iter+1); %comment this
    % s=S.sample(1); % UNcomment this
     a=s(1);
     b=s(2);
     theta=s(3);
     exponent=s(4);
     shape_center_global=[s(5); s(6)];
    iter=iter+1;
    [shape, shape_top_left] = compute_local_shape(image_top_left, res, [a;b], exponent, shape_center_global, theta, cutoff_func);
    add=check_overlap(shape, image, shape_top_left, overlap_func, shape_count);

    if add==0
        continue;
    end

    image = place_image(image, shape, shape_top_left, combine_func);
    shape_count=shape_count+1
    
    if mod(shape_count,30)==0
    image_store(store,:,:)=image;
    store=store+1;
    end
end

