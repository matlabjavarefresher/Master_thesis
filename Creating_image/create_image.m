function [imag,sh_cnt]=create_image(imag,res,ns,ov,mx_try,sh_tp,gx1y1,S,cut_fn,comb_fn,ov_fn,varargin)

sh_cnt=0;
iter=0;
am_bm=[0;0];

switch sh_tp
    case 'smooth_convex'
        while (sh_cnt<ns && iter<mx_try)
            
            s=S.sample(1);
            a=s(1);
            b=s(2);
            th=s(3);
            pow=s(4);
            gcxy_sh=[s(5);s(6)];
            iter=iter+1;
            [sh, gj1i1_sh] = compute_local_shape(gx1y1, res, [a;b], pow, gcxy_sh, th,cut_fn);
            am_bm=((am_bm*(iter-1))+[a;b])/iter;
            [add]=check_overlap(ov,sh,imag,gj1i1_sh,ov_fn,res,am_bm);

            if add==0
                continue;
            end
            
            imag = place_imag(imag, sh, gj1i1_sh,comb_fn);
            sh_cnt=sh_cnt+1;
            
        end
end
end

