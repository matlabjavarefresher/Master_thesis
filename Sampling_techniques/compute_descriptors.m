function [descriptors] = compute_descriptors(img)

dimensions=length(size(img));

switch dimensions
    case 2
        descriptors=zeros(10,max(size(img)));
        rows=size(img,1);
        cols=size(img,2);
        descriptors(1,1:cols)=auto_corr(img);
        descriptors(2,1:rows)=auto_corr(img');
        descriptors(3,1:cols) = chord_length_func_calc(img);
        descriptors(4,1:rows) = chord_length_func_calc(img');
        descriptors(5,1:cols) = lineal_path_calc(img);
        descriptors(6,1:rows) = lineal_path_calc(img');
        descriptors(7,1)=imPerimeter(img);
        descriptors(8,1)=imArea(img);
        descriptors(9,1)=imEuler2d(img);
        descriptors(10,1)=descriptors(7,1)/descriptors(8,1);
        
    case 3
        rows=size(img,1);
        cols=size(img,2);
        slices=size(img,3);
        descriptors=zeros(11,max([rows,cols,slices]));
        temp_1=permute(img,[1 3 2]);
        image_containing_all_rows = reshape(temp_1,rows*slices,cols,1);
        temp_2=permute(img,[2 3 1]);
        image_containing_all_columns=reshape(temp_2,cols*slices,rows,1);
        image_containing_all_beams=reshape(img,rows*cols,slices,1);
        descriptors(1,1:cols)=auto_corr(image_containing_all_rows);
        descriptors(1,251:cols)=zeros(1,50);
        descriptors(2,1:rows)=auto_corr(image_containing_all_columns);
        descriptors(2,251:rows)=zeros(1,50);
        descriptors(3,1:slices)=auto_corr(image_containing_all_beams);
        descriptors(3,251:slices)=zeros(1,50);
        descriptors(4,1:cols)=chord_length_func_calc(image_containing_all_rows);
        descriptors(5,1:rows)=chord_length_func_calc(image_containing_all_columns);
        descriptors(6,1:cols)=chord_length_func_calc(image_containing_all_beams);
        descriptors(7,1)=imVolume(img);
        descriptors(8,1)=imSurface(img);
        descriptors(9,1)=imMeanBreadth(img);
        descriptors(10,1)=imEuler3d(img);
        descriptors(11,1)=descriptors(7,1)/descriptors(8,1);
        
end

end

