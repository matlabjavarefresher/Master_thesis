%% Fetch inputs 


clc;
clear all;
tic
[in_img,ref_img,req_desc] = set_inp_sim_annel();

%% Compute required descriptors on reference image

[desc] = compute_req_desc(ref_img,req_desc);

%% Perform simulated annealing

ObjFunc = @(obj_img) cost_func(obj_img,desc,req_desc);

swapper_anneal = @(sw_img) swap_pixel_anneal(sw_img);

s = struct('Verbosity',2,'Generator',swapper_anneal,'CoolSched',@(T) (.99*T),'MaxConsRej',30000,'MaxSuccess',20,'InitTemp',500);

[minimum,fval] = anneal(ObjFunc, in_img,[s]);

tim=toc
%% SA using Built-in Matlab function
%swapper = @(optimValues,dont_use) swap_pixel(optimValues,dont_use);
%options = optimoptions(@simulannealbnd,'DataType','custom', ...
% 'AnnealingFcn',swapper,'TemperatureFcn',@temperaturefast);

%[out_img,fval,exitFlag,output] = simulannealbnd(ObjFunc,in_img,[],[],options);

%% Plotting

subplot(3,1,1);
imshow(ref_img);
subplot(3,1,2);
imshow(in_img);
subplot(3,1,3);
imshow(minimum);