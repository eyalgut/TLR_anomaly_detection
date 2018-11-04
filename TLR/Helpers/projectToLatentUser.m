%{
u - binary row vector of table accesses , u in R^{m'},m'>=m . could also
contain new tables, which are ignored
V - matrix in R^{m,k}
Casts user u to latent representation
%}
function u_new = projectToLatentUser( u,V )
rows=size(V,1);
u_new=u(:,1:rows)*V; %newer features are ignored
end

%New addition: can also get a matrix u when every row is a user and return a matrix when
%every row is that user in latent representation

