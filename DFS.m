function [tcost, sequence, depth, space] = DFS(initial_node,goal_node,limit)
    tic %start timer
    index = 1;
    tcost = 0;
    % put the initial node into the stack
    open_stack(index,1) = initial_node;
    
    % while the open_stack is not empty, keep looping
    while (index >=1 && tcost<100000)
            % fetch the last node (latest insert) in the open_stack as current node
            curr_node = open_stack(index,1);
            % index one step back to remove current node by overwrite it
            index = index - 1;
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
                space = index + 1;
                % stop and diaplay the real time consumed 
                toc
                return
            elseif(curr_node.depth < limit)
                % randomise the action order in order to get out of pointless loop 
                rnd = randperm(4);
                for i = 1:4
                    switch(rnd(i))
                        case(1)
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
                               index = index + 1;
                               % put the moved node into the back of open_stack
                               open_stack(index,1) = leftmoved;
                            end

                        case(2)
                            upmoved = moveUp(curr_node);
                            if(testDiff(upmoved,curr_node))
                                tcost = tcost + 1;
                                upmoved.tcost = tcost;
                                upmoved.parent = curr_node;
                                upmoved.depth = curr_node.depth + 1;
                                index = index + 1;
                                open_stack(index,1) = upmoved;
                            end

                        case(3)
                            rightmoved = moveRight(curr_node);
                            if(testDiff(rightmoved,curr_node))
                                tcost = tcost + 1;
                                rightmoved.tcost = tcost;
                               rightmoved.parent = curr_node;
                               rightmoved.depth = curr_node.depth + 1;
                               index = index + 1;
                               open_stack(index,1) = rightmoved;
                            end

                        case(4)    
                            downmoved = moveDown(curr_node);
                            if(testDiff(downmoved,curr_node))
                                tcost = tcost + 1;
                                downmoved.tcost = tcost;
                               downmoved.parent = curr_node;
                               downmoved.depth = curr_node.depth + 1;
                               index = index + 1;
                               open_stack(index,1) = downmoved;               
                            end
                    end
                end
            end
    end
    disp(['Solution not find at time cost limit: ',int2str(limit)]);
    sequence = {'No Solution'};
    tcost = curr_node.tcost;
    depth = curr_node.depth;
    space = length(open_stack);
end