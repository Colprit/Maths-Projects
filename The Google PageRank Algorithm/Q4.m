A = input('Enter adjacency matrix: ');
max_iter = input('Enter max number of iterations: ');

N = size(A,1);
pi = ones(N,1)/N;
d = 0.85;

PageRank(A,pi,d,max_iter)