function [tcost, sequence, depth, space] = BFS(initial_node,goal_node)
    tic %start timer
    index = 1;
    tc = 0;
    % put the initial node into the queue
    open_queue(index,1) = initial_node;
    
    % while the open_queue is not full accessed, keep looping
    while index <= length(open_queue)
        % fetch the first node in the open_queue as current node
        curr_node = open_queue(index,1);
        index = index + 1;
        % display for the number of how many node generated
        disp(['Node Generated: ',int2str(tc)]);
        
        % if the node state reach the goal state 
        if(~testDiff(curr_node,goal_node))
            % generate the sequence which raech the goal
            sequence = reconstruct(curr_node);
            % time cost 
            tcost = tc;
            % depth for the goal node raeched
            depth = curr_node.depth;
            % space consumed for saving all opened node
            space = length(open_queue);
            % stop and diaplay the real time consumed 
            toc
            return
        else
            % action for move the tile "0" left
            leftmoved = moveLeft(curr_node);
            % if the moved state is not equal to its parent state
            % detect the boundray of the puzzle
            if(testDiff(leftmoved,curr_node))
                % time consumed plus 1
               tc = tc + 1;
               leftmoved.tcost = tc;
               % parent node for sequence generate
               leftmoved.parent = curr_node;
               % depth + 1
               leftmoved.depth = curr_node.depth + 1;
               % put the moved node into the back of queue
               open_queue(length(open_queue)+1,1) = leftmoved;
            end

            upmoved = moveUp(curr_node);
            if(testDiff(upmoved,curr_node))
                tc = tc + 1;
                upmoved.tcost = tc;
                upmoved.parent = curr_node;
                upmoved.depth = curr_node.depth + 1;
                open_queue(length(open_queue)+1,1) = upmoved;
            end

            rightmoved = moveRight(curr_node);
            if(testDiff(rightmoved,curr_node))
                tc = tc + 1;
                rightmoved.tcost = tc;
               rightmoved.parent = curr_node;
               rightmoved.depth = curr_node.depth + 1;
               open_queue(length(open_queue)+1,1) = rightmoved;
            end

            downmoved = moveDown(curr_node);
            if(testDiff(downmoved,curr_node))
                tc = tc + 1;
                downmoved.tcost = tc;
               downmoved.parent = curr_node;
               downmoved.depth = curr_node.depth + 1;
               open_queue(length(open_queue)+1,1) = downmoved;               
            end
        end
    end
end