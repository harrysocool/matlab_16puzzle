function [cost, sequence] = DFS(initial_node,matrix_goal)
    % List storing every unanalysed node
    list = initial_node;
    list_index = 1;
    
        % analyse the last node from the list
        curr_node = list(1);
        
    while list_index<=10000
        
        curr_node = list(list_index);
        rnd = rand(1);
        % check if it reach the goal state
        if(min(min(curr_node.state == matrix_goal)))
            sequence = reconstruct(curr_node);
            cost = list_index;
            return
        else
            
            leftmoved = moveLeft(curr_node);
            if(max(max(leftmoved.state ~= curr_node.state)) && rnd <= 0.25)
                leftmoved.parent = curr_node;
                leftmoved.depth = curr_node.depth + 1;
                list_index = list_index + 1;
                list(list_index) = leftmoved;
            end

            rightmoved = moveRight(curr_node);    
            if(max(max(rightmoved.state ~= curr_node.state)) && rnd > 0.25 && rnd <= 0.5)
                rightmoved.parent = curr_node;
                rightmoved.depth = curr_node.depth + 1;
                list_index = list_index + 1;
                list(list_index) = rightmoved;
            end

            downmoved = moveDown(curr_node);
            if(max(max(downmoved.state ~= curr_node.state)) && rnd > 0.5 && rnd <= 0.75)
                downmoved.parent = curr_node;
                downmoved.depth = curr_node.depth + 1;
                list_index = list_index + 1;
                list(list_index) = downmoved;
            end
            
            upmoved = moveUp(curr_node);
            if(max(max(upmoved.state ~= curr_node.state)) && rnd > 0.75 && rnd <= 1)    
                upmoved.parent = curr_node;
                upmoved.depth = curr_node.depth + 1;
                list_index = list_index + 1;
                list(list_index) = upmoved;
            end
        end
    end
    sequence = char('Not Found');
    cost = list_index;
end