
function [labels,data]=getDataLabels(mat_arr_cell,files_mat)
%%%%%%%%%%%%%%%%% Build Features and Labels according to reg model
[ U,S,V,train_data] = getModelData();
len=length(files_mat);
[ latent_users,latent_tables,pred ] = getData( U,S,V,train_data );
labels=zeros(len,1);
data=zeros(len,7);  
for i=1:24  %need just likelihood of first day 
    B_t=full(mat_arr_cell{i});
    labels(i)=getLikelihood(pred,B_t,U,V,latent_users,latent_tables);
end
for i=25:len 
    B_t=full(mat_arr_cell{i}); %full size matrix - including new users and tables
    file=char(files_mat{i});
    d=char(getDate(file));
    hour=str2num(d(9:10));
    day=str2num(d(7:8));
    month=str2num (d(5:6));
    year=str2num (d(1:4));
    time = datetime(year,month,day,hour,0,0);
    d_t=isweekend(time); %1-yes,0-no%
    h_t=hour+1; %(1-24 instead of 0-23)
    bits=sum(sum(B_t)); % how many bits are on
    labels(i)=getLikelihood(pred,B_t,U,V,latent_users,latent_tables);
    data(i,1)=d_t; %are we on a weekend%
    data(i,2)=h_t; %hour%
    data(i,3)=bits;% how many bits are on
    data(i,4)=i; %iteration
    data(i,5)=labels(i-1);%likelihood an hor ago
    data(i,6)=labels(i-24);%likelihood a day before ago
    data(i,7)=mod(h_t+12,24);%new hour feature      
end
    labels=labels(25:len); % date and labels shoould be the same size
    data=data(25:len,:);
end



