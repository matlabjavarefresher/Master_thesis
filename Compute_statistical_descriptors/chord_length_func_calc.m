function [c_l_x] = chord_length_func_calc(img)

cl=zeros(size(img,2),1);

img=[img,zeros(size(img,1),1)];

for i=1:size(img,1)
    
    countr=0;
    for j=1:size(img,2)

        if img(i,j)==0  
            
            if (countr>1)
                cl(countr-1)=cl(countr-1)+1;
                % if statement to avoid counting chords of 0 length

                % (countr=0) or single pixels (countr=1)
            end
            countr=0;
        else
            countr=countr+1;
        end
        
        
    end
end

c_l_x=cl/sum(cl);

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

