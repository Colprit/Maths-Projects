function[cycle] = find_cycle_with_bridge(edgList, route, visited)
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
    old = intersect(nbhd, route(1:end-2)); % -2 to exclude current and parent
    if ~isempty(old)
        % we've found cycle(s)
        % test whether each cycle has one bridge
        % if only one bridge is found return corresponding cycle
        for i = 1:length(old)
            cycle = route(find(route==old(i)):end);
            bridges = find_bridges(edgList, cycle);
            if size(bridges,1) == 1
                % formed a cycle with exactly one bridge
                % now pass it back up the recursion
                return;
            end
        end
    end
    % none of the cycles we can make have chords
    % check if there are any new vertices to visit
    if ~isempty(new)
        % try visiting each unvisited vertex in turn
        for i = 1:length(new)
            cycle = find_cycle_with_bridge(edgList, [route,new(i)], visited);
            if ~isempty(cycle)
                % pass results up the recursion
                return;
            end
        end
    end
    % failed to form a cycle with chord
    % AND none of the univisited vertices lead to cycles with chords
    % so return empty cycle and chord to signify failure
    cycle = [];
end