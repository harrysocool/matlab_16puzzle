function [tcost, sequence, depth, space] = A_star(initial_node,goal_node)
    tic %start system timer
    % set the "time cost"(step cost) to be zero
    tcost = 0;
    space = 0;
    % get the initial hscore
    initial_node.hscore = getMscore(initial_node,goal_node);
    % put the initial node into the open_list
    open_list(1,1) = initial_node;
    % put the initial score into first place in the score_list
    score_list(1,1) = initial_node.tcost + initial_node.hscore;

    % while the open_list is not full accessed, keep looping
    while ~isempty(open_list)
        % set curr_index as the node index with the latest lowest "tcost + hscore"
        [S,I] = sort(score_list);
        curr_index = I(find(S == S(1), 1, 'last' ));
        
        % fetch the curr_node from the open_list with curr_index
        curr_node = open_list(curr_index,1);
        % space is the maximum number of nodes in memory
        if (length(open_list) > space)
           space = length(open_list);
        end        
        % remove this node from open_list & score_list
        score_list(curr_index) = [];
        open_list(curr_index) = [];
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
        elseif(tcost>20000)
            sequence = {'No Solution'};
            tcost = 0;
            depth = 0;
            space = 0;
            return
        else
            % action for move the tile "55" left
            leftmoved = moveLeft(curr_node);
            % if the moved state is not equal to its parent state
            % detect the boundray of the puzzle
            if(testDiff(leftmoved,curr_node))
                % time consumed plus 1
               tcost = tcost + 1;
               leftmoved.tcost = tcost;
               % parent node for sequence generate
               leftmoved.parent = curr_node;
               % depth + 1
               leftmoved.depth = curr_node.depth + 1;
               % generate the Manhattan distance to the goal state
               leftmoved.hscore = getMscore(leftmoved,goal_node);
               % put the score of (tcost + hscore) in the score_list
               score_list(length(score_list)+1,1) = leftmoved.tcost + leftmoved.hscore;
               % put the moved node into the back of the open_list
               open_list(length(open_list)+1,1) = leftmoved;
            end

            upmoved = moveUp(curr_node);
            if(testDiff(upmoved,curr_node))
                tcost = tcost + 1;
                upmoved.tcost = tcost;
                upmoved.parent = curr_node;
                upmoved.depth = curr_node.depth + 1;
                upmoved.hscore = getMscore(upmoved,goal_node);
                score_list(length(score_list)+1,1) = upmoved.tcost + upmoved.hscore;
                open_list(length(open_list)+1,1) = upmoved;
            end

            rightmoved = moveRight(curr_node);
            if(testDiff(rightmoved,curr_node))
                tcost = tcost + 1;
                rightmoved.tcost = tcost;
               rightmoved.parent = curr_node;
               rightmoved.depth = curr_node.depth + 1;
               rightmoved.hscore = getMscore(rightmoved,goal_node);
               score_list(length(score_list)+1,1) = rightmoved.tcost + rightmoved.hscore;
               open_list(length(open_list)+1,1) = rightmoved;
            end

            downmoved = moveDown(curr_node);
            if(testDiff(downmoved,curr_node))
                tcost = tcost + 1;
                downmoved.tcost = tcost;
               downmoved.parent = curr_node;
               downmoved.depth = curr_node.depth + 1;
               downmoved.hscore = getMscore(downmoved,goal_node);
               score_list(length(score_list)+1,1) = downmoved.tcost + downmoved.hscore;
               open_list(length(open_list)+1,1) = downmoved;           
            end
        end
    end
end