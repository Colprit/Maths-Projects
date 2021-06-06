function[M] = adjList_to_adjMat(adjList)
    % iterate though the adjacencies in the list
    % adding appropriately to an adjacency matrix
    L = length(adjList);
    M = zeros(L);
    for i = 1:L
        for j = 1:length(adjList{i})
            M(i, adjList{i}(j)) = 1;
        end
    end
end