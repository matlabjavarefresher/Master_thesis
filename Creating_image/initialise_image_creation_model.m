function [p,cutoff_func,combine_func,overlap_func]=initialise_image_creation_model(varargin)

%model_params,cutoff_func,combine_func,overlap_func
p = inputParser;

%% Setting default values for all parameters 
def_image_top_left = [0; 0];
image_bottom_right=[1597;1639];
resolution=1;
num_shapes=1200;
initial_shapes=80;
min_overlap=1000;
max_overlap=10000;
a_dist=[45,20];
b_dist=[35,10];
theta_dist=[0,pi/2];
min_max_power = [1,5];


%% Reading in specified optional parameters
addOptional(p,'image_top_left',def_image_top_left,@isnumeric)
addOptional(p,'image_bottom_right',image_bottom_right,@isnumeric);
addOptional(p,'resolution',resolution,@isnumeric);
addOptional(p,'num_shapes',num_shapes,@isnumeric);
addOptional(p,'initial_shapes',initial_shapes,@isnumeric);
addOptional(p,'min_overlap',min_overlap,@isnumeric);
addOptional(p,'max_overlap',max_overlap,@isnumeric);
addOptional(p,'a_dist',a_dist,@isnumeric);
addOptional(p,'b_dist',b_dist,@isnumeric);
addOptional(p,'theta_dist',theta_dist,@isnumeric);
addOptional(p,'min_max_power',min_max_power,@isnumeric);



parse(p,varargin{:}); % To accept variable inputs so that the dependent
                      % variables declared below can be updated based on
                      % the values read-in



% Setting dependent parameters
addParameter(p,'image_size',(p.Results.image_bottom_right-p.Results.image_top_left)*p.Results.resolution);
addParameter(p,'image_in', zeros(((p.Results.image_bottom_right-p.Results.image_top_left)*p.Results.resolution)')');
addParameter(p,'max_tries', round(10*p.Results.num_shapes));
addParameter(p,'power_dist', [(p.Results.min_max_power(1)+p.Results.min_max_power(2))/2, (p.Results.min_max_power(2)-p.Results.min_max_power(1))/2]);

parse(p,varargin{:}); % To update p, so that, before initialising the methods, the 
          % updated variables in p, which now also includes the dependent 
          % variables set above (absent in previous p update), could be 
          % used to initialise the methods  

% Creating shape specific properties and adding to p
S=SimParamSet();
S.add(SimParameter('a_dist',translate(BetaDistribution(2,2), p.Results.a_dist(1),p.Results.a_dist(2))));
S.add(SimParameter('b_dist',translate(BetaDistribution(2,2), p.Results.b_dist(1),p.Results.b_dist(2))));
S.add(SimParameter('theta_dist',translate(BetaDistribution(2,2),p.Results.theta_dist(1),p.Results.theta_dist(2))));
S.add(SimParameter('power_dist',translate(BetaDistribution(2,2), p.Results.power_dist(1), p.Results.power_dist(2))));
% S.add(SimParameter('pow_dist',translate(ExponentialDistribution(0.5), min_pow)));
S.add(SimParameter('shape_cx_global',UniformDistribution(-0.2*(size(p.Results.image_in,2)/ p.Results.resolution),1.2*(size(p.Results.image_in,2)/p.Results.resolution))));
S.add(SimParameter('shape_cy_global',UniformDistribution(-0.2*(size(p.Results.image_in,1)/p.Results.resolution),1.2*(size(p.Results.image_in,1)/p.Results.resolution))));
addParameter(p,'shape_specific_properties', S);

parse(p,varargin{:}); % To update p to update shape specific properties

%% Initialising methods
% A_no_overlap = [model_params(8).value,0,0]; % Option 1 for specifying overlap limits
% A_always_allow = [model_params(8).value,0,inf]; % Option 2 for specifying overlap limits
A_constrained_overlap = [p.Results.initial_shapes,p.Results.min_overlap,p.Results.max_overlap];%for a=30,10;b=20,10;max_ol=3000;min_ol = 200 to 600 for pow=1 to 5 and min_ol=200 (100 for cutoff_sharp) for pow = 1 to 1.5
% cutoff_func= @cutoff_sharp;
cutoff_func = @(x,res)cutoff_smooth(x, p.Results.resolution, 1);
%combine_func= @combine_sum1;
combine_func = @combine_sum2;
overlap_func = @(image1,image2,shape_count) allow_absolute_overlap(image1, image2,shape_count, p.Results.resolution, A_constrained_overlap);


%% Old code - a bit inefficient 
% 
% % Initialising image (global) parameters
% model_params(1).name='image_top_left';
% model_params(1).value=[0; 0];
% model_params(2).name='image_bottom_right';
% model_params(2).value=[1597;1639];
% model_params(3).name='resolution';
% model_params(3).value=1;
% model_params(4).name='image_size';
% model_params(4).value=ceil((model_params(2).value-model_params(1).value)*model_params(3).value);
% model_params(5).name = 'image_in';
% model_params(5).value = zeros(model_params(4).value')';
% model_params(6).name='num_shapes';
% model_params(6).value=1200;
% model_params(7).name='max_tries';
% model_params(7).value=10* model_params(6).value;
% model_params(8).name='initial_shapes';
% model_params(8).value=80;
% model_params(9).name='min_overlap';
% model_params(9).value=1000;
% model_params(10).name='max_overlap';
% model_params(10).value=10000;
% model_params(11).name='a_dist';
% model_params(11).value=[60,30];
% model_params(12).name='b_dist';
% model_params(12).value=[40,20];
% model_params(13).name='theta_dist';
% model_params(13).value=[0,pi/2];
% min_power = 1; max_power = 5;
% model_params(14).name='power_dist';
% model_params(14).value=[(min_power+max_power)/2, (max_power-min_power)/2];
% 
% % Reading variable inputs
% nvarargs = length(varargin);
% 
% for k = 1:nvarargs
%     
%     s = inputname(k);
%     
%     switch s
%         
%         case 'image_top_left'
%             model_params(1).value=varargin{k+1};
%             
%         case 'image_bottom_right'
%             model_params(2).value=varargin{k+1};
%             
%         case 'resolution'
%             model_params(3).value=varargin{k+1};
%             
%         case 'image_size'
%             model_params(4).value=varargin{k+1};
%             
%         case 'image_in'
%             model_params(5).value=varargin{k+1};
%             
%         case 'num_shapes'
%             model_params(6).value=varargin{k+1};
%             
%         case 'max_tries'
%             model_params(7).value=varargin{k+1};
%             
%         case 'initial_shapes'
%             model_params(8).value=varargin{k+1};
%             
%         case 'min_overlap'
%             model_params(9).value=varargin{k+1};
%             
%         case 'max_overlap'
%             model_params(10).value=varargin{k+1};
%             
%         case 'a_dist'
%             model_params(11).value=varargin{k+1};
%             
%         case 'b_dist'
%             model_params(12).value=varargin{k+1};
%             
%         case 'theta_dist'
%             model_params(13).value=varargin{k+1};
%             
%         case 'power_dist'
%             model_params(14).value=varargin{k+1};
%             
%             
%     end
% end
% 
% % Initialising shape (local) parameters
% 
% S=SimParamSet();
% S.add(SimParameter('a_dist',translate(BetaDistribution(2,2), model_params(11).value(1), model_params(11).value(2))));
% S.add(SimParameter('b_dist',translate(BetaDistribution(2,2), model_params(12).value(1), model_params(12).value(2))));
% S.add(SimParameter('theta_dist',translate(BetaDistribution(2,2),model_params(13).value(1), model_params(13).value(2))));
% S.add(SimParameter('power_dist',translate(BetaDistribution(2,2), model_params(14).value(1), model_params(14).value(2))));
% % S.add(SimParameter('pow_dist',translate(ExponentialDistribution(0.5), min_pow)));
% S.add(SimParameter('shape_cx_global',UniformDistribution(-0.2*(size(model_params(5).value,2)/model_params(3).value),1.2*(size(model_params(5).value,2)/model_params(3).value))));
% S.add(SimParameter('shape_cy_global',UniformDistribution(-0.2*(size(model_params(5).value,1)/model_params(3).value),1.2*(size(model_params(5).value,1)/model_params(3).value))));
% model_params(15).name='shape_specific_properties';
% model_params(15).value=S;
% 
% 
% %%  Initialising methods
% % A_no_overlap = [model_params(8).value,0,0]; % Option 1 for specifying overlap limits
% % A_always_allow = [model_params(8).value,0,inf]; % Option 2 for specifying overlap limits
% A_constrained_overlap = [model_params(8).value,model_params(9).value,model_params(10).value];%for a=30,10;b=20,10;max_ol=3000;min_ol = 200 to 600 for pow=1 to 5 and min_ol=200 (100 for cutoff_sharp) for pow = 1 to 1.5
% % cutoff_func= @cutoff_sharp;
% cutoff_func = @(x,res)cutoff_smooth(x, model_params(3).value, 1);
% %combine_func= @combine_sum1;
% combine_func = @combine_sum2;
% overlap_func = @(image1,image2,shape_count) allow_absolute_overlap(image1, image2,shape_count, model_params(3).value, A_constrained_overlap);

end
