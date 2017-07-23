function [descriptors] = compute_descriptors(img)
    
    descriptors=zeros(7,max(size(img)));
    rows=size(img,1);
    cols=size(img,2);
    descriptors(1,1:cols)=auto_corr(img);
    descriptors(2,1:rows)=auto_corr(img');
    descriptors(3,1:cols) = chord_length_func_calc(img);
    descriptors(4,1:rows) = chord_length_func_calc(img');
    descriptors(5,1:cols) = lineal_path_calc(img);
    descriptors(6,1:rows) = lineal_path_calc(img');
    descriptors(7,1:3)=[imPerimeter(img),imArea(img), imEuler2d(img)];
    
end

