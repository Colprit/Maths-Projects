function[adjList] = edgList_to_adjList(edgList)
    % iterate through every edge in the list
    % adding appropriately to an adjacency list
    n = max(max(edgList));
    adjList = cell(n,1);
    for i = 1:size(edgList,1)
        v1 = edgList(i,1);
        v2 = edgList(i,2);
        adjList{v1} = [adjList{v1}, v2];
        adjList{v2} = [adjList{v2}, v1];
    end
end