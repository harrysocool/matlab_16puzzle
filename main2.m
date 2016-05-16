% all_time = {'Actual Difficulty','normal','2*normal','weighted','Hdis*Mdis','Neural Network'};
% all_sequence = {'Actual Difficulty','normal','2*normal','weighted','Hdis*Mdis','Neural Network'};
%% start puzzle
matrixst = ones(4,4);
% matrixst(4,4) = 2;
% matrixst(1,1) = 3;
% matrixst(1,4) = 4;
% matrixst(4,3) = 5;
% matrixst(4,:) = [2,3,4,5];
matrixst = reshape(train_data(43588,1:16),4,4)';
init = node(matrixst);
[~,b] = ismember(init.getArray,train_data(:,1:16),'rows');
d = train_data(b,17);
all_time{d+1,1} = d;
all_sequence{d+1,1} = d;
%% goal puzzle
matrixgo = ones(4,4);
matrixgo(:,2) = [1,2,3,4];
matrixgo(4,4) = 5;
goal = node(matrixgo);

%% depth + normal
[tcost,sequence,~,~] = A_star1_G(init,goal,15000);
all_time{d+1,2} = tcost;
all_sequence{d+1,2} = length(sequence)-1;
%% depth + 2*normal
[tcost,sequence,~,~] = A_star2_G(init,goal,10000);
all_time{d+1,3} = tcost;
all_sequence{d+1,3} = length(sequence)-1;
%% depth + weighted
[tcost,sequence,~,~] = A_star3_G(init,goal,10000);
all_time{d+1,4} = tcost;
all_sequence{d+1,4} = length(sequence)-1;
%% depth + Special Manhattan
[tcost,sequence,~,~] = A_star4_G(init,goal,10000);
all_time{d+1,5} = tcost;
all_sequence{d+1,5} = length(sequence)-1;
%% depth + Neural Network
[tcost,sequence,~,~] = A_starN1_G(init,goal,net,10);
all_time{d+1,6} = tcost;
all_sequence{d+1,6} = length(sequence)-1;
    
