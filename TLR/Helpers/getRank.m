function rank=getRank(lambda,max_rank)
   rank=round(max_rank/lambda/1.5);
   rank=min(rank,max_rank); %rank<=max_rank
   rank=max(1,rank); %rank>=1
end