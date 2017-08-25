%% Metropolis algorithm's parameters
clear
clc
num_samples=100; % Required number of samples
burn_in=1; % Ignore first few samples
dimensions=17; % Number of parameters
x_sampled=zeros(dimensions,num_samples+burn_in);
descriptors_differences=zeros(num_samples+burn_in,1);
acceptance_ratios=zeros(num_samples+burn_in,1);
total_accepts=0;
model_runs_per_sample=1;

%% Initialising the model parameters influencing the shape, number of 
% shapes and the minimum overlap 

num_shapes=300; % 350,286 400 286
initial_shapes=27; % 55,65 70 65
min_overlap=40000; % 2040, 3000 2450
a_mean=25;
a_var=5;
b_mean=25;
b_var=5;
c_mean=25;
c_var=5;
exponent_min=1;
exponent_max=5;
yaw_mean=0;
yaw_var=pi/2;
pitch_mean=0;
pitch_var=pi/2;
roll_mean=0;
roll_var=pi/2;

x=[num_shapes;initial_shapes;min_overlap;a_mean;a_var;b_mean;...
    b_var;c_mean;c_var;exponent_min;exponent_max;yaw_mean;yaw_var;...
    pitch_mean;pitch_var;roll_mean;roll_var]; % Initial parameter vector

%% Initialising other model parameters
[model_params,cutoff_func,combine_func,overlap_func]=...
    initialise_image_creation_model_3D('num_shapes',x(1),...
    'initial_shapes',x(2),'min_overlap',x(3),'a_dist',[x(4);x(5)],'b_dist',...
    [x(6);x(7)],'c_dist',[x(8);x(9)],'min_max_power',[x(10);x(11)],'yaw_dist',...
    [x(12);x(13)],'pitch_dist',[x(14);x(15)],'roll_dist',[x(16);x(17)]);

%% Setting prior distributions
prior_distributions=SimParamSet();
prior_distributions.add(SimParameter('prior_dist_num_shapes',UniformDistribution(0,2000000000)));
prior_distributions.add(SimParameter('prior_dist_initial_shapes',UniformDistribution(0,2000000000)));
prior_distributions.add(SimParameter('prior_dist_min_overlap',UniformDistribution(0,2000000000)));
prior_distributions.add(SimParameter('prior_dist_a_mean',UniformDistribution(0,2000000000)));
prior_distributions.add(SimParameter('prior_dist_a_var',UniformDistribution(0,2000000000)));
prior_distributions.add(SimParameter('prior_dist_b_mean',UniformDistribution(0,2000000000)));
prior_distributions.add(SimParameter('prior_dist_b_var',UniformDistribution(0,2000000000)));
prior_distributions.add(SimParameter('prior_dist_c_mean',UniformDistribution(0,2000000000)));
prior_distributions.add(SimParameter('prior_dist_c_var',UniformDistribution(0,2000000000)));
prior_distributions.add(SimParameter('prior_dist_exponent_min',UniformDistribution(0,2000000000)));
prior_distributions.add(SimParameter('prior_dist_exponent_max',UniformDistribution(0,2000000000)));
prior_distributions.add(SimParameter('prior_dist_yaw_mean',UniformDistribution(0,2000000000)));
prior_distributions.add(SimParameter('prior_dist_yaw_var',UniformDistribution(0,2000000000)));
prior_distributions.add(SimParameter('prior_dist_pitch_mean',UniformDistribution(0,2000000000)));
prior_distributions.add(SimParameter('prior_dist_pitch_var',UniformDistribution(0,2000000000)));
prior_distributions.add(SimParameter('prior_dist_roll_mean',UniformDistribution(0,2000000000)));
prior_distributions.add(SimParameter('prior_dist_roll_var',UniformDistribution(0,2000000000)));

%% Setting proposal distributions
proposal_distributions=SimParamSet();
proposal_distributions.add(SimParameter('proposal_dist_num_shapes',UniformDistribution(-40,40)));
proposal_distributions.add(SimParameter('proposal_dist_initial_shapes',UniformDistribution(-4,4)));
proposal_distributions.add(SimParameter('proposal_dist_min_overlap',UniformDistribution(-5000,5000)));
proposal_distributions.add(SimParameter('proposal_dist_a_mean',UniformDistribution(-2,2)));
proposal_distributions.add(SimParameter('proposal_dist_a_var',UniformDistribution(-1,1)));
proposal_distributions.add(SimParameter('proposal_dist_b_mean',UniformDistribution(-2,2)));
proposal_distributions.add(SimParameter('proposal_dist_b_var',UniformDistribution(-1,1)));
proposal_distributions.add(SimParameter('proposal_dist_c_mean',UniformDistribution(-2,2)));
proposal_distributions.add(SimParameter('proposal_dist_c_var',UniformDistribution(-1,1)));
proposal_distributions.add(SimParameter('proposal_dist_exponent_min',UniformDistribution(-1,1)));
proposal_distributions.add(SimParameter('proposal_dist_exponent_max',UniformDistribution(-1,1)));
proposal_distributions.add(SimParameter('proposal_dist_yaw_mean',UniformDistribution(0,0)));
proposal_distributions.add(SimParameter('proposal_dist_yaw_var',UniformDistribution(-pi/20,pi/20)));
proposal_distributions.add(SimParameter('proposal_dist_pitch_mean',UniformDistribution(0,0)));
proposal_distributions.add(SimParameter('proposal_dist_pitch_var',UniformDistribution(-pi/20,pi/20)));
proposal_distributions.add(SimParameter('proposal_dist_roll_mean',UniformDistribution(0,0)));
proposal_distributions.add(SimParameter('proposal_dist_roll_var',UniformDistribution(-pi/20,pi/20)));

%% Setting certain parameters to be constants and thereby altering their
% prior and proposal distributions to be constants 
prior_distributions.set_fixed('prior_dist_a_mean',a_mean);
prior_distributions.set_fixed('prior_dist_a_var',a_var);
prior_distributions.set_fixed('prior_dist_b_mean',b_mean);
prior_distributions.set_fixed('prior_dist_b_var',b_var);
prior_distributions.set_fixed('prior_dist_c_mean',c_mean);
prior_distributions.set_fixed('prior_dist_c_var',c_var);
prior_distributions.set_fixed('prior_dist_exponent_min',exponent_min);
prior_distributions.set_fixed('prior_dist_exponent_max',exponent_max);
prior_distributions.set_fixed('prior_dist_yaw_mean',yaw_mean);
prior_distributions.set_fixed('prior_dist_yaw_var',yaw_var);
prior_distributions.set_fixed('prior_dist_pitch_mean',pitch_mean);
prior_distributions.set_fixed('prior_dist_pitch_var',pitch_var);
prior_distributions.set_fixed('prior_dist_roll_mean',roll_mean);
prior_distributions.set_fixed('prior_dist_roll_var',roll_var);

proposal_distributions.set_fixed('proposal_dist_a_mean',0);
proposal_distributions.set_fixed('proposal_dist_a_var',0);
proposal_distributions.set_fixed('proposal_dist_b_mean',0);
proposal_distributions.set_fixed('proposal_dist_b_var',0);
proposal_distributions.set_fixed('proposal_dist_c_mean',0);
proposal_distributions.set_fixed('proposal_dist_c_var',0);
proposal_distributions.set_fixed('proposal_dist_exponent_min',0);
proposal_distributions.set_fixed('proposal_dist_exponent_max',0);
proposal_distributions.set_fixed('proposal_dist_yaw_mean',0);
proposal_distributions.set_fixed('proposal_dist_yaw_var',0);
proposal_distributions.set_fixed('proposal_dist_pitch_mean',0);
proposal_distributions.set_fixed('proposal_dist_pitch_var',0);
proposal_distributions.set_fixed('proposal_dist_roll_mean',0);
proposal_distributions.set_fixed('proposal_dist_roll_var',0);

%% Setting the error distribution
% The standard deviation of the error is set such that descriptors_difference
% going from 5.0 to 5.1 will be accepted only with a probability of 0.1
% error_distribution.pdf(50)=very small but not zero;
% error_distribution.pdf(1.5)=0.16;
error_distribution=SimParameter('error_distribution',NormalDistribution(0,3));


%% Cost func (assumed proportional to target density) parameters
cost_func=@(a,b)least_square_cost(a, b, weight_vector);
%FileName   = 'average_descriptors_for_image_sets.mat';
FileName   = 'descriptors_top_left.mat';
upUpFolder = fileparts(pwd);
%FolderName = fullfile(upUpFolder,
%'Average_desrciptors_for_100_selected_porous_media_2d_slices');
FolderName = fullfile(upUpFolder, 'Descriptors_for_these_samples');
File       = fullfile(FolderName, FileName);load(File);
% base_descriptors=average_descriptors_for_image_sets(6,2).values;
base_descriptors=descriptors_top_left;
weight_vector=ones(size(base_descriptors,1),1);
%weight_vector(size(base_descriptors,1),1)=2;


% Initial computation for first step
[descriptors_old] = create_image_and_compute_descriptors_3D(model_params,cutoff_func,combine_func,overlap_func,model_runs_per_sample);
descriptors_difference_old= least_square_cost(descriptors_old,base_descriptors,weight_vector);
prior_density_old=prior_distributions.pdf(x);

%% Metropolis algorithm with a componentwise update
tic
for i = 1:num_samples+burn_in
    
    i
    current_diff=descriptors_difference_old
    
    %% Computing new proposal

    x_new=x;
    
    x_new=x_new + proposal_distributions.sample(1);
    
    %% Computing prior densities
    prior_density_new=prior_distributions.pdf(x_new);
    prior_densities_ratio=prior_density_new/prior_density_old
    
    %% Creating image and computing likelihood
    
    [model_params,cutoff_func,combine_func,overlap_func]=initialise_image_creation_model_3D('num_shapes',x_new(1),'initial_shapes',x_new(2),'min_overlap',x_new(3),'a_dist',[x_new(4);x_new(5)],'b_dist',...
    [x_new(6);x_new(7)],'c_dist',[x_new(8);x_new(9)],'min_max_power',[x_new(10);x_new(11)],'yaw_dist',...
    [x_new(12);x_new(13)],'pitch_dist',[x_new(14);x_new(15)],'roll_dist',[x_new(16);x_new(17)]);
    [descriptors_new] = create_image_and_compute_descriptors_3D(model_params,cutoff_func,combine_func,overlap_func,model_runs_per_sample);
    descriptors_difference_new= least_square_cost(descriptors_new,base_descriptors,weight_vector);
    
    %% Computing acceptance ratio and checking for update
    likelihood_ratio=error_distribution.pdf(descriptors_difference_new)/error_distribution.pdf(descriptors_difference_old);
    acceptance_ratio= likelihood_ratio * prior_densities_ratio
    alpha=min(1,acceptance_ratio);
    
    u=rand
    
    if u < alpha
        total_accepts=total_accepts+1;
        disp('x changing');
        x=x_new;
        descriptors_difference_old=descriptors_difference_new;
    end
    
    prior_density_old=prior_density_new;
    
    x_sampled(:,i)=x;
    descriptors_differences(i,1)=descriptors_difference_old;
    acceptance_ratios(i,1)=acceptance_ratio;
    
end

toc
x_samples_after_burn_in=x_sampled(:,burn_in+1:end);
percentage_accepts=total_accepts/num_samples;


