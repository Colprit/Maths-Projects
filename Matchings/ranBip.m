function[G] = ranBip(n,p)
    % generate random nxn bipartite graph
    g = rand(n)<p;
    G = [zeros(n) g;
         g' zeros(n)];
end


