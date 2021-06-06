function[bipartite] = is_bipartite(edgList)
    if isempty(edgList)
        bipartite = true;
        return;
    end
    % colours vertices into two sets until either a contradiction arises
    % or the vertex set is fully partitioned
    adjList = edgList_to_adjList(edgList);
    n = length(adjList);
    col = 1;
    V = n;
    classes = {V,[]};
    while true
        nbhd = [adjList{V}];
        if ~isempty(nbhd)
            V = unique(nbhd);
            % check if any of neighbouring vertices match the colour of the
            % current vertices which violates the bipartite property
            if ~isempty(intersect(V, classes{col}))
                bipartite = false;
                return;
            end
        end

        % check if all vertices have been coloured
        coloured = union(classes{1:2});
        if isequal(reshape(coloured, 1,[]), 1:n)
            bipartite = true;
            return;
        % check if we have fully coloured a component of the graph
        % but not all the graph and so need to move to another component
        elseif all(ismember(V, coloured))
            V = setdiff(1:n, coloured);
            V = V(1);
        end
        col = mod(col,2)+1;
        classes{col} = union(classes{col}, V);
    end
end

