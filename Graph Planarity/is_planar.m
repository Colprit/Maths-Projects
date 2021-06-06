function[planar] = is_planar(edgList)
    % an implementation of the algorithm from Question 8
    Core = find_core(edgList);
    if isempty(Core)
        planar = true;
        return
    else
        [cycle, chord] = find_cycle_with_chord(Core);
        bridges = find_bridges(Core, cycle);
        H = find_interleave(cycle, bridges);
        if ~is_bipartite(H)
            planar = false;
            return
        end
        planar = is_planar(remove_edges(Core, chord));
    end
end