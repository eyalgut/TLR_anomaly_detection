%{
mat_arr_cell_full - binary access matrices
dest_path - destination folder to keep U,S,V,B_{train},USERMAP,TABLESMAP
Saves on destination  U,S,V,B_{train},USERSMAP,TABLESMAP.
%}
function LearningScenario(dest_path,mat_arr_cell_full)

dest_path=fullfile(dest_path);

if exist(dest_path,'dir')==0
    mkdir(dest_path);
end

disp('STARTING crossValidScenario.m - learning stage')
crossValidScenario( mat_arr_cell_full  ,dest_path);
end