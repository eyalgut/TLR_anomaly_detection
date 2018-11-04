function  percent_dist_items=getTestRanking(mats_test,file_mats_names_test)
addpath('Helpers');
%percent_dist_items - percentile of each interval from interval 24+
PIVOT=24;
len=length(mats_test);
    reg_final_results=getIbmReg();
    W=reg_final_results.W;
    
    [labels,data]=getDataLabels(mats_test,file_mats_names_test); %first 24 are pivots
    [r,~]=size(data);
    mypred=[ones(r,1) , data]*W;
    dists=abs(mypred-labels); 
    %errs(i)=(dists-mean(dists))./std(dists);
    [~, order]=sort(dists,'ascend');
    len=len-PIVOT;
    percent_dist_items=zeros(1,len);
    for k=1:len
        [~,location]=max(order==k);
        percent_dist_items(k)=(location/length(dists))*100;
    end
    %{
    %First 24 are pivots
    %could be tuned to show only high value percentiles. e.g. >90%
    plot(24:length(percent_dist_items)+24);
    for k=1:len
         text(k+24,percent_dist_items(k),['(' percent_dist_items(k) ')']);
    end
    %}
end
