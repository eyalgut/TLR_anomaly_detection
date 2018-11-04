function   percent_dist_items=demo()

DATESET='DemoDataSet'; %partial version of teh full dateset
DATESET='DateSet'; % full dateset


%load model and reg mats
mat_arr_cell_train_model=load(fullfile(DATESET,'mat_arr_cell_train_model.mat'));
mat_arr_cell_train_model=mat_arr_cell_train_model.mat_arr_cell_train_model;
mat_arr_cell_train_reg=load(fullfile(DATESET,'mat_arr_cell_train_reg.mat'));
mat_arr_cell_train_reg=mat_arr_cell_train_reg.mat_arr_cell_train_reg;
files_mat_reg=load(fullfile(DATESET,'files_mat_reg.mat'));
files_mat_reg=files_mat_reg.files_mat_reg;
%end load mats

%Learning - creates a folder IBM_New_Model
LearnModel(mat_arr_cell_train_model,mat_arr_cell_train_reg,files_mat_reg)


%load test mats
mat_arr_cell_train_test=load(fullfile(DATESET,'mat_arr_cell_test.mat'));
mat_arr_cell_train_test=mat_arr_cell_train_test.mat_arr_cell_test;
files_mat_test=load(fullfile(DATESET,'files_mat_test.mat'));
files_mat_test=files_mat_test.files_mat_test;
%end load mats

%adding noise
%Add 0.1 noise to the second elemnt - Expecting a high percentile score
B=mat_arr_cell_train_test{26};
[r,c]=size(B);
noise=rand(r,c);
B=noise<0.1 | B; 
mat_arr_cell_train_test{26}=B;
%adding noise done

%classify
percent_dist_items=getTestRanking(mat_arr_cell_train_test,files_mat_test);

%graphic view
%First 24 are pivots
%could be tuned to show only high value percentiles. e.g. >95%
    %A simple visualization OF 98%+:
VisualizeResults(percent_dist_items)
end

function VisualizeResults(percent_dist_items)
PIVOT=24;
anomalies_index=find(percent_dist_items>99);
intervals=PIVOT+1:length(percent_dist_items)+PIVOT;
intervals=intervals(anomalies_index);
percent_anomalies=percent_dist_items(anomalies_index);
plot(intervals,percent_anomalies ,'r-o');
xlabel('Intervals');
ylabel('Anomaly Score %');
for k=1:length(intervals)
     text(intervals(k),percent_anomalies(k),['(' num2str(percent_anomalies(k)) '%)']);
end
end