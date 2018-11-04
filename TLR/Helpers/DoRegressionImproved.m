function DoRegressionImproved(U,S,V,train_data,dest_dir,mat_arr_cell ,files_mat)
%%%%%%%%%%%%%%%%% REGULER REDGRESSION
if exist(dest_dir, 'dir')==0
    mkdir(dest_dir);   
end
    [labels,data]=getDataLabels(mat_arr_cell,files_mat);
    ExecuteReg(data,labels ,dest_dir);
end


 

