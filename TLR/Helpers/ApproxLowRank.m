%{
A - binary matrix in R^{m,n} , m is the number of users, n is the number of tables
lambda - regularization value

Find a similer low rank matrix to A : X=udv^{T}
%}
function [u,d,v] = ApproxLowRank(A,lambda) 
[rows,cols]=size(A);
max_rank=min(rows,cols);
K=getRank(lambda,max_rank);%uristic for choosing K
K=round(K);%fix for new dataset
while(1)
    %starting svds
    [ a,b,c ]= svds(A,K);
    %finishing svds
    if(min(diag(b))-lambda<=0) || K==max_rank
        break; %we finished
    end
    K=2*K; 
    if K>=max_rank
       K=max_rank; %we finished with a full svd :( 
    end
    %fprintf('CALC_AGAIN - K=%d is incremented to %d\n',prev_K,K);
end
sing_vals=diag(b);
singvals=max(sing_vals-lambda,0); 
singvals=singvals(singvals>0);
d=diag(singvals);
u=a(:,1:length(singvals)); 
v=c(:,1:length(singvals));
end
