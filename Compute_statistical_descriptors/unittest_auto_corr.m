function unittest_auto_corr()

% UNITTEST_AUTO_CORR to test the AUTO_CORR function.
%
% Example 1: (<a href="matlab:run_example unittest_auto_corr  1">run</a>)
% % Calculating auto_corr function for a square matrix 
% A = [1     0     1     0;
%      0     0     1     0;
%      0     1     1     0;
%      1     1     0     0]
%      
%  
% [a_cor]=auto_corr(A);
% disp(A);disp(a_corr);
%
% See also AUTO_CORR, MUNIT_RUN_TESTSUITE

%   <author>Prem Ratan M
%   <T.U.Braunschweig>
% munit_set_function( 'auto_corr' );


%% Testing the calculation of auto correlation for a 4X4 matrix

A = [1     0     1     0;
     0     0     1     0;
     0     1     1     0;
     1     1     0     1];
  
 
a_c_x_test=auto_corr(A);
a_c_y_test=auto_corr(A');

a_c_x_actual=[1/4,-1/8,0,1/8];
a_c_y_actual=[1/4,1/24,-1/8,-1/8];
                      
err_1=abs(a_c_x_test-a_c_x_actual);
err_2=abs(a_c_y_test-a_c_y_actual);

assert(isequal(err_1<(1e-10*ones(1,size(A,2))),ones(1,size(A,2))),'Fail in auto_corr for square matrix in column(2) direction');
assert(isequal(err_2<(1e-10*ones(1,size(A,1))),ones(1,size(A,1))),'Fail in auto_corr for square matrix in row(1) direction');


%% Testing the calculation of auto_corr for a rectangular 3X4 matrix
B=   [1     1     1     0;
     1     1     0     0;
     0     0     0     1];
 
 
a_c_xr_test=auto_corr(B);
a_c_yr_test=auto_corr(B');

a_c_xr_actual=[1/4,1/12,-1/12,-1/4];
          
a_c_yr_actual=[1/3,0,-1/3];
  

err_1r=abs(a_c_xr_test-a_c_xr_actual);
err_2r=abs(a_c_yr_test-a_c_yr_actual);

assert(isequal(err_1r<(1e-10*ones(1,size(B,2))),ones(1,size(B,2))),'Fail in auto_corr for rectangular matrix in column direction');
assert(isequal(err_2r<(1e-10*ones(1,size(B,1))),ones(1,size(B,1))),'Fail in auto_corr for rectangular matrix in row direction'); 


end


