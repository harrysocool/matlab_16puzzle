function [tcost, sequence, depth, space] = IDS_G(initial_node,goal_node,limit)
    tic %start timer
    tcost = 0;
    space = 0;
    for d = 1:limit
        index = 1;
        % put the initial node into the open_stack(1)
        open_stack(index,1) = initial_node;
        close_alist = [];
        % while the open_stack is not empty, keep looping
        while ~isempty(open_stack)
            % fetch the last node in the open_stack as current node
            curr_node = open_stack(index,1);
            % space is the maximum number of nodes in memory
            if (length(open_stack) + size(close_alist,1) > space)
               space = length(open_stack) + size(close_alist,1);
            end
            % remove this node from open_stack
            open_stack(index) = [];
            close_alist(size(close_alist,1)+1,:) = curr_node.getArray;
            % index one step back to load another node into open_stack
            index = index - 1;
            % display for the number of how many node generated
            disp(['Node Generated: ',int2str(tcost),' depth limit at: ',int2str(d)]);

            % if the node state reach the goal state 
            if(~testDiff(curr_node,goal_node))
                % generate the sequence which reach the goal
                sequence = reconstruct(curr_node);
                % time cost 
                tcost = tcost;
                % depth for the goal node raeched
                depth = curr_node.depth;
                % stop and diaplay the real time consumed 
                disp(['depth limit at: ',int2str(d)]);
                toc
                return
            elseif(curr_node.depth < d)
                % randomise the action order in order to get out of pointless loop 
                rnd = randperm(4);
                for i = 1:4
                    switch(rnd(i))
                        case(1)
                            % action for move the tile "55" left
                            leftmoved = moveLeft(curr_node);
                            % if the moved state is not equal to its parent state
                            % detect the boundray of the puzzle
                            if(testDiff(leftmoved,curr_node) && ~ismember(leftmoved.getArray,close_alist,'rows'))
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
                            if(testDiff(upmoved,curr_node) && ~ismember(upmoved.getArray,close_alist,'rows'))
                                tcost = tcost + 1;
                                upmoved.tcost = tcost;
                                upmoved.parent = curr_node;
                                upmoved.depth = curr_node.depth + 1;
                                index = index + 1;
                                open_stack(index,1) = upmoved;
                            end

                        case(3)
                            rightmoved = moveRight(curr_node);
                            if(testDiff(rightmoved,curr_node) && ~ismember(rightmoved.getArray,close_alist,'rows'))
                                tcost = tcost + 1;
                                rightmoved.tcost = tcost;
                               rightmoved.parent = curr_node;
                               rightmoved.depth = curr_node.depth + 1;
                               index = index + 1;
                               open_stack(index,1) = rightmoved;
                            end

                        case(4)    
                            downmoved = moveDown(curr_node);
                            if(testDiff(downmoved,curr_node) && ~ismember(downmoved.getArray,close_alist,'rows'))
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
    end
    sequence = {'No Solution'};
    tcost = curr_node.tcost;
    depth = curr_node.depth;
    space = space;
end