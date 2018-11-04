function likelihood=getLikelihood(pred,B_t,U,V,latent_users,latent_tables)
 
[rows,cols]=size(pred);
[new_rows,new_cols]=size(B_t);
new_pred=zeros(new_rows,new_cols);
new_pred(1:rows,1:cols)=pred; % get pred values
%TODO - preallocate - need to optimize sometime??? !!!
for i=(rows+1):new_rows
    latent_new_user=B_t(i,1:cols)*V;
    neighbour_index=getNearestNeighbourV2(latent_users,latent_new_user);
    new_pred(i,:)=new_pred(neighbour_index,:);
end

for j=(cols+1):new_cols
    latent_new_table=B_t(1:rows,j)'*U;
    neighbour_index=getNearestNeighbourV2(latent_tables,latent_new_table);
    new_pred(:,j)=new_pred(:,neighbour_index);
end
 
likelihood=calcLikeLihoodReguler(new_pred,B_t);
end


function neighbour_index=getNearestNeighbourV2(latent_objects,latent_new_object)
LL=latent_objects-latent_new_object;
LL=sum((LL.^2),2);
[~,neighbour_index]=min(LL);
end

function err=calcLikeLihoodReguler(Pred,Test)
Pred(Pred>=1)=1-eps;
Pred(Pred<=0)=eps;
err=sumMat(log(Pred.^Test))+sumMat(log((1-Pred).^(1-Test)));
end

function res=sumMat(M)
res=sum(sum(M));
end