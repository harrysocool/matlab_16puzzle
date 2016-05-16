if(~exist('IDS_result'))
    IDS_result = {};
    IDS_result{4,2} = [];
end
for j = 1:2
    for i = 1:10
        [tcost,sequence,depth,space] = IDS(init,goal,20);
        result(i,:) = [tcost,depth,space];
        result_sequence{i,1} = sequence;
    end
    n = size(IDS_result,2);
    if(~isempty(IDS_result{3,n}))
        n = n;
    else
        n = n - 2;
    end
    IDS_result{1,n+1} = difficulty;
    IDS_result{1,n+2} = difficulty;
    IDS_result{j+1,n+1} = result;
    IDS_result{j+1,n+2} = result_sequence;
end
%%
D_data = [];
for i = 2:3
   for j = 1:10
       if(length(DFS_result{i,n+2}{j}) > 1)
            D_data(size(D_data,1) + 1,:) = IDS_result{i,n+1}(j,:);
       end
   end
end
n = n + 2;


