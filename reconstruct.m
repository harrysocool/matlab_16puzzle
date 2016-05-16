function sequence = reconstruct(node)
    % first action
    sequence = {};
    sequence{1,1} = node.action;
    i = 2;
    % while the parent node not empty
    while ~isempty(node.parent)
        node = node.parent;
        % generate the sequence action by 1 action backwards
        sequence{i,1} = node.action;
        i = i + 1;
    end
    % flip the action sequence upside down
    sequence = flipud(sequence);
end