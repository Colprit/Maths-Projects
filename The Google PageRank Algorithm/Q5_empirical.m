N = 1000;
K = [5,10,25,50,100];
for i = 1:length(K)
    k = K(i);
    rank = RandWebRank(N,k);

    % empirical distribution
    L = length(rank);
    X = sort(rank);
    Y = (1:L)/L;
    plot(X, Y);
    hold on
end
hold off