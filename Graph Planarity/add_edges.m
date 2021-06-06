function [ edgList ] = add_edges( input_edgList, edges )
    edgList = input_edgList;
    for i = 1:size(edges,1)
        edge = edges(i,:);
        if ~any(ismember([edge;flip(edge)], edgList, 'rows'))
            edgList = [edgList; edge];
        end
    end
end

