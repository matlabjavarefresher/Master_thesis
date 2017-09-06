function [image,shape_count]=create_image_3D(image, res, num_shapes, max_tries, image_top_left, S, ...
    cutoff_func, combine_func, overlap_func, varargin)

shape_count=0;
%queried_shape=0;
iter=0;
max_number_of_queries=20;

% store=1; % Used to store resulting image after the placement of each
% batch of 100 shapes
ss=S.sample(max_tries);
while (shape_count<num_shapes && iter<max_tries)
    s=ss(:,iter+1);
    a=s(1);
    b=s(2);
    c=s(3);
    yaw=s(4);
    pitch=s(5);
    roll=s(6);
    exponent=2+s(7);
    shape_center_global=[s(8); s(9);s(10)];
    iter=iter+1;
    [shape, shape_top_left] = compute_local_shape_3D(image_top_left,...
        res, [a;b;c], exponent, shape_center_global, [yaw;pitch;roll], cutoff_func);
    add=check_overlap_3D(shape, image, shape_top_left, overlap_func, shape_count);
    
    if add==0
        % Checking if the the obtained shape could be used with other
        % shape centers before throwing away the shape. This is done
        % because shape computation is expensive.
        for i=1:max_number_of_queries
            iter=iter+1;
            if iter>=max_tries
                break
            end
            
            s=ss(:,iter+1);
            shape_center_global=[s(8); s(9);s(10)];
            [add,shape_top_left_index_global]=query_new_shape_center(shape,...
                shape_center_global, image, overlap_func, shape_count);
            if add==0
                continue;
            end
            image = place_image_3D(image, shape, shape_top_left_index_global, combine_func);
            shape_count=shape_count+1;
            %queried_shape=queried_shape+1
            break;
        end
        continue;
    end
    image = place_image_3D(image, shape, shape_top_left, combine_func);
    shape_count=shape_count+1;
    
    %     if mod(shape_count,30)==0
    %     image_store(store,:,:)=image;
    %     store=store+1;
    %     end
    
end
