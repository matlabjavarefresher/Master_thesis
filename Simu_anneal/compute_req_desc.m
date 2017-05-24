function [desc] = compute_req_desc(img,req_desc)

lp=any(ismember(req_desc,'lp'));
cd=any(ismember(req_desc,'cd'));
s2=any(ismember(req_desc,'s2'));

if lp==1
    [l_p_x] = lineal_path_calc(img);
    [l_p_y] = lineal_path_calc(img');
else
    l_p_x=zeros(size(img,2),1);
    l_p_y=zeros(size(img,1),1);
end

if cd==1
    [c_l_x] = chord_length_func_calc(img);
    [c_l_y] = chord_length_func_calc(img');
else
    c_l_x=zeros(size(img,2),1);
    c_l_y=zeros(size(img,1),1);
end

if s2==1
    [a_cx] = auto_corr(img);
    %a_c=zeros(size(img,2),1);
    %a_cx(1:length(a_c))=a_c_1;
    [a_cy] = auto_corr(img');
    %a_cy=zeros(size(img,1),1);
    %a_cy(1:length(a_cc))=a_cc;
else
    a_cx=zeros(1,size(img,2));
    a_cy=zeros(1,size(img,1));
end

desc=[l_p_x,l_p_y,c_l_x,c_l_y,a_cx',a_cy'];

end

