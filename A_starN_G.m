function [tcost, sequence, depth, space] = A_starN_G(initial_node,goal_node,net,p)
% normal Manhattan Distance with p factor and tcost
    tic %start system timer
    % set the "time cost"(step cost) to be zero
    tcost = 0;
    space = 0;
    % get the initial hscore
    hscore = zscore(initial_node.getArray,0,2);
    initial_node.hscore = net(hscore(1:16)')*p;
    % put the initial node into the open_list
    open_list(1,1) = initial_node;
    % put the initial score into first place in the score_list
    score_list(1,1) = initial_node.depth + initial_node.hscore;
    open_alist(1,:) = initial_node.getArray;
    close_alist = [];
    

    % while the open_list is not full accessed, keep looping
    while ~isempty(open_list)        
        % set curr_index as the node index with the lowest "tc + hscore"
        [~,I] = sort(score_list);
        curr_index = I(1);
        
        % fetch the curr_node from the open_list with curr_index
        curr_node = open_list(curr_index,1);
        % space is the maximum number of nodes in memory
        if (length(open_list) + size(close_alist,1) > space)
           space = length(open_list) + size(close_alist,1) -1;
        end          
        % remove this node from open_list & score_list
        score_list(curr_index) = [];
        open_list(curr_index) = [];
        open_alist(curr_index,:) = [];
        close_alist(size(close_alist,1)+1,:) = curr_node.getArray;
        % display for the number of how many node generated
        disp(['Node Generated: ',int2str(tcost)]);
        
        % if the node state reach the goal state 
        if(~testDiff(curr_node,goal_node))
            % generate the sequence which raech the goal
            sequence = reconstruct(curr_node);
            % time cost 
            tcost = tcost;
            % depth for the goal node raeched
            depth = curr_node.depth;
            % stop and display the real time consumed 
            toc
            return 
        else
            % action for move the tile "55" left
            leftmoved = moveLeft(curr_node);
            % if the moved state is not equal to its parent state
            % detect the boundray of the puzzle
            if(testDiff(leftmoved,curr_node) && ~ismember(leftmoved.getArray,close_alist,'rows') && ~ismember(leftmoved.getArray,open_alist,'rows'))
                % time consumed plus 1
               tcost = tcost + 1;
               leftmoved.tcost = tcost;
               % parent node for sequence generate
               leftmoved.parent = curr_node;
               % depth + 1
               leftmoved.depth = curr_node.depth + 1;
               % generate the Manhattan distance to the goal state
               hscore = zscore(leftmoved.getArray,0,2);
               leftmoved.hscore = net(hscore(1:16)')*p;
               % put the score of (tcost + hscore) in the score_list
               score_list(length(score_list)+1,1) = leftmoved.depth + leftmoved.hscore;
               % put the moved node into the back of the open_list
               open_list(length(open_list)+1,1) = leftmoved;
               open_alist(size(open_alist,1)+1,:) = leftmoved.getArray;
            end

            upmoved = moveUp(curr_node);
            if(testDiff(upmoved,curr_node) && ~ismember(upmoved.getArray,close_alist,'rows') && ~ismember(upmoved.getArray,open_alist,'rows'))
                tcost = tcost + 1;
                upmoved.tcost = tcost;
                upmoved.parent = curr_node;
                upmoved.depth = curr_node.depth + 1;
                hscore = zscore([upmoved.getArray],0,2);
                upmoved.hscore = net(hscore(1:16)')*p;
                score_list(length(score_list)+1,1) = upmoved.depth + upmoved.hscore;
                open_list(length(open_list)+1,1) = upmoved;
                open_alist(size(open_alist,1)+1,:) = upmoved.getArray;
            end

            rightmoved = moveRight(curr_node);
            if(testDiff(rightmoved,curr_node) && ~ismember(rightmoved.getArray,close_alist,'rows') && ~ismember(rightmoved.getArray,open_alist,'rows'))
                tcost = tcost + 1;
                rightmoved.tcost = tcost;
               rightmoved.parent = curr_node;
               rightmoved.depth = curr_node.depth + 1;
                hscore = zscore([rightmoved.getArray],0,2);
                rightmoved.hscore = net(hscore(1:16)')*p;
               score_list(length(score_list)+1,1) = rightmoved.depth + rightmoved.hscore;
               open_list(length(open_list)+1,1) = rightmoved;
               open_alist(size(open_alist,1)+1,:) = rightmoved.getArray;
            end

            downmoved = moveDown(curr_node);
            if(testDiff(downmoved,curr_node) && ~ismember(downmoved.getArray,close_alist,'rows') && ~ismember(downmoved.getArray,open_alist,'rows'))
                tcost = tcost + 1;
                downmoved.tcost = tcost;
               downmoved.parent = curr_node;
               downmoved.depth = curr_node.depth + 1;
                hscore = zscore([downmoved.getArray],0,2);
                downmoved.hscore = net(hscore(1:16)')*p;
               score_list(length(score_list)+1,1) = downmoved.depth + downmoved.hscore;
               open_list(length(open_list)+1,1) = downmoved;
               open_alist(size(open_alist,1)+1,:) = downmoved.getArray;
            end
        end
    end
end