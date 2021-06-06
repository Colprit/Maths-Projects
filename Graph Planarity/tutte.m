function[] = tutte(edgList, cycle)
    % relabel graph s.t. cycle is 1 to k
    k = length(cycle);
    n = max(max(edgList));
    map = [cycle, setdiff(1:n, cycle)];
    edgList_ = 0*edgList;
    for i = 1:n
        edgList_ = edgList_ + i*(edgList==map(i));
    end
    edgList = edgList_;
    adjList = edgList_to_adjList(edgList);
    adjMat = adjList_to_adjMat(adjList);

    % list of positions of vertices
    pos = zeros(n,1);

    % determine position of regular k-gon
    i = complex(0,1);
    w = exp(2*pi*i/k);
    for i = 1:k
        pos(i) = w^(i-1);
    end

    % solve linear equations: Ax = b
    % to find positions of other points
    B = adjMat(k+1:end,1:k);
    b = B*pos(1:k);

    A_ = adjMat(k+1:end,k+1:end);
    d = adjMat*ones(n,1);
    D = diag(d(k+1:end));
    A = D - A_;

    x = A\b;
    pos = [pos(1:k);x];

    % plot graph
    axis equal
    hold on
    for i = 1:length(edgList)
        plot(pos(edgList(i,:)), 'Marker', 'o', 'Color', 'b');
    end
    hold off
end