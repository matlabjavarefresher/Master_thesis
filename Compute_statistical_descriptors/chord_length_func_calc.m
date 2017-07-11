function [chord_length_x] = chord_length_func_calc(image)

chord_lengths=zeros(size(image,2),1);

image=[image,zeros(size(image,1),1)];

for i=1:size(image,1)
    
    counter=0;
    for j=1:size(image,2)

        if image(i,j)==0  
            
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

%% Earlier code
% for i=1:size(img,1)
%     counter=0;
%     for j=1:size(img,2)-1
%;;
%         if img(i,j)== 1 && img(i,j+1)== 1
%             counter=counter+1;
%
%             if j == size(img,2)-1
%                 count_x(counter)=count_x(counter)+1;
%                 counter=0;
%                 tot_chords=tot_chords+1;
%             end
%             continue
%
%         else if counter >= 1 && img(i,j)== 1 && img(i,j+1)== 0
%                 count_x(counter)=count_x(counter)+1;
%                 counter=0;
%                 tot_chords=tot_chords+1;
%             end
%         end
%
%     end
%
% end
%
% c_l_x=count_x/tot_chords;

end

