function [BW,bg] = shape_gen_circ(ovlp,bg_siz,no_circs,radi,cent_x,cent_y)


bg=zeros(bg_siz);

switch ovlp
    case 1
        for i=1:no_circs
            
            r=radi(i);
            c_x=cent_y(i);
            c_y=cent_x(i);
            
            l_u_c=[c_x-r,c_y-r];
            
            if (l_u_c(1)>0 && l_u_c(1)<=size(bg,1)) && (l_u_c(2)>0 && l_u_c(2)<=size(bg,1))
                if bg(l_u_c(1),l_u_c(2)) ~= 1
                    l_u_c_val=1;
                else
                    l_u_c_val=0;
                end
            end
            
            r_u_c=[c_x+r,c_y-r];
            
            if (r_u_c(1)>0 && r_u_c(1)<=size(bg,1)) && (r_u_c(2)>0 && r_u_c(2)<=size(bg,1))
                if bg(r_u_c(1),r_u_c(2)) ~= 1
                    r_u_c_val=1;
                else
                    r_u_c_val=0;
                end
            end
            
            l_b_c=[c_x-r,c_y+r];
            
            if (l_b_c(1)>0 && l_b_c(1)<=size(bg,1)) && (l_b_c(2)>0 && l_b_c(2)<=size(bg,1))
                if bg(l_b_c(1),l_b_c(2)) ~= 1
                    l_b_c_val=1;
                else
                    l_b_c_val=0;
                end
            end
            
            r_b_c=[c_x+r,c_y+r];
            
            if (r_b_c(1)>0 && r_b_c(1)<=size(bg,1)) && (r_b_c(2)>0 && r_b_c(2)<=size(bg,1))
                if bg(r_b_c(1),r_b_c(2)) ~= 1
                    r_b_c_val=1;
                else
                    r_b_c_val=0;
                end
            end
            
            l_c_c=[c_x-r,c_y];
            
            if (l_c_c(1)>0 && l_c_c(1)<=size(bg,1)) && (l_c_c(2)>0 && l_c_c(2)<=size(bg,1))
                if bg(l_c_c(1),l_c_c(2)) ~= 1
                    l_c_c_val=1;
                else
                    l_c_c_val=0;
                end
            end
            
            r_c_c=[c_x+r,c_y];
            
            if (r_c_c(1)>0 && r_c_c(1)<=size(bg,1)) && (r_c_c(2)>0 && r_c_c(2)<=size(bg,1))
                if bg(r_c_c(1),r_c_c(2)) ~= 1
                    r_c_c_val=1;
                else
                    r_c_c_val=0;
                end
            end
            
            t_c_c= [c_x,c_y-r];
            
            if (t_c_c(1)>0 && t_c_c(1)<=size(bg,1)) && (t_c_c(2)>0 && t_c_c(2)<=size(bg,1))
                if bg(t_c_c(1),t_c_c(2)) ~= 1
                    t_c_c_val=1;
                else
                    t_c_c_val=0;
                end
            end
            
            b_c_c= [c_x,c_y+r];
            
            if (b_c_c(1)>0 && b_c_c(1)<=size(bg,1)) && (b_c_c(2)>0 && b_c_c(2)<=size(bg,1))
                if bg(b_c_c(1),b_c_c(2)) ~= 1
                    b_c_c_val=1;
                else
                    b_c_c_val=0;
                end
                
            end
            
            if l_u_c_val == 1 && r_u_c_val == 1 && l_b_c_val == 1 && r_b_c_val == 1 && l_c_c_val == 1 && r_c_c_val == 1 && t_c_c_val==1 && b_c_c_val==1
                
                
                for pix_y=l_u_c(2):l_u_c(2)+2*r
                    if pix_y>0 && pix_y<size(bg,1)
                        for pix_x=l_u_c(1):l_u_c(1)+2*r
                            if pix_x>0 && pix_x<size(bg,1)
                                
                                if ((pix_y-c_y)^2+(pix_x-c_x)^2) <= (r^2)
                                    bg(pix_x,pix_y)=1;
                                end
                            end
                        end
                    end
                end
                
            end
            
        end
        
    case 2
        for i=1:no_circs
            
            r=radi(i);
            c_x=cent_y(i);
            c_y=cent_x(i);
            
            l_u_c=[c_x-r,c_y-r];
            
            for pix_y=l_u_c(2):l_u_c(2)+2*r
                if pix_y>0 && pix_y<size(bg,1)
                    for pix_x=l_u_c(1):l_u_c(1)+2*r
                        if pix_x>0 && pix_x<size(bg,1)
                            
                            if ((pix_y-c_y)^2+(pix_x-c_x)^2) <= (r^2)
                                bg(pix_x,pix_y)=1;
                            end
                        end
                    end
                end
            end
            
        end
        
end
BW = im2bw(bg, 0.5);
imshow(BW);


end

