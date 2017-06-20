function [I_R_SH_LOG,I_C_SH_LOG]=fetch_shape_indices_in_image(imag,loc_shape,IC1R1_SH)

IC2R2_SH=IC1R1_SH+[size(loc_shape,2);size(loc_shape,1)]-1;
I_C_SH=IC1R1_SH(1):IC2R2_SH(1);
I_R_SH=IC1R1_SH(2):IC2R2_SH(2);

I_C_SH_LOG = I_C_SH>=1 & I_C_SH<=size(imag,2);
I_R_SH_LOG = I_R_SH>=1 & I_R_SH<=size(imag,1);
end


