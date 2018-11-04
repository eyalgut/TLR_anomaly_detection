
 function [data,U,S,V,pred,mat_arr_cell,files_mat]=getIbmDataFull(dest)
new_model='IBM_New_Model/Model';
S=load(fullfile(dest,new_model,'S.mat'));
S=S.S;
U=load(fullfile(dest,new_model,'U.mat'));
U=U.U;
V=load(fullfile(dest,new_model,'V.mat'));
V=V.V;
pred=U*S*V';
data=load(fullfile(dest,new_model,'data.mat'));
data=data.data;
new_model_mats='IBM_New_Model/full_sparse_data';
files_mat=load(fullfile(dest,new_model_mats,'files_mat.mat'));
files_mat=files_mat.files_mat;
mat_arr_cell=load(fullfile(dest,new_model_mats,'mat_arr_cell_full.mat'));
mat_arr_cell=mat_arr_cell.mat_arr_cell_full;
end