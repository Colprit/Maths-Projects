A = [0,1,0,0;
     1,0,0,0;
     1,0,0,1;
     0,0,0,0];
max_iter = 1000;

N = size(A,1);
pi = ones(N,1)/N;
d = 0.85;

w = PageRank(A,pi,d,max_iter)

% compare results to question 2
p = (w/N)'