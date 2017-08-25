function [chord_length_x] = chord_length_func_calc(img)
%tic
rows=size(img,1);
cols=size(img,2);
chord_lengths=zeros(cols,1);
img=[img,zeros(rows,1)];

for i=1:rows
    counter=0;
    for j=1:cols
        if img(i,j)==0
            if (counter>1)
                chord_lengths(counter-1)=chord_lengths(counter-1)+1;
                % if statement to avoid counting chords of 0 length
                % (countr=0) or single pixels (countr=1)
            end
            counter=0;
        else
            counter=counter+1;
        end
    end
end
chord_length_x=chord_lengths/sum(chord_lengths);
%toc
end


% % %%% Partially vectorised but consuming more time than above for loops
% % (average 0.95 seconds per run) find function takes max time, you may not
% % get much savings anyway due to model taking more time, around a minute
% % and the above for loops seem to be decently quick, so moving on.
% tic
% [rows, cols]=size(A);
% chord_lengths=zeros(rows,1);
%
% for i = 1:cols
%     indices = [ find(A(1:end-1,i) ~= A(2:end,i)) ; rows ];
%     run_lengths = diff([ 0 ;indices ]);
%     run_length_bins=A(indices,i)>0;
%     chord_length_counts=accumarray(run_lengths(run_length_bins),1);
%     chord_lengths(1:length(chord_length_counts))=chord_lengths(1:length(chord_length_counts))+chord_length_counts;
% end
% chord_length_x=chord_lengths/sum(chord_lengths);
% chord_length_x(1)=[];
% toc
