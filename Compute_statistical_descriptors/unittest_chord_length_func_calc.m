function unittest_chord_length_func_calc()    

% UNITTEST_CHORD_LENGTH_FUNC_CALC to test the CHORD_LENGTH_FUNC_CALC function.
%
% Example 1: (<a href="matlab:run_example unittest_chord_length_func_calc  1">run</a>)
% % Calculating chord length function for a square matrix 
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
% [c_l]=chord_length_func_calc(A);
% disp(A);disp(c_l);
%
% See also CHORD_LENGTH_FUNC_CALC, MUNIT_RUN_TESTSUITE

%   <author>Prem Ratan M
%   <T.U.Braunschweig>
% munit_set_function( 'chord_length_func_calc' );


%% Testing the calculation of chord length function for a 10X10 matrix

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
 
c_l_x_test=chord_length_func_calc(A);
c_l_y_test=chord_length_func_calc(A');

c_l_x_actual=[6/14;6/14;1/14;1/14;zeros(6,1)];
c_l_y_actual=[11/16;2/16;2/16;1/16;zeros(6,1)];
  

err_1=abs(c_l_x_test-c_l_x_actual);
err_2=abs(c_l_y_test-c_l_y_actual);

assert(isequal(err_1<(1e-10*ones(size(A,2),1)),ones(size(A,2),1)),'Fail in chord_length_func_calc for square matrix in column direction');
assert(isequal(err_2<(1e-10*ones(size(A,1),1)),ones(size(A,1),1)),'Fail in chord_length_func_calc for square matrix in row direction');


%% Testing the calculation of chord length func for a rectangular 3X4 matrix
B=   [1     1     1     0;
     1     1     0     0;
     0     0     0     1];
 
c_l_xr_test=chord_length_func_calc(B);
c_l_yr_test=chord_length_func_calc(B');

c_l_xr_actual=[1/2;1/2;zeros(2,1)];
c_l_yr_actual=[1;zeros(2,1)];
  

err_1r=abs(c_l_xr_test-c_l_xr_actual);
err_2r=abs(c_l_yr_test-c_l_yr_actual);

assert(isequal(err_1r<(1e-10*ones(size(B,2),1)),ones(size(B,2),1)),'Fail in chord_length_func_calc for rectangular matrix in column direction');
assert(isequal(err_2r<(1e-10*ones(size(B,1),1)),ones(size(B,1),1)),'Fail in chord_length_func_calc for rectangular matrix in row direction'); 


end

