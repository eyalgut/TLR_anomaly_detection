function [ latent_users,latent_tables,pred ] = getData( U,S,V,data )
latent_users=data*V;
latent_tables=data'*U;
pred=U*S*V';  
end

