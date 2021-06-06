def v_gap(S, T, s, u):
    from Q3 import edit_script, align

    m = len(S)
    n = len(T)

    # initialise matrices
    #   V - score
    #   Q - operations
    #   E,F,G - assistant matrices for computing V
    V = [[0 for j in range(n + 1)] for i in range(m + 1)]
    E = [[-100 for j in range(n + 1)] for i in range(m + 1)]
    F = [[-100 for j in range(n + 1)] for i in range(m + 1)]
    G = [[-100 for j in range(n + 1)] for i in range(m + 1)]
    Q = [["" for j in range(n + 1)] for i in range(m + 1)]
    QE = [["" for j in range(n + 1)] for i in range(m + 1)]
    QF = [["" for j in range(n + 1)] for i in range(m + 1)]
    QG = [["" for j in range(n + 1)] for i in range(m + 1)]

    # func to assist in computing V,E,F,G
    def v(i, j):
        opt = [[E[i][j], QE[i][j]],
               [F[i][j], QF[i][j]],
               [G[i][j], QG[i][j]]]
        opt.sort(reverse=True)
        return opt[0]

    def e(i, j):
        opt = [E[i][j - 1], V[i][j - 1] + w(1)]
        op = "I"
        if opt.index(max(opt)) == 0:
            op += QE[i][j - 1]
        return max(opt), op

    def f(i, j):
        opt = [F[i - 1][j], V[i - 1][j] + w(1)]
        op = "D"
        if opt.index(max(opt)) == 0:
            op += QF[i - 1][j]
        return max(opt), op

    def g(i, j):
        op = "M" if S[i - 1] == T[j - 1] else "R"
        return V[i - 1][j - 1] + s(S[i - 1], T[j - 1]), op

    # scoring
    #   s accepted as parameter
    #   func w(l) returns score for deleting/inserting sequence length l
    def w(l):
        return u if l else 0

    # boundary conditions
    for i in range(1, m + 1):
        V[i][0] = w(i)
        E[i][1], QE[i][1] = e(i, 1)
        F[i][0], QF[i][0] = f(i, 0)
        G[i][1], QG[i][1] = g(i, 1)
        Q[i][0] = "D"

    for j in range(1, n + 1):
        V[0][j] = w(j)
        E[0][j], QE[0][j] = e(0, j)
        F[1][j], QF[1][j] = f(1, j)
        G[1][j], QG[1][j] = g(1, j)
        Q[0][j] = "I"

    V[0][0] = 0
    E[0][1] = w(1)
    F[1][0] = w(1)
    Q[0][0] = ""

    # main algorithm to compute V
    for i in range(1, m + 1):
        for j in range(1, n + 1):

            V[i][j], Q[i][j] = v(i, j)

            if j + 1 <= n:
                E[i][j + 1], QE[i][j + 1] = e(i, j + 1)
            if i + 1 <= m:
                F[i + 1][j], QF[i + 1][j] = f(i + 1, j)
            if i + 1 <= m and j + 1 <= n:
                G[i + 1][j + 1], QG[i + 1][j + 1] = g(i + 1, j + 1)

    # determine editing transcript and vertical alignment from operations matrix Q
    script = edit_script(Q)
    S_, T_ = align(script, S, T)

    return V[m][n], [script, S_, T_]