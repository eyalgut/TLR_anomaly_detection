function [ U,S,V,train_data] = getModelData()
dest_model='IBM_New_Model/Model'; 
U=load(fullfile(dest_model,'U.mat'));
U=U.U;
S=load(fullfile(dest_model,'S.mat'));
S=S.S;
V=load(fullfile(dest_model,'V.mat'));
V=V.V;
train_data=load(fullfile(dest_model,'data.mat'));
train_data=train_data.data;
end

