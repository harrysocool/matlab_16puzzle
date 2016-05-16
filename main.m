%% Run this part only in the first time.
% all_time = {'Estimated Difficulty','Optimal Solution','DFS','IDS','BFS','A*','A*_G','IDS_G'};
% all_space = {'Estimated Difficulty','Optimal Solution','DFS','IDS','BFS','A*','A*_G','IDS_G'};
%% start puzzle
matrixst = ones(4,4);
matrixst(1,1) = 2;
matrixst(3,3) = 3;
matrixst(4,3) = 4;
matrixst(2,1) = 5;
% matrixst(4,:) = [52,53,54,55];
init = node(matrixst);
%% goal puzzle
matrixgo = ones(4,4);
matrixgo(:,2) = [1,2,3,4];
matrixgo(4,4) = 5;
goal = node(matrixgo);
difficulty = ['H','5+',int2str(getMscore(init,goal)-5)];
%%
run DFS_data_analyse;
% all_time{n/2+1,1} = difficulty;
% all_space{n/2+1,1} = difficulty;
all_time{n/2+1,3} = round(mean(D_data(:,1)));
all_space{n/2+1,3} = round(mean(D_data(:,3)));
all_trarray(size(all_trarray,1)+1,:) = init.getArray;
%%
run IDS_data_analyse;
all_time{n/2+1,4} = round(mean(D_data(:,1)));
all_space{n/2+1,4} = round(mean(D_data(:,3)));
%%
[tcost,sequence,depth,space] = BFS(init,goal);

all_time{n/2+1,5} = tcost;
all_space{n/2+1,5} = space;
%%
[tcost,sequence,depth,space] = A_star(init,goal);
all_time{n/2+1,6} = tcost;
all_space{n/2+1,6} = space;
%%
[tcost,sequence,depth,space] = A_star_G(init,goal);
all_time{n/2+1,7} = tcost;
all_space{n/2+1,7} = space;
all_time{n/2+1,2} = sequence;
all_space{n/2+1,2} = sequence;
%%
run IDS_G_data_analyse;
all_time{n/2+1,8} = round(mean(D_data(:,1)));
all_space{n/2+1,8} = round(mean(D_data(:,3)));
%%
save result.mat all_space all_time DFS_result IDS_result IDS_G_result
