N = 1000;
k = 100;

[rank, A, pi, d] = RandWebRank(N,k);

% S : modified transition matrix
S = S_from_A_mod(A,pi,d);
% V : matrix of eigenvectors
% D : a diagonal matrix of eigenvalues
[V,D] = eig(S);

% check results
eigVec = V(:,1);    % select eigenvector with eigenvalue 1
eigVec = eigVec * N/sum(eigVec);
compare = [rank, eigVec]

function[S] = S_from_A_mod(A,pi,d)
    N = size(A,1);
    S = zeros(N);
    for j = 1:N
        colTotal = sum(A(:,j));
        if colTotal ~= 0
            S(:,j) = d*A(:,j)/colTotal + (1-d)*pi;
        else
            S(:,j) = pi;
        end
    end
end
 