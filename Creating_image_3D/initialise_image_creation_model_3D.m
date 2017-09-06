function [p,cutoff_func,combine_func,overlap_func]=initialise_image_creation_model_3D(varargin)

%model_params,cutoff_func,combine_func,overlap_func
p = inputParser;

%% Setting default values for all parameters 
image_top_left = [0; 0; 0];
image_bottom_right=[300;300;300];
resolution=1;
num_shapes=10;
initial_shapes=2;
min_overlap=500;
max_overlap=inf;
a_dist=[25,15];% [30,20]
b_dist=[25,15];%[20,10]
c_dist=[25,15];
pitch_dist=[0,pi/2];
yaw_dist=[0,pi/2];
roll_dist=[0,pi/2];
%shift_scale_power = [1,7];% latest first [1,5], [1,7]  tried 1:10 - rectangular 
                      % shapes visible
exponent_parameter=0.1;

%% Reading in specified optional parameters
addOptional(p,'image_top_left',image_top_left,@isnumeric)
addOptional(p,'image_bottom_right',image_bottom_right,@isnumeric);
addOptional(p,'resolution',resolution,@isnumeric);
addOptional(p,'num_shapes',num_shapes,@isnumeric);
addOptional(p,'initial_shapes',initial_shapes,@isnumeric);
addOptional(p,'min_overlap',min_overlap,@isnumeric);
addOptional(p,'max_overlap',max_overlap,@isnumeric);
addOptional(p,'a_dist',a_dist,@isnumeric);
addOptional(p,'b_dist',b_dist,@isnumeric);
addOptional(p,'c_dist',c_dist,@isnumeric);
addOptional(p,'yaw_dist',yaw_dist,@isnumeric);
addOptional(p,'pitch_dist',pitch_dist,@isnumeric);
addOptional(p,'roll_dist',roll_dist,@isnumeric);
addOptional(p,'exponent_parameter',exponent_parameter,@isnumeric);



parse(p,varargin{:}); % To accept variable inputs so that the dependent
                      % variables declared below can be updated based on
                      % the values read-in 
                      
%% Setting dependent parameters
addParameter(p,'image_size',ceil((p.Results.image_bottom_right-p.Results.image_top_left)*p.Results.resolution));
columns_rows_slices=ceil((p.Results.image_bottom_right-p.Results.image_top_left)*p.Results.resolution);
addParameter(p,'image_in', zeros(columns_rows_slices(2),columns_rows_slices(1),columns_rows_slices(3)));
addParameter(p,'max_tries', round(100*p.Results.num_shapes));
% addParameter(p,'power_dist', [(p.Results.min_max_power(1)+p.Results.min_max_power(2))/2, (p.Results.min_max_power(2)-p.Results.min_max_power(1))/2]);
parse(p,varargin{:}); % To update p, so that, before initialising the methods, the 
          % updated variables in p, which now also includes the dependent 
          % variables set above (absent in previous p update), could be 
          % used to initialise the methods  

% Creating shape specific properties and adding to p
% Overhang extent is the extent in each direction to which the shapes are
% allowed to be placed outside the domain of the image. This overhang is
% allowed so that we get partially cutoff shapes at the boundary. This
% extent is computed by first computing the ratio of the shape size to
% the size of the image in each direction. This ratio is then multiplied by
% 1/4 to account for the fact that the shape size as calculated below
% represents the size of the shape only when the shape is rotated
% by 45 degrees w.r.t. each axis and at most other times, the shape would
% occupy a much smaller size

% shape_size_min is the shape size obtained by considering minimum 
% a, b and c dimensions
S=SimParamSet();
shape_size_min=sqrt(((2*(p.Results.a_dist(1)-p.Results.a_dist(2)))^2)+...
    ((2*(p.Results.b_dist(1)-p.Results.b_dist(2)))^2)+...
    ((2*(p.Results.c_dist(1)-p.Results.c_dist(2)))^2));
overhang_extent_x=(1/4)*shape_size_min/size(p.Results.image_in,2);
overhang_extent_y=(1/4)*shape_size_min/size(p.Results.image_in,1);
overhang_extent_z=(1/4)*shape_size_min/size(p.Results.image_in,3);
S.add(SimParameter('a_dist',translate(BetaDistribution(2,2), p.Results.a_dist(1),p.Results.a_dist(2))));
S.add(SimParameter('b_dist',translate(BetaDistribution(2,2), p.Results.b_dist(1),p.Results.b_dist(2))));
S.add(SimParameter('c_dist',translate(BetaDistribution(2,2), p.Results.c_dist(1),p.Results.c_dist(2))));
S.add(SimParameter('yaw_dist',translate(BetaDistribution(1,1),p.Results.yaw_dist(1),p.Results.yaw_dist(2))));
S.add(SimParameter('pitch_dist',translate(BetaDistribution(1,1),p.Results.pitch_dist(1),p.Results.pitch_dist(2))));
S.add(SimParameter('roll_dist',translate(BetaDistribution(1,1),p.Results.roll_dist(1),p.Results.roll_dist(2))));
%S.add(SimParameter('power_dist',translate(ExponentialDistribution(0.1), p.Results.power_dist(1), p.Results.power_dist(2))));
S.add(SimParameter('exponent_dist',ExponentialDistribution(exponent_parameter)));
S.add(SimParameter('shape_cx_global',UniformDistribution(-overhang_extent_x*(size(p.Results.image_in,2)/ p.Results.resolution),(1+overhang_extent_x)*(size(p.Results.image_in,2)/p.Results.resolution))));
S.add(SimParameter('shape_cy_global',UniformDistribution(-overhang_extent_y*(size(p.Results.image_in,1)/p.Results.resolution),(1+overhang_extent_y)*(size(p.Results.image_in,1)/p.Results.resolution))));
S.add(SimParameter('shape_cz_global',UniformDistribution(-overhang_extent_z*(size(p.Results.image_in,3)/p.Results.resolution),(1+overhang_extent_z)*(size(p.Results.image_in,3)/p.Results.resolution))));
addParameter(p,'shape_specific_properties', S);

parse(p,varargin{:}); % To update p to update shape specific properties

%% Initialising methods
% A_no_overlap = [model_params(8).value,0,0]; % Option 1 for specifying overlap limits
% A_always_allow = [model_params(8).value,0,inf]; % Option 2 for specifying overlap limits
A_constrained_overlap = [p.Results.initial_shapes,p.Results.min_overlap,p.Results.max_overlap];%for a=30,10;b=20,10;max_ol=3000;min_ol = 200 to 600 for pow=1 to 5 and min_ol=200 (100 for cutoff_sharp) for pow = 1 to 1.5
cutoff_func= @cutoff_sharp;
%cutoff_func = @(x,res)cutoff_smooth(x, p.Results.resolution, 1);
%combine_func= @combine_sum1;
combine_func = @combine_sum2;
overlap_func = @(image1,image2,shape_count) allow_absolute_overlap(image1, image2,shape_count, p.Results.resolution, A_constrained_overlap);

end
