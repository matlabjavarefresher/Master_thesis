function unittest_lineal_path_calc()

% UNITTEST_LINEAL_PATH_CALC to test the LINEAL_PATH_CALC function.
%
% Example 1: (<a href="matlab:run_example unittest_lineal_path_calc  1">run</a>)
% % Calculating lineal_path_calc function for a square matrix 
% A = [1     1     1     1     1     0     0     1     0     0;
%      0     0     1     0     1     1     1     0     1     1;
%      1     0     1     0     0     1     1     1     1     0;
%      1     0     0     1     0     0     0     1     1     1;
%      1     1     1     0     0     1     1     0     1     1;
%      1     1     0     0     1     0     1     0     1     0;
%      0     0     1     0     0     0     0     1     0     1;
%      1     0     1     1     0     1     0     1     1     1;
%      0     1     0     0     0     1     0     1     1     1;
%      1     1     1     0     1     0     1     1     0     0]
%      
%  
% [l_p]=lineal_path_calc(A);
% disp(A);disp(l_p);
%
% See also LINEAL_PATH_CALC, MUNIT_RUN_TESTSUITE

%   <author>Prem Ratan M
%   <T.U.Braunschweig>
% munit_set_function( 'lineal_path_calc' );


%% Testing the calculation of lineal path for a 10X10 matrix

A = [1     1     1     1     1     0     0     1     0     0;
     0     0     1     0     1     1     1     0     1     1;
     1     0     1     0     0     1     1     1     1     0;
     1     0     0     1     0     0     0     1     1     1;
     1     1     1     0     0     1     1     0     1     1;
     1     1     0     0     1     0     1     0     1     0;
     0     0     1     0     0     0     0     1     0     1;
     1     0     1     1     0     1     0     1     1     1;
     0     1     0     0     0     1     0     1     1     1;
     1     1     1     0     1     0     1     1     0     0];
  
 
l_p_x_test=auto_corr(A);
l_p_y_test=auto_corr(A');

l_p_x_actual=[25/100;11/100;3/100;1/100;zeros(6,1)];
l_p_y_actual=[25/100;9/100;4/100;1/100;zeros(6,1)];
  

err_1=abs(l_p_x_test-l_p_x_actual);
err_2=abs(l_p_y_test-l_p_y_actual);

assert(isequal(err_1<(1e-10*ones(size(A,2),1)),ones(size(A,2),1)),'Fail in lineal_path_calc for square matrix in column direction');
assert(isequal(err_2<(1e-10*ones(size(A,1),1)),ones(size(A,1),1)),'Fail in lineal_path_calc for square matrix in row direction');


%% Testing the calculation of auto_corr for a rectangular 3X4 matrix
B=   [1     1     1     0;
     1     1     0     0;
     0     0     0     1];
 
l_p_xr_test=auto_corr(B);
l_p_yr_test=auto_corr(B');

l_p_xr_actual=[3/12;1/12;zeros(2,1)];
l_p_yr_actual=[2/12;zeros(2,1)];
  

err_1r=abs(l_p_xr_test-l_p_xr_actual);
err_2r=abs(l_p_yr_test-l_p_yr_actual);

assert(isequal(err_1r<(1e-10*ones(size(B,2),1)),ones(size(B,2),1)),'Fail in lineal_path_calc for rectangular matrix in column direction');
assert(isequal(err_2r<(1e-10*ones(size(B,1),1)),ones(size(B,1),1)),'Fail in lineal_path_calc for rectangular matrix in row direction'); 


end


