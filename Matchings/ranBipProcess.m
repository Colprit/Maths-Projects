function[process] = ranBipProcess(n)
    % generate bipartite graph process
    process = zeros(2*n,2*n,n*n);
    G = zeros(2*n);
    for i=1:n*n
        G = addEdge(G);
        process(:,:,i) = G;
    end
    
    function[H] = addEdge(G)
        H = G;
        % calculate size of bipartite graph
        % assumes n x n bipartite (evenly sized classes)
        n = length(G)/2;
        % complete bipartite graph
        compBip = [zeros(n) ones(n);
                    ones(n) zeros(n)];
        if (isequal(G,compBip))
            return;
        end
        x = randi(n);
        y = randi(n);
        while H(x,n+y) ~= 0
            x = randi(n);
            y = randi(n);
        end
        H(x,n+y) = 1;
        H(n+y,x) = 1;
    end
end