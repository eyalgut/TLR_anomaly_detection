%{
t - binary row vector of user accesses , t in R^{n'},n'>n . could also
contain new users which are ignored
U - matrix in R^{n,k}
Casts table t to latent representation
%}
function t_new = projectToLatentTable( t,U )
rows=size(U,1);
t_new=t(:,1:rows)*U;
end

%New addition: can also get a matrix  when every row is a table and return a matrix when
%every row is that table in latent representation