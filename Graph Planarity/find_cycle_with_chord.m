function[cycle, chord] = find_cycle_with_chord(edgList, route, visited)
    % default values such that the function can be originally called
    % without the route and visited arguments
    if nargin==1
        route = edgList(1,1);
        visited = [];
    end
    
    adjList = edgList_to_adjList(edgList);
    visited = [visited, route(end)];
    nbhd = adjList{route(end)};
    new = setdiff(nbhd, visited);
    % if possible move to an univisted vertex
    if any(new)
        [cycle, chord] = find_cycle_with_chord(edgList, [route,new(1)], visited);
    % else there are no unvisited neighbours and so
    % a cycle with chord can definitely be formed
    else
        old = setdiff(nbhd, [new, visited(end-1)]);
        pos1 = find(visited==old(1),1);
        pos2 = find(visited==old(2),1);
        if pos1 < pos2
            cycle = visited(pos1:end);
            chord = [old(2), visited(end)];
        else
            cycle = visited(pos2:end);
            chord = [old(1), visited(end)];
        end
    end
end