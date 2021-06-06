function [ rank, A, pi, d ] = RandWebRank( N, k )

    A = gen_adj(N,k);
    pi = ones(N,1)/N;
    d = 0.85;

    rank = PageRank(A,pi,d,5);

    function[A] = gen_adj(N,k)
        A = zeros(N);
        out_degs = arrayfun(@(x) poisson(k), 1:N);
        for n1 = 1:N
            for deg = 1:out_degs(n1)
                n2 = randi(N);
                while n2 == n1
                    n2 = randi(N);
                end
                A(n2,n1) = A(n2,n1) + 1;
            end
        end

        function[n] = poisson(lambda)
            x = rand();
            p = exp(-lambda);
            n = 0;
            while p < x
                n = n + 1;
                p = p + exp(-lambda)*lambda^n/factorial(n);
            end
        end
    end
end

