image_1=~(image>0.5);
x=linspace(1,3,300);
y=linspace(1,3,300);
z=linspace(1,3,300);
CONVERT_voxels_to_stl('print_out.stl',image_1,x,y,z,'ascii'); 
