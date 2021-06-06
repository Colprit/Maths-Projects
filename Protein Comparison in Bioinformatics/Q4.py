from data import proteins, s, opsKey
from Q3 import edit_script, align

# strings
S = proteins["A"]
T = proteins["B"]
m = len(S)
n = len(T)

# initialise score matrix V, and operations matrix Q
V = [[0 for j in range(n + 1)] for i in range(m + 1)]
Q = [[0 for j in range(n+1)] for i in range(m+1)]

# scoring function s imported from data
sI = -8  # Insert
sD = -8  # Delete

# boundary conditions
for i in range(m+1):
    V[i][0] = i*sD
    Q[i][0] = "D"  # delete
for j in range(n+1):
    V[0][j] = j*sI
    Q[0][j] = "I"  # insert
Q[0][0] = 0

# determine score matrix V and operations matrix Q
for i in range(1, m+1):
    for j in range(1, n+1):
        aa1 = S[i-1]  # amino acids
        aa2 = T[j-1]
        opt = [V[i - 1][ j] + sD,
               V[ i][j - 1] + sI,
               V[i - 1][j - 1] + s(aa1, aa2)]  # replace
        V[i][j] = max(opt)

        op = opt.index(max(opt))
        if op == 2:
            op += aa1!=aa2
        Q[i][j] = opsKey[op]

# determine editing transcript and vertical alignment from operations matrix Q
script = edit_script(Q)
S_, T_ = align(script, S, T)

# output
print("score: ", V[m][n])
steps = 50
print(script[:steps])
print(S_[:steps])
print(T_[:steps])