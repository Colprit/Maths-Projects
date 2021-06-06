function [ tri ] = find_triangle( edgList )
    adjList = edgList_to_adjList(edgList);
    % start at 1, find a neighbour u, to form a trianlge
    % choose a vertex common to both their neighbourhoods
    nbhd_1 = adjList{1};
    nbhd_u = adjList{nbhd_1(1)};
    nbhd_both = intersect(nbhd_1, nbhd_u);
    tri = [1,nbhd_1(1),nbhd_both(1)];
end

