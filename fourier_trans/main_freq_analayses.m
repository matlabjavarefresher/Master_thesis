% Frequency analysis of eigenmotions
clear variables
% Load vectors Alpha, Time, V_TAS
%load('corcoef_conve_avg_x_uniq_COL1330columns_new_mean_subtract.mat'); 
load('corcoef_conve_8_avg_x_uniq_row1390rows_new_mean_subtract.mat');
%Alpha = alpha;
%y_corcoef=mea(7,:);
x_corcoef=me(7,:);

% sampling_period = 0.01;
sampling_period = 1;% 1 pixel distance b/w one distance and the other

discard_samples = 0;
% frequency_resolution = 0.01;
%frequency_resolution_y = 1/1639;
frequency_resolution_x= 1/1597;


%frequency_analyses(V_TAS, 0, sampling_period, 0.01);
%frequency_analyses(Alpha, 0, sampling_period, 0.01);
%frequency_analyses(y_corcoef, 0, sampling_period, frequency_resolution_y);
frequency_analyses(x_corcoef, 0, sampling_period, frequency_resolution_x);
