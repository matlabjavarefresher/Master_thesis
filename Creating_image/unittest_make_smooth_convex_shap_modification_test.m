function unittest_make_smooth_convex_shap_modification_test()

% MAKE_SMOOTH_CONVEX_SHAP_MODIFICATION_TEST to test the
% MAKE_SMOOTH_CONVEX_SHAP_MODIFICATION_TEST function.
%
% See also MAKE_SMOOTH_CONVEX_SHAP_MODIFICATION_TEST and MUNIT_RUN_TESTSUITE

%   <author>Prem Ratan M
%   <T.U.Braunschweig>
% munit_set_function('compute_mink_2d');

[shap]=make_smooth_convex_shap_modification_test([1,1],3.05,3.31,[15.1,15.3],2,0);
x_axis=max(sum(shap,2));
y_axis=max(sum(shap,1));

err_1=x_axis-6;
err_2=y_axis-7;

assert(isequal(err_1,0),'Fail in make_smooth_convex_shap_modification_test while checking whether the generated shape has the expected axis length in x direction');
assert(isequal(err_2,0),'Fail in make_smooth_convex_shap_modification_test while checking whether the generated shape has the expected axis length in y direction');

% Checking if rotation is working fine

[shap]=make_smooth_convex_shap_modification_test([1,1],3.05,3.31,[15.1,15.3],2,90);
x_axis_2=max(sum(shap,2));
y_axis_2=max(sum(shap,1));

err_3=x_axis_2-7;
err_4=y_axis_2-6;

assert(isequal(err_3,0),'Fail in make_smooth_convex_shap_modification_test while checking whether the generated shape has the expected axis length in x direction after shape rotation');
assert(isequal(err_4,0),'Fail in make_smooth_convex_shap_modification_test while checking whether the generated shape has the expected axis length in y direction after shape rotation');



% [shap]=make_smooth_convex_shap_modification_test([1,1],3.5,4.3,[-15.5,27.7],2,0);
% x_axis_3=max(sum(shap,2))
% y_axis_3=max(sum(shap,1))
% 
% err_1=x_axis_3-6;
% err_2=y_axis-9;

%assert(isequal(err_1,0),'Fail in make_smooth_convex_shap_modification_test while checking whether the generated shape has the expected axis length in x direction');
%assert(isequal(err_2,0),'Fail in make_smooth_convex_shap_modification_test while checking whether the generated shape has the expected axis length in y direction');


end

