function [ edgList ] = remove_edges( input_edgList, edges )
    edgList = input_edgList;
    for i = 1:size(edges,1)
        edge = edges(i,:);
        remove = [edge; flip(edge)];
        edgList = setdiff(edgList, remove, 'rows');
    end
end

