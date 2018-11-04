%{
mat_arr_cell_full - sparse matrices
dest_path - destination folder to keep U,S,V,B_{train},USERMAP,TABLESMAP

Saves on destination  U,S,V,B_{train},SERSMAP,TABLESMAP.
%}
function crossValidScenario( mat_arr_cell_full  ,dest_path)
indices = crossvalind('Kfold',length(mat_arr_cell_full),10);

folds=2:10;%1 is ready
total_folds=1:10;

test = (indices == 1); train = ~test;
mat_arr_train=mat_arr_cell_full(train);
mat_arr_test=mat_arr_cell_full(test);
 
 
 

[lambdas,errs_fold1]=getLambdaGrid(mat_arr_train,mat_arr_test);%base grid on fold-1


%display('Finished lambda grid');
errs=zeros(length(lambdas),length(total_folds)+1);
arr_results=cell(length(total_folds),1);
arr_results{1}=errs_fold1;

%optimization  - parfor on folds
%change to parfor
 
parfor fold=folds  
%    disp(fold);
    test = (indices == fold); train = ~test;
    mat_arr_train_fold=mat_arr_cell_full(train);
    mat_arr_test_fold=mat_arr_cell_full(test);

    train=getTrain(mat_arr_train_fold);
    err_ll=zeros(length(lambdas),1);
    %Pivot Optimization (Dynamic program)
    lam_index=1;
    lam=lambdas(lam_index);
    [a,b,c]=ApproxLowRank(train,lam);
    X=a*b*c';
    err_ll(lam_index)=calcLikeLihood(X,mat_arr_test_fold);
    prev_lam=lam;
    for lam_index=2:length(lambdas)
        lam=lambdas(lam_index);  
        sing_vals=diag(b);
        singvals=max(sing_vals-(lam-prev_lam),0);  %optimization -s A Dynamic program
        singvals=singvals(singvals>0);
        b=diag(singvals);
        a=a(:,1:length(singvals)); 
        c=c(:,1:length(singvals));
        X=a*b*c';
        err_ll(lam_index)=calcLikeLihood(X,mat_arr_test_fold);
        prev_lam=lam;
    end
    arr_results{fold}=err_ll;
end
%get results
for fold=total_folds
    res_arr=arr_results{fold};
    for lam_ind =1:length(lambdas)
        errs(lam_ind,fold)=res_arr(lam_ind);
    end
end
%calc means
for lam_index=1:length(lambdas)
    errs(lam_index,length(total_folds)+1)=nanmean(errs(lam_index,total_folds));%ignore nan vals
end 
%get best lambda
best_lam_index=getBestLambda(lambdas,total_folds,errs);
best_lambda=lambdas(best_lam_index);
train=getTrain(mat_arr_cell_full);
[a,b,c]=ApproxLowRank(train,best_lambda);
saveAll(a,b,c,train,best_lambda,lambdas,errs,dest_path);
end
%{
source_path - source fodler of raw data
fold - fold number
type - train or test

Returns B_{type} (B_{train} or B_{test})
%}
function train=getTrain(mat_arr_train)%return train/test
    train=zeros(size(mat_arr_train{1}));
    for i=1:length(mat_arr_train)
        train=train+full(mat_arr_train{i});
    end
    train=train/length(mat_arr_train);
end
%{
U - matrix in R^{m,k}
S - matrix in R^{k,k}
V - matrix in R^{n,k}
best_lambda - winner between lambdas
lambdas - grid of lambdas
errs - matrix in R^{length(lambdas),length(folds)+1}.The likelihood matrix
of each lambda on each fold.
dest_path - destination to save all the parameters

Saves all the inputs in dest_path
%}
function saveAll(U,S,V,data,best_lambda,lambdas,errs,dest_path)
path=fullfile(dest_path,sprintf('%d.mat',best_lambda));
if exist(dest_path, 'dir')==0
    mkdir(dest_path);   
end
save(fullfile(dest_path,'misc.mat'),'lambdas','errs','best_lambda'); %Uncomment for more info to be
save(fullfile(dest_path,'U.mat'),'U');
save(fullfile(dest_path,'S.mat'),'S');
save(fullfile(dest_path,'V.mat'),'V');
save(fullfile(dest_path,'data.mat'),'data');
end

%{
lambdas - grid of lambdas
folds - 1:10
errs - matrix in R^{length(lambdas),length(folds)+1}.The likelihood matrix
of each lambda on each fold.

Returns the lambda index where
mean(err(lambda_index,1:10))=err(lambda_index,11) is largest
%}
function best_lam_index=getBestLambda(lambdas,folds,errs)
    %init for first lambda
    best_lam_index=1;
    best_err=errs(best_lam_index,length(folds)+1);
    for lam_index=1:length(lambdas)
        if errs(lam_index,length(folds)+1)>best_err % a large liklihood is good
            best_err=errs(lam_index,length(folds)+1);
            best_lam_index=lam_index;
        end
    end
end
%{
X - binary matrix in R^{m,n} , m is the number of users, n is the number of tables
Test - binary matrix in R^{m,n} , m is the number of users, n is the number of tables

Returns likelihood(X,Test) (the likelihood of Test considering the prediction X)
%}
function err=calcLikeLihood(X,mat_test)
err=0;
for i=1:length(mat_test)
    Test=full(mat_test{i});
    Pred=X;
    Pred(Pred>=1)=1-eps;
    Pred(Pred<=0)=eps;
    err=err+sumMat(log(Pred.^Test))+sumMat(log((1-Pred).^(1-Test)));
end
err=err/length(mat_test);
end

function res=sumMat(M)
res=sum(M(:));
end

function [lambdas,errs]=getLambdaGrid(mat_arr_train,mat_arr_test) %uristic for choosing lambdas

    train=getTrain(mat_arr_train);
    %INIT
    [~,lam,~]=svds(train,1); %get spectral norm  
    lam=round(lam);
    lambdas=[lam];
    [a,b,c]=ApproxLowRank(train,lam);
    X=a*b*c'; %: should give solution ~ 0
    best_err=calcLikeLihood(X,mat_arr_test); 
    errs=best_err;
    counter=0;
    
    while counter<2 %when counter is 2 then we finished the grid
        lam=(lam/2);
        lambdas=[lam lambdas];
        [a,b,c]=ApproxLowRank(train,lam);
         X=a*b*c';
         curr_err=calcLikeLihood(X,mat_arr_test);
         errs=[curr_err ; errs];
         if best_err<curr_err
             best_err=curr_err;
             counter=0;
         else
           counter=counter+1;   %best_err>curr_err - curr is lower
         end
    end 
end
