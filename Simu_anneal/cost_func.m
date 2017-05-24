function [y] = cost_func(in_img,desc,req_desc)

[desc_n] = compute_req_desc(in_img,req_desc);

if(any(desc_n)==nan)
    error('NaN values in the descriptor of the reconstruction')
end

if (any(desc)==nan)
    error('NaN values in the descriptor of the original image')
end
%intermed_1= max(sqrt((l_p_xn-l_p_x).^2));
%intermed_2= max(sqrt((c_l_xn-c_l_x).^2));

%interm_1=((desc_n(:,1)-desc(:,1))./desc(:,1));
%interme_1=interm_1(~isnan(interm_1));
%intermed_1=norm(sqrt(interme_1.^2));

%interm_2=((desc_n(:,2)-desc(:,2))./desc(:,2));
%interme_2=interm_2(~isnan(interm_2));
%intermed_2=norm(sqrt(interme_2.^2));


%interm_3=((desc_n(:,3)-desc(:,3))./desc(:,3));
%interme_3=interm_3(~isnan(interm_3));
%intermed_3=norm(sqrt(interme_3.^2));


%interm_4=((desc_n(:,4)-desc(:,4))./desc(:,4));
%interme_4=interm_4(~isnan(interm_4));
%intermed_4=norm(sqrt(interme_4.^2));

% intermed_1= sum(sqrt(((desc_n(:,1)-desc(:,1))/max(desc(:,1))).^2));
% intermed_2= sum(sqrt(((desc_n(:,2)-desc(:,2))/max(desc(:,2))).^2));
% intermed_3= sum(sqrt(((desc_n(:,3)-desc(:,3))/max(desc(:,3))).^2));
% intermed_4= sum(sqrt(((desc_n(:,4)-desc(:,4))/max(desc(:,4))).^2));

%% Good combo
intermed_1= sum(sqrt(((desc_n(:,1)-desc(:,1))/max(desc(:,1))).^2));
intermed_2= sum(sqrt(((desc_n(:,2)-desc(:,2))/max(desc(:,2))).^2));
intermed_3= sum(sqrt(((desc_n(:,3)-desc(:,3))/max(desc(:,3))).^2));
intermed_4= sum(sqrt(((desc_n(:,4)-desc(:,4))/max(desc(:,4))).^2));
intermed_5= sum(sqrt(((desc_n(:,5)-desc(:,5))/max(desc(:,5))).^2));
intermed_6= sum(sqrt(((desc_n(:,6)-desc(:,6))/max(desc(:,6))).^2));

%%
% interme_1= sqrt(((desc_n(:,1)-desc(:,1))./desc(:,1)).^2);
% intermed_1=max(interme_1(~isnan(interme_1)));
% interme_2= sqrt(((desc_n(:,2)-desc(:,2))./desc(:,2)).^2);
% intermed_2=max(interme_2(~isnan(interme_2)));
% interme_3= sqrt(((desc_n(:,3)-desc(:,3))./desc(:,3)).^2);
% intermed_3=max(interme_3(~isnan(interme_3)));
% interme_4= sqrt(((desc_n(:,4)-desc(:,4))./desc(:,4)).^2);
% intermed_4=max(interme_4(~isnan(interme_4)));

%%
% intermed_1= norm(sqrt(((desc_n(:,1)-desc(:,1))/desc(:,1)).^2));
% intermed_2= norm(sqrt(((desc_n(:,2)-desc(:,2))/desc(:,2)).^2));
% intermed_3= norm(sqrt(((desc_n(:,3)-desc(:,3))/desc(:,3)).^2));
% intermed_4= norm(sqrt(((desc_n(:,4)-desc(:,4))/desc(:,4)).^2));

%intermed_1= norm(sqrt(((desc_n(:,1)-desc(:,1))).^2));
%intermed_2= norm(sqrt(((desc_n(:,2)-desc(:,2))).^2));
%intermed_3= norm(sqrt(((desc_n(:,3)-desc(:,3))).^2));
%intermed_4= norm(sqrt(((desc_n(:,4)-desc(:,4))).^2));

y=max([intermed_1,intermed_2,intermed_3,intermed_4,intermed_5,intermed_6]);

end

