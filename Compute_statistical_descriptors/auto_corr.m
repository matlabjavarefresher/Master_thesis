function [avg_corr_wrt_dist] = auto_corr(A)

zero_rows=find(all((A==0),2)); %Finding the rows which are fully zero
inp=bsxfun(@minus,A,mean(A(:))); %First subtracting mean pixel value from each pixel value

%% Using fft manually

fftis=fft(inp,2*size(inp,2)-1,2); %Taking the fft of the input signal after padding it with required number of zeros to satisfy convolution
prod=fftis.*conj(fftis); 
corr=ifft(prod,[],2); % Inverse fft of the product of fft with it's conjugate
ext_corr=corr(:,1:size(inp,2)); %extract one half of the symmetric output of ifft (from the middle to one end) 
ext_corr(zero_rows,:)=ones(size(zero_rows,1),size(ext_corr,2)); % If any row has only zero elements in your input array
                                                            % set all the correlation values for that row to 1 
nrmlisd_corr=bsxfun(@rdivide,ext_corr,ext_corr(:,1)); % Normalise the extracted correlation values with first element or diagonal element      
corr_wrt_dist=bsxfun(@rdivide,nrmlisd_corr,(size(inp,2):-1:1)); % Divide with the number of correlation matrix entrees used in getting the sum 
avg_corr_wrt_dist=mean(corr_wrt_dist,1); % Get the mean of the correlation coefficients corresponding to each row

%% Using built in xcorr with for loop
% 
% % IF LICENSE AVAILABLE USE THIS
% tic
% corr=zeros(size(inp,1),2*size(inp,2)-1);
% for i=1:size(inp,1)
%     corr(i,:)=xcorr(inp(i,:),'coeff');
% end
% 
% ext_corr=corr(:,size(inp,2):1:size(corr,2));
% ext_corr(zero_rows,:)=ones(size(zero_rows,1),size(ext_corr,2)); 
% corr_wrt_dist=bsxfun(@rdivide,ext_corr,(size(inp,2):-1:1));
% avg_corr_wrt_dist=mean(corr_wrt_dist,1);    
% toc     

%%  Using built in xcorr without for loop

% inpu = mat2cell(inp,ones(size(inp,1),1));
% xc=@(ab) xcorr(ab,'coeff');
% corri = cellfun(xc,inpu,'UniformOutput',false);
% corr=cell2mat(corri);
% ext_corr=corr(:,size(inp,2):1:size(corr,2));
% ext_corr(zero_rows,:)=ones(size(zero_rows,1),size(ext_corr,2)); 
% corr_wrt_dist=bsxfun(@rdivide,ext_corr,(size(inp,2):-1:1)); 
% avg_corr_wrt_dist=mean(corr_wrt_dist,1);    


%% without fft - MOSTLY WON'T WORK - MAY NOT BE USING THE RIGHT METHOD  
% change=bsxfun(@minus,A(1:end,:),mean(A,2));
% change=bsxfun(@minus,A(1:end,:),0);
% covar=zeros(size(change,2),size(change,2),size(change,1));
% correl=zeros(size(change,2),size(change,2),size(change,1));
% sm=zeros(size(change,1),1);
% 
% for i=1:size(change,1)
%     covar(:,:,i)=change(i,:)'*change(i,:);
%     sm(i)=sum(diag(covar(:,:,i)));
%     
%     if sm(i)~=0
%         correl(:,:,i)=covar(:,:,i)/sm(i);
%         
%     else
%         correl(:,:,i)=ones(size(change,2),size(change,2));
%         % Assuming A has only positive elements or
%         % 0 and that the mean will not reach zero
%         % even if one element is non zero. If all
%         % elements are 0, then correl matrix =
%         % entrees of 1.
%         
%     end
%     
% end
% 
% avg_corr_coeff=mean(correl,3);



end

