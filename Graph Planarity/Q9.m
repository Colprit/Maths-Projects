% generate 20 maximal planar graphs with 40 vertices each
N = 3;
n = 50;

graphs = cell(N,2);
for i = 1:N
    [G, before_violation] = max_planar(n);
    graphs(i,:) = {G, before_violation};
end

% output
graphs
averageEdgesBeforeViolation = sum(cell2mat(graphs(:,2)))/N