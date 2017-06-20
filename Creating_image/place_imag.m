function imag = place_imag(imag, loc_shape, IC1R1_SH,comb_func)
[I_R_SH_REQ, I_C_SH_REQ] = fetch_image_indices_in_shape (imag,loc_shape,IC1R1_SH);
[I_R_SH_LOG,I_C_SH_LOG]=fetch_shape_indices_in_image(imag,loc_shape,IC1R1_SH);
imag(I_R_SH_REQ,I_C_SH_REQ) = comb_func(imag(I_R_SH_REQ,I_C_SH_REQ), loc_shape(I_R_SH_LOG,I_C_SH_LOG));
end

