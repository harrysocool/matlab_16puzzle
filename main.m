clear all;
matrixst = ones(4,4);
matrixst(4,:) = [52,53,54,0];
matrixgo = ones(4,4);
% matrixgo(:,2) = [1,52,53,54];
% matrixgo(4,4) = 0;
matrixgo(4,:) = [52,53,54,1];
matrixgo(1,1) = 0;
init = node(matrixst);
goal = node(matrixgo);

%%
% [m,movecount] = move(matrix44,randperm(4,1))

clear difficulty;
clear a;
for d = 24:24
    sequence = DFS(n,matrixgo);
    x = length(visited);
    difficulty(d,1) = x;
    solutionIndex(d,1) = ismember(array,visited,'rows');
end
find(solutionIndex == 1);
%%
[tcost,sequence,depth,space] = DFS(init,goal);
%%
[tcost,sequence,depth,space] = IDS(init,goal,8);
%%
[tcost,sequence,depth,space] = BFS(init,goal);
