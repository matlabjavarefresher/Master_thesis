image_1=~(image_binary);
x=linspace(1,3,300);
y=linspace(1,3,300);
z=linspace(1,3,300);
CONVERT_voxels_to_stl('try_17_samp1_cldwt3_mink1n2wt4_s2wt3_ecnmbwt2.stl',image_1,x,y,z,'ascii');

weight_vector=[3;3;3;3;3;3;4;4;1;2;1]; % 
