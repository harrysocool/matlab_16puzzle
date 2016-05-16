matrixgo = ones(4,4);
matrixgo(:,2) = [1,2,3,4];
matrixgo(4,4) = 5;
goal = node(matrixgo);
for i = 1:size(train_data,1)
   curr_node = node(reshape(train_data(i,1:16),4,4)');
   score_list(i,2) = getMscore(curr_node,goal);
   score_list(i,3) = 2*getMscore(curr_node,goal);
   score_list(i,4) = getWeightedMscore(curr_node,goal);
   score_list(i,5) = getSMscore(curr_node,goal);
   disp(['Node Generated: ',int2str(i)]);
end
%%
error = score_list(:,1)-score_list(:,2);
error = sum(error)/43679;
boxplot([score_list(:,1),score_list(:,2),score_list(:,3),score_list(:,4),score_list(:,5)],'labels',{'Actual h(n)','Normal h(n)','2*Normal h(n)','Weighted h(n)','HMdis*Mdis'});
ylabel('length of solution sequence')
%%
