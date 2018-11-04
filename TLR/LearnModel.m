
function LearnModel(mat_arr_cell_train_model,mat_arr_cell_train_reg,files_mat_reg)
addpath('Helpers');
disp('LEARNING LOW RANK MODEL');
dest_model='IBM_New_Model'; %sge2
if exist(dest_model,'dir')==0
    mkdir(dest_model)
end
dest_model='IBM_New_Model/Model'; %sge2
if exist(dest_model,'dir')==0
    mkdir(dest_model)
end
%{
mat_arr_cell_train_model=load('IBM_New_Model/DemoDataSet/mat_arr_cell_train_model.mat');
mat_arr_cell_train_model=mat_arr_cell_train_model.mat_arr_cell_train_model;
%}
LearningScenario(dest_model,mat_arr_cell_train_model);
disp('FINISHED LOW RANK LEARNING STAGE');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
disp('LEARNING REG MODEL');
[ U,S,V,data] = getModelData();
%{
mat_arr_cell_train_reg=load(fullfile(model,'mat_arr_cell_train_reg.mat'));
mat_arr_cell_train_reg=mat_arr_cell_train_reg.mat_arr_cell_train_reg;
files_mat_reg=load(fullfile(model,'files_mat_reg.mat'));
files_mat_reg=files_mat_reg.files_mat_reg;
%}
dest='IBM_New_Model/reg'; 
if exist(dest,'dir')==0
    mkdir(dest)
end
dest_dir=fullfile(dest,'regIBMUnseen');
if exist(dest_model,'dir')==0
    mkdir(dest_model)
end
DoRegressionImproved(U,S,V,data,dest_dir,mat_arr_cell_train_reg ,files_mat_reg);
disp('FINISHED LEARNING REG MODEL');
end
