function[comp] = find_comp(adjList,v)
    % starting at vertex v searching for connected points
    % search until no more new neighbours can be found
    comp = [];
    while true
        comp_ = comp;
        comp = unique([adjList{comp},v]);
        if isequal(comp, comp_)
            break;
        end
    end
end