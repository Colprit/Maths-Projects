function[V, record] = findReachable(G,M,u)
    V = find(G(u,:) & ~M(u,:));
    V_ = V;
    % record stores for each vertex the vertex that lead to its addition
    % (note: 0 indicates the vertex is not in V)
    record = zeros(size(G,1),1);
    record(V) = u;
    while true
        V = V_;
        for i = 1:length(V)
            v = V(i);
            w = find(M(v,:),1);
            W = find(G(w,:));
            record(setdiff(W,V_)) = v;
            V_ = union(V_,W);
        end
        if isequal(V_,V)
            break;
        end
    end
end

