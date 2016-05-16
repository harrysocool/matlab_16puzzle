if(~exist('DFS_result'))
    DFS_result = {};
    DFS_result{4,2} = [];
end
for j = 1:2
    for i = 1:10
        [tcost,sequence,depth,space] = DFS(init,goal,20);
        result(i,:) = [tcost,depth,space];
        result_sequence{i,1} = sequence;
    end
    n = size(DFS_result,2);
    if(~isempty(DFS_result{3,n}))
        n = n;
    else
        n = n - 2;
    end
    DFS_result{1,n+1} = difficulty;
    DFS_result{1,n+2} = difficulty;
    DFS_result{j+1,n+1} = result;
    DFS_result{j+1,n+2} = result_sequence;
end
%%
D_data = [];
for i = 2:3
   for j = 1:10
      if(length(DFS_result{i,n+2}{j}) > 1)
          D_data(size(D_data,1) + 1,:) = DFS_result{i,n+1}(j,:);
      end
   end
end
n = n + 2;
DFS_result{4,n} = size(D_data,1)/20;


