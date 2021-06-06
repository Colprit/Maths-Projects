from data import proteins, opsKey

# strings
S = proteins["A"]
T = proteins["B"]
m = len(S)
n = len(T)

# initialise distance matrix D
D = [[0 for j in range(n+1)] for i in range(m+1)]
# initialise matrix to record operations
Q = [[0 for j in range(n+1)] for i in range(m+1)]

# boundary conditions
for i in range(m+1):
    D[i][0] = i
    Q[i][0] = "D"  # delete
for j in range(n+1):
    D[0][j] = j
    Q[0][j] = "I"  # insert
Q[0][0] = "M"

# score function
s = lambda i,j: S[i-1] != T[j-1]


# function
#   input: operations matrix
#   output: editing transcript
def edit_script(Q):
    from data import ops
    script = ""
    p = [len(Q)-1,
         len(Q[0])-1]  # pointer
    while p != [0,0]:
        step = Q[p[0]][p[1]]
        script = step + script
        for op in step:
            p = [p[0] - ops[op][0],
                 p[1] - ops[op][1]]  # update pointer
    return script

# function
#   input: 2 strings, editing transcript
#   output: vertical alignment
def align(script, S, T):
    from data import ops
    S_ = ""
    T_ = ""
    SS = S  # temp copies of S & T
    TT = T
    for op in script:
        inc_S, inc_T = ops[op]  # include S,T
        S_ += SS[0] if inc_S else " "
        SS = SS[inc_S:]
        T_ += TT[0] if inc_T else " "
        TT = TT[inc_T:]
    return S_, T_


# determine distance matrix D and operations matrix Q
for i in range(1, m+1):
    for j in range(1, n+1):
        opt = [D[i-1][ j ]+1,       # delete
               D[ i ][j-1]+1,       # insert
               D[i-1][j-1]+s(i,j)]  # match or replace
        D[i][j] = min(opt)

        op = opt.index(min(opt))
        if op == 2:
            op += s(i,j)
        Q[i][j] = opsKey[op]

# determine editing transcript and vertical alignment from operations matrix Q
script = edit_script(Q)
S_, T_ = align(script, S, T)


# output
print("edit distance: ", D[m][n])
steps = 50
print(script[:steps])
print(S_[:steps])
print(T_[:steps])