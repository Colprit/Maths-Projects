function[found_1factor, factor_or_block] = find_1factor(G)

    % check for any isolated vertices
    isolated = find(~any(G),1);
    if isolated
        found_1factor = false;
        factor_or_block = isolated;
        return
    end
    
    n = size(G,1);
    matching = [1, find(G(1,:),1)];
    block = [];
    while true
        matchMat = edgeList2adjMat(matching, n);
        
        unused = find(~any(matchMat));
        if isempty(unused)
            break;
        end
        
        u = unused(1);
        [V, record] = findReachable(G, matchMat, u);
        % W is vertices reachable from u and not in the matching
        W = setdiff(V, matching(:));
        if isempty(W)
            % blocking set found
            block = [u, find(any(matchMat(V,:)))];
            break;
        else
            % extend matching
            v = W(1);
            path = findAltPath(matchMat, record, u, v);
            path = sort(path,2);
            matching = [setdiff(matching,path,'rows');
                         setdiff(path,matching,'rows')];
        end
    end
    
    % process output
    if isempty(block)
        found_1factor = true;
        factor_or_block = matching;
    else
        found_1factor = false;
        factor_or_block = block;
    end
end