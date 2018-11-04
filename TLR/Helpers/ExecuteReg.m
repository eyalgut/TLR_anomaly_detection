function [ W , errs,MeanErr ,finalErr] = ExecuteReg(X,Y ,dest_path,TYPE)
[rows,~]=size(X);
errs=zeros(rows,1);
if nargin <4
    TYPE='CROSS';
end
if strcmp(TYPE,'CROSS')
    for i=1:rows % around 1296
        if i==1
        X_CURR=X(2:rows,:);
        Y_CURR=Y(2:rows);
        elseif  i==rows
        X_CURR=X(1:rows-1,:);
        Y_CURR=Y(1:rows-1);
        else
        X_CURR=[ X(1:i-1,:) ; X(i+1:rows,:)]; 
        Y_CURR=[ Y(1:i-1) ; Y(i+1:rows)];
        end
        mdl=fitlm(X_CURR,Y_CURR); 
        W=mdl.Coefficients.Estimate; 
        pred=[1, X(i,:)]*W;
        errs(i)=(pred-Y(i))^2; %square errs
    end
end
%calc for all the sample
MeanErr=sqrt(mean(errs));
mdl=fitlm(X,Y);
W=mdl.Coefficients.Estimate; 
pred=[ones(rows,1) , X]*W;
finalErr=sqrt(immse(pred,Y));
saveALL(W,errs,MeanErr,finalErr,dest_path,TYPE);
end

function saveALL(W,errs,MeanErr,finalErr,dest_path,TYPE)
path=fullfile(dest_path,'reg_final_results.mat');
if exist(dest_path, 'dir')==0
    mkdir(dest_path);   
end
if strcmp(TYPE,'CROSS')
save(path,'W','errs','MeanErr');
else
save(path,'W','errs','finalErr');
end
end

