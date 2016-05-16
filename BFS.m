function [tcost, sequence, depth, space] = BFS(initial_node,goal_node)
    tic %start timer
    index = 1;
    tcost = 0;
    % put the initial node into the queue
    open_queue(index,1) = initial_node;
    
    % while the open_queue is not full accessed, keep looping
    while index <= length(open_queue)
        % fetch the first node in the open_queue as current node
        curr_node = open_queue(index,1);
        index = index + 1;
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
            % space consumed for saving all opened node
            space = length(open_queue) - 1;
            % stop and diaplay the real time consumed 
            toc
            return
        elseif(tcost>100000)
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
               % put the moved node into the back of queue
               open_queue(length(open_queue)+1,1) = leftmoved;
            end

            upmoved = moveUp(curr_node);
            if(testDiff(upmoved,curr_node))
                tcost = tcost + 1;
                upmoved.tcost = tcost;
                upmoved.parent = curr_node;
                upmoved.depth = curr_node.depth + 1;
                open_queue(length(open_queue)+1,1) = upmoved;
            end

            rightmoved = moveRight(curr_node);
            if(testDiff(rightmoved,curr_node))
                tcost = tcost + 1;
                rightmoved.tcost = tcost;
               rightmoved.parent = curr_node;
               rightmoved.depth = curr_node.depth + 1;
               open_queue(length(open_queue)+1,1) = rightmoved;
            end

            downmoved = moveDown(curr_node);
            if(testDiff(downmoved,curr_node))
                tcost = tcost + 1;
                downmoved.tcost = tcost;
               downmoved.parent = curr_node;
               downmoved.depth = curr_node.depth + 1;
               open_queue(length(open_queue)+1,1) = downmoved;               
            end
        end
    end
end