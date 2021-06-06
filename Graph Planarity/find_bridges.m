function[bridges] = find_bridges(edgList,cycle)
    % make adjusted adjacency list so as to be able to manipulate
    % find_comp.m to find bridge components more easily
    adjList = edgList_to_adjList(edgList);
    adjList_ = adjList;
    for c = 1:length(cycle)
        adjList_{cycle(c)} = [];
    end

    % convert the cycle to an edgList for future use
    n = length(cycle);
    edgList_cycle = zeros(2*n,2);
    for i = 1:length(cycle)
        if (i-1 >= 1)
            e1 = i-1;
        else
            e1 = n;
        end
        if (i+1 <= n)
            e2 = i+1;
        else
            e2 = 1;
        end
        edgList_cycle(2*i-1:2*i,:) = [cycle([i, e1]); cycle([i, e2])];
    end

    % find chords by comparing the graph edge list with the
    % edge list of the cycle
    chords = edgList(~ismember(edgList, edgList_cycle, 'rows'),:);
    chords = chords(all(ismember(chords, cycle),2),:);

    % find non-chord bridges as sets of vertices
    % by finding components outside the cycle, that is bridges, one by one
    comps = {};
    v_left = 1:max(max(edgList));
    v_left = setdiff(v_left, cycle);
    while isempty(v_left) == false
        comp = find_comp(adjList_,min(v_left));
        if length(comp) > 1
            comps{length(comps)+1} = comp;
        end
        v_left = setdiff(v_left,comp);
    end
    
    % restructure the data found so far into the format of each bridge as
    % an edge list and a list of anchor points
    bridges = cell(size(chords,1)+length(comps),2);
    for i = 1:size(chords,1)
        bridges{i,1} = chords(i,:);
        bridges{i,2} = chords(i,:)';
    end
    edges_avoid = [edgList_cycle; chords];
    for i = 1:length(comps)
        comp_edges = edgList(all(ismember(edgList, comps{i}),2),:);
        if ~isempty(comp_edges)
            bridges{size(chords,1)+i,1} = setdiff(comp_edges, edges_avoid, 'rows');
        else
            bridges{size(chords,1)+i,1} = [];
        end
        bridges{size(chords,1)+i,2} = intersect(comps{i}, cycle);
    end
end
