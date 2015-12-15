function [visited, sequence] = IDS(initial_node,matrix_goal,d)
    % List storing every unanalysed node
    list = initial_node;
    list_index = 1;
    
    visited = [];
    while list_index > 0
        % analyse the last node from the list
        curr_node = list(list_index);
        list_index = list_index - 1;
        
        % put the node into visited list
        [n ,~] = size(visited);
        visited((n + 1),:) = getArray(curr_node);
        
        % check if it reach the goal state
        if(min(min(curr_node.state == matrix_goal)))
            sequence = reconstruct(curr_node);
            return
        
        elseif(curr_node.depth < d)    
            leftmoved = moveLeft(curr_node);
            if(max(max(leftmoved.state ~= curr_node.state)) && ~ismember(getArray(leftmoved), visited,'rows'))
                leftmoved.parent = curr_node;
                leftmoved.depth = curr_node.depth + 1;
                list_index = list_index + 1;
                list(list_index) = leftmoved;
            end

            rightmoved = moveRight(curr_node);
            if(max(max(rightmoved.state ~= curr_node.state)) && ~ismember(getArray(rightmoved), visited,'rows'))
                rightmoved.parent = curr_node;
                rightmoved.depth = curr_node.depth + 1;
                list_index = list_index + 1;
                list(list_index) = rightmoved;
            end

            downmoved = moveDown(curr_node);
            if(max(max(downmoved.state ~= curr_node.state)) && ~ismember(getArray(downmoved), visited,'rows'))
                downmoved.parent = curr_node;
                downmoved.depth = curr_node.depth + 1;
                list_index = list_index + 1;
                list(list_index) = downmoved;
            end
            
            upmoved = moveUp(curr_node);
            if(max(max(upmoved.state ~= curr_node.state)) && ~ismember(getArray(upmoved), visited,'rows'))
                upmoved.parent = curr_node;
                upmoved.depth = curr_node.depth + 1;
                list_index = list_index + 1;
                list(list_index) = upmoved;
            end
        end
    end
end