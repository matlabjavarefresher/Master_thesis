function unittest_compute_mink_reconstruct()

% UNITTEST_COMPUTE_MINK_RECONSTRUCT to test the 
% COMPUTE_MINK_RECONSTRUCT function.
%
% Example 1: (<a href="matlab:run_example unittest_compute_mink_reconstruct
% 1">run</a>) Calculating Minkowsky functionals for the following 
% image/matrix img (a digital representation of a triangle as in Michielsen
% et al., 2001, Integral-geometry, page 491.)
%  img=[zeros(2,10);0 0 0 1 1 zeros(1,5); 0 0 ones(1,4) zeros(1,4);...
%  0 ones(1,6) zeros(1,3);0 ones(1,6) zeros(1,3); 0 0 ones(1,6)...
%  0 0;zeros(1,4) ones(1,5) 0; zeros(1,7) 1 1 0; zeros(1,10)];
%        
%      
%  
% [peri,ar_ea,ec,cpa] = compute_mink_reconstruct(img);
% disp('Corrected perimeter and area are as follows');disp(cpa);
% disp('Euler characteristic is as follows');disp(ec); 
%
% See also COMPUTE_MINK_RECONSTRUCT, MUNIT_RUN_TESTSUITE

%   <author>Prem Ratan M
%   <T.U.Braunschweig>
% munit_set_function('compute_mink_reconstruct');


%% Testing the calculation of the Minkowsky functionals of a digitised 
% triangle as in the Integral-geometry paper, Michielsen et al. page 491

 img=[zeros(2,10);0 0 0 1 1 zeros(1,5); 0 0 ones(1,4) zeros(1,4);...
 0 ones(1,6) zeros(1,3);0 ones(1,6) zeros(1,3); 0 0 ones(1,6)...
 0 0;zeros(1,4) ones(1,5) 0; zeros(1,7) 1 1 0; zeros(1,10)];
  
[peri,ar_ea,ec,cpa] = compute_mink_reconstruct(img); 

rel_err_1=abs((cpa(1)-27.36)/27.36);                      
rel_err_2=abs((cpa(2)-22)/22);



assert(isequal(rel_err_1<.001,1),'Fail in compute_mink_reconstruct while computing perimeter of Michielsen triangle');
assert(isequal(rel_err_2<.001,1),'Fail in compute_mink_reconstruct while computing area of Michielsen triangle');

%% Testing the calculation of Mink. funcs for an image with elements on 
% the boundary so as to check whether the image boundary is neglected while
% computing the perimeter

img1=   [1     1     1     1;
     1     0    0     1;
     1     0    0     1;
     1     1     1     1];
 
[peri,ar_ea,ec,cpa1] = compute_mink_reconstruct(img1); 
 
rel_err_3=abs((cpa1(1)-6.83)/6.83);

assert(isequal(rel_err_3<.001,1),'Fail in compute_mink_reconstruct while checking whether the image boundary is excluded during the perimeter computation');


end

