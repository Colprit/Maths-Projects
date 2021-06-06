function [ w ] = PageRank( A, pi, d, max_iter )

    N = size(A,1);
    S = S_from_A_mod(A, pi, d);
    w = ones(N,1);
    for i = 1:max_iter
        w = S*w;
    end

    function[S] = S_from_A_mod(A,pi,d)
        S = zeros(size(A,1));
        for j = 1:size(A,1)
            totalOut = sum(A(:,j));
            if totalOut ~= 0
                S(:,j) = d*A(:,j)/totalOut + (1-d)*pi;
            else
                S(:,j) = pi;
            end
        end
    end

end

