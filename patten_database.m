matrixgo = ones(4,4);
matrixgo(:,2) = [1,2,3,4];
matrixgo(4,4) = 5;
clear open_alist;
clear open_queue;
goal = node(matrixgo);
index = 1;
cindex = 1;
tcost = 0;
% put the initial node into the open_stack(1)
open_queue(index,1) = goal;
open_alist(index,:) = goal.getArray;
close_alist(index,:) = goal.getArray;
% while the open_stack is not empty, keep looping
while index <= length(open_queue)
    if(index == 1000)
       open_queue(1:index) = []; 
       index = 1;
    end
    % fetch the first node in the open_queue as current node
    curr_node = open_queue(index,1);
    close_alist(cindex,:) = curr_node.getArray;
    index = index + 1;
    cindex = cindex + 1;
    % display for the number of how many node generated
    disp(['Node Generated: ',int2str(tcost),' at depth ', int2str(curr_node.depth)]);

    if(curr_node.depth < 40)
                    % action for move the tile "5" left
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
                       % put the moved node into the back of open_stack
                       open_queue(length(open_queue)+1,1) = leftmoved;
                       open_alist(tcost,:) = leftmoved.getArray;
                       score(tcost,1) = leftmoved.depth;
                    end


                    upmoved = moveUp(curr_node);
                    if(testDiff(upmoved,curr_node) && ~ismember(upmoved.getArray,close_alist,'rows')  && ~ismember(upmoved.getArray,open_alist,'rows'))
                        tcost = tcost + 1;
                       upmoved.tcost = tcost;
                       upmoved.parent = curr_node;
                       upmoved.depth = curr_node.depth + 1;
                        open_queue(length(open_queue)+1,1) = upmoved;
                        open_alist(tcost,:) = upmoved.getArray;
                        score(tcost,1) = upmoved.depth;
                    end


                    rightmoved = moveRight(curr_node);
                    if(testDiff(rightmoved,curr_node) && ~ismember(rightmoved.getArray,close_alist,'rows') && ~ismember(rightmoved.getArray,open_alist,'rows'))
                        tcost = tcost + 1;
                       rightmoved.tcost = tcost;
                       rightmoved.parent = curr_node;
                       rightmoved.depth = curr_node.depth + 1;                        
                       open_queue(length(open_queue)+1,1) = rightmoved;
                       open_alist(tcost,:) = rightmoved.getArray;
                       score(tcost,1) = rightmoved.depth;
                    end

  
                    downmoved = moveDown(curr_node);
                    if(testDiff(downmoved,curr_node) && ~ismember(downmoved.getArray,close_alist,'rows') && ~ismember(downmoved.getArray,open_alist,'rows'))
                        tcost = tcost + 1;
                       downmoved.tcost = tcost;
                       downmoved.parent = curr_node;
                       downmoved.depth = curr_node.depth + 1;                          
                       open_queue(length(open_queue)+1,1) = downmoved;
                       open_alist(tcost,:) = downmoved.getArray;
                       score(tcost,1) = downmoved.depth;
                    end


    end
end