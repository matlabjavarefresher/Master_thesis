function [l_p_x] = lineal_path_calc(img)

c=zeros(size(img,2),1);
tot_count=0;

for i=1:size(img,1)
    countr=0;
    for j=1:size(img,2)
        tot_count=tot_count+1;
        if img(i,j)==0
            countr=0;
        else
            countr=countr+1;
            c=c+[ones(countr-1,1);zeros(length(c)-countr+1,1)];
            %ones(countr-1) to avoid counting line segments of zero length (or
            %single pixels)
        end
    end
end

l_p_x=c/tot_count;


%% Earlier code
% count_x=zeros(length(img),1);
% tot_count=0;
%
% for i=1:size(img,1)
%     counter=0;
%     for j=1:size(img,2)-1
%         tot_count=tot_count+1;
%
%         if img(i,j)== 1 && img(i,j+1)== 1
%             counter=counter+1;
%
%             if j == size(img,2)-1
%                 count_x=count_x+([(counter:-1:1)';zeros(size(count_x,1)-counter,1)]);
%                 counter=0;
%             end
%             continue
%
%         else if counter >= 1 && img(i,j)== 1 && img(i,j+1)== 0
%                 count_x=count_x+([(counter:-1:1)';zeros(size(count_x,1)-counter,1)]);
%                 counter=0;
%             end
%         end
%
%     end
%
%     l_p_x=count_x/tot_count;

end

