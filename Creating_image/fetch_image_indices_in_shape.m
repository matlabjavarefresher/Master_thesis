function [I_R_SH_REQ, I_C_SH_REQ] = fetch_image_indices_in_shape (imag,loc_shape,IC1R1_SH)

[I_R_SH_LOG,I_C_SH_LOG]=fetch_shape_indices_in_image(imag,loc_shape,IC1R1_SH);

I_C_SH_REQ = IC1R1_SH(1) + find(I_C_SH_LOG) -1;
I_R_SH_REQ = IC1R1_SH(2) + find(I_R_SH_LOG) -1;

end

