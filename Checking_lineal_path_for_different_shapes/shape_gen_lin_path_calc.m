clear;
clc;
%% Generating image with random shapes
shape_typ=1;%1 for circles 2 for squares
ovlp=1;%1 for non-overlap 2 for overlap

switch shape_typ
    
    case 1
        bg_siz=1000;%Background size
        no_circs=50;
        radi=sort(round(100*rand(no_circs,1)),'descend');
        cent_x=round(1000*rand(no_circs,1));
        cent_y=round(1000*rand(no_circs,1));
        
        [BW,bg]=shape_gen_circ(ovlp,bg_siz,no_circs,radi,cent_x,cent_y);
end

%% Lineal path function calcuation
%bg=randi([0 1], 6,6);
rand_or_uni=1;%1 for random sampling of rows and columns, 2 for unfiorm sampling

switch rand_or_uni
    
    case 1
        ran_rows=unique(round(1+(size(bg,1)-1)*rand(size(bg,1),1)));
        ran_cols=unique(round(1+(size(bg,2)-1)*rand(size(bg,2),1)));
        no_of_locs=3; %Number of locations to sample within each row and column
        beg_loc=unique(round(1+(size(bg,2)-1)*rand(no_of_locs,1)));
    case 2
        ran_rows=(1:size(bg,1))';
        ran_cols=(1:size(bg,2))';
        no_of_locs=1;
        beg_loc=1;
end

[lp_vals] = lin_path_calc( bg,rand_or_uni,ran_rows,ran_cols,no_of_locs,beg_loc);



