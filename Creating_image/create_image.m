function [image,shape_count]=create_image(image, res, ns, max_tries, gx1y1, S, ...
    cutoff_func, combine_func, overlap_func, varargin)

shape_count = 0;
iter = 0;

while (shape_count<ns && iter<max_tries)
    s=S.sample(1);
    a=s(1);
    b=s(2);
    th=s(3);
    pow=s(4);
    gcxy_sh=[s(5); s(6)];
    iter=iter+1;
    [shape, shape_top_left] = compute_local_shape(gx1y1, res, [a;b], pow, gcxy_sh, th, cutoff_func);
    add=check_overlap(shape, image, shape_top_left, overlap_func);

    if add==0
        continue;
    end

    image = place_image(image, shape, shape_top_left, combine_func);
    shape_count=shape_count+1;

end

