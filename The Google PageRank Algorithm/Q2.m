A = [0,1,0,0;
     1,0,0,0;
     1,0,0,1;
     0,0,0,0];
N = size(A,1);
pi = ones(N,1)/N;
d = 1;

S = S_from_A(A);

% generate sample of random paths
n_paths = 100;
T = 250;
sample = zeros(n_paths,T);
for x = 1:n_paths
    sample(x,:) = gen_path(A,pi,d,T);
end

% compute the 3D matrix of mu_jt^(k)
M = zeros(n_paths,N,T);
for j = 1:n_paths
    for k = 1:N
        for t = 1:T
            M(j,k,t) = mu(sample(j,:),k,t);
        end
    end
end

% chose a fixed path
fix_j = 1;
fix_path = sample(fix_j,:);
fix_path_mu = mean(M(fix_j,:,T),1)
% plot mu for fixed path j
figure(1);
for k = 1:N
    plot(squeeze(M(fix_j,k,:)))
    hold on
end
hold off

% compute variance
V = zeros(N,T);
for k = 1:N
    for t = 1:T
        V(k,t) = var(M(:,k,t));
    end
end
% plot variance
figure(2);
plot(V')

function[m] = mu(path,k,t)
    m = sum(path(1:t)==k)/t;
end

function[path] = gen_path(A,pi,d,T)
    % generate a path of length T by iterating the surf function
    path = zeros(T,1);
    path(1) = surf(A,pi,d,0);
    for t = 2:T
        path(t) = surf(A,pi,d,path(t-1));
    end
end

function[new_pg] = surf(A,pi,d,pg)
    % Follow the Random Surfer procedure
    S = S_from_A(A);
    if pg == 0 || sum(A(:,pg)) == 0 || rand() > d
        new_pg = rand_pg(pi);
    else
        new_pg = rand_pg(S(:,pg));
    end
end

function[pg] = rand_pg(pi)
    % choose a random page
    x = rand();
    y = 0;
    pg = 0;
    while x > y
        pg = pg + 1;
        y = y + pi(pg)/sum(pi);
    end        
end

function[S] = S_from_A(A)
    % compute the transition matrix S of A
    d = size(A,1);
    S = zeros(d);
    for j = 1:d
        colTotal = sum(A(:,j));
        if colTotal == 0
            colTotal = 1;
        end
        for i = 1:d
            S(i,j) = A(i,j)/colTotal;
        end
    end
end
 