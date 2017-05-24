function [lp_vals] = lin_path_calc( A,rand_or_uni,ran_rows,ran_cols,no_of_locs,beg_loc)
count_x=zeros(size(A,2),1);
count_y=zeros(size(A,1),1);


%Random Lines along rows

for i=1:size(ran_rows,1)
    counter=0;
    r=ran_rows(i);
    
    
    for  j=1:size(beg_loc)
        beg_pos=beg_loc(j);
        
        for k=beg_pos:(size(A,2)-1)
            
          
            if rand_or_uni==1 && A(r,k)== 0
                break
            end
            
            if A(r,k)== 1 && A(r,k+1)== 1
                
                counter=counter+1;
                
                if k == size(A,2)-1
                    %count_x(counter)= count_x(counter)+1
                    count_x=count_x+([(counter:-1:1)';zeros(size(count_x,1)-counter,1)]);
                    counter=0;
                    
                end
                
                continue
                
            else if counter >= 1 && A(r,k)== 1 && A(r,k+1)== 0
                    
                    %count_x(counter)= count_x(counter)+1
                    count_x=count_x+([(counter:-1:1)';zeros(size(count_x,1)-counter,1)]);
                    counter=0;
                    
                    
                    if rand_or_uni==1
                        break
                    end
                    
                    
                end
                
            end
            
        end
        
    end
    
    
end

%Random Lines along columns
for i=1:size(ran_cols,1)
    counter=0;
    c=ran_cols(i);
    
    
    for  j=1:size(beg_loc)
        beg_pos=beg_loc(j);
        
        for k=beg_pos:(size(A,1)-1)
            
          
            if rand_or_uni==1 && A(k,c)== 0
                break
            end
            
            if A(k,c)== 1 && A(k+1,c)== 1
                
                counter=counter+1;
                
                if k == size(A,1)-1
                    %count_y(counter)= count_y(counter)+1
                    count_y=count_y+([(counter:-1:1)';zeros(size(count_y,1)-counter,1)]);
                    counter=0;
                    
                end
                
                continue
                
            else if counter >= 1 && A(k,c)== 1 && A(k+1,c)== 0
                    
                    %count_y(counter)= count_y(counter)+1
                    count_y=count_y+([(counter:-1:1)';zeros(size(count_y,1)-counter,1)]);
                    counter=0;
                    
                    
                    if rand_or_uni==1
                        break
                    end
                    
                    
                end
                
            end
            
        end
        
    end
    
    
end

%% Calculating lineal path function

lp_vals=(count_y+count_x)/(size(ran_rows,1)*size(beg_loc,1)+size(ran_cols,1)*size(beg_loc,1));



end

