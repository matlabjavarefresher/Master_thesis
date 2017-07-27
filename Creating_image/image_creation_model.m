classdef image_creation_model < BaseModel
    
    properties
        image_top_left = [0; 0];
        image_bottom_right = [1597;1639];
        res=1;
        image_size = ceil((image_bottom_right-image_top_left)*res);
        image_in = zeros(image_size')';
        %shape_type = 'smooth_convex';  % 'smooth_convex', Other options if and when required
        num_shapes = 1200;% Number of shapes required - 1200 default
        max_tries = 10*num_shapes; % Max number of tries to place ns shapes on the image
        % cutoff_func= @cutoff_sharp;
        cutoff_func = @(x,res)cutoff_smooth(x, res, 1);
        %combinator_func= @combine_sum1;
        combine_func = @combine_sum2;
        % A below refers to area of overlap in terms of number of pixels
        initial_shapes=80;
        min_overlap=1000;
        max_overlap=10000;
        A_no_overlap = [initial_shapes,0,0];
        A_always_allow = [initial_shapes,0,inf];
        A_small_overlap = [initial_shapes,min_overlap,max_overlap];%for a=30,10;b=20,10;max_ol=3000;min_ol = 200 to 600 for pow=1 to 5 and min_ol=200 (100 for cutoff_sharp) for pow = 1 to 1.5
        A_medium_overlap = 3000;
        A_large_overlap = 10000;
        
        A_overlap_limit = A_small_overlap;
        overlap_func = @(image1,image2,shape_count) allow_absolute_overlap(image1, image2,shape_count, res, A_overlap_limit);
        
    end
    
    methods
        function model = Update_stress_model(varargin)
            options = varargin2options(varargin);
            [no_ts, options] = get_option(options, 'no_ts', model.no_ts);
            [eps, options] = get_option(options, 'eps', model.eps);
            check_unsupported_options(options, mfilename);
            
            model.no_ts = no_ts;
            model.eps = eps;
        end
        
        function n=response_dim(model)
            n =10000;
        end
        
        function u=compute_response(model, q)
            E = q(1,:);
            H = q(2,:);
            K = q(3,:);
            sig_y  = q(4,:);
            no_ts = model.no_ts;
            eps = model.eps;
            %[sig_updt] = update_stress_iso(E, H, sig_y, no_ts, eps);
            [sig_updt] = update_stress_iso_kin(E, H, K, sig_y, no_ts, eps);
            u = sig_updt;
            
        end
        
        function y = compute_measurements(model, u)
            %req_indices=[119,592,852,2285,2488,4697,5082,6495,6636,8713,9034];%Original 11 points
            %req_indices=[119,852,2285,4697,6636,8713];%Original 6 points
            %req_indices=[119,2285,8713];%Original 3 points
            req_indices=[119,1036,1245,2406,2488,4697,4881,6409,6495,8597,8717];  %different 11 poins
            % req_indices=[119,592,852,2285,2371,2446,2488,4697,4979,5220,5592,6495,6636,8713];
            %%%removed indices
            %%%727-3rd,1036-5th,1245-6th,1828-7th,2239 -8th,2406-11th,4770,5082,5450,5391,5538,4881-16th,5402 -2oth,
            %%% 5414 -25th,9034 - last point
            y = u(req_indices,1);%The number of u's that you pass back must be
            % equal to the length of y_m
            %y = u(5:10:100,1);
            
            
        end
    end
end

