function[edgList] = find_core(input_edgList)
    edgList = input_edgList;
    n = max(max(edgList));
    while true
        adjList = edgList_to_adjList(edgList);
        degs = sum(reshape(edgList,[],1)==1:n);
        % check for degree 1 vertices
        % if present, choose one and remove it
        deg1 = degs==1;
        if any(deg1)
            u = find(deg1,1);
            v = adjList{u};
            edgList = remove_edges(edgList, [u,v]);
        else
            % check for degree 2 vertices
            % if present, choose one and remove it
            deg2 = degs==2;
            if any(deg2)
                u = find(deg2,1);
                nbhd = adjList{u};
                edgList = remove_edges(edgList, [u, nbhd(1); u, nbhd(2)]);
                edgList = add_edges(edgList, nbhd);
            else
                % no degree 1 or 2 vertices present
                % therefore core found
                break;
            end
        end
    end
end

