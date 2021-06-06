from data import proteins, s

# strings
S = proteins["C"]
T = proteins["D"]
m = len(S)
n = len(T)

# initialise score matrix for v_sfx
V = [[0 for j in range(n + 1)] for i in range(m + 1)]

# scoring function s imported from data
sI = -2  # Insert
sD = -2  # Delete

# boundary conditions
for i in range(m+1):
    V[i][0] = i*sD
for j in range(n+1):
    V[0][j] = j*sI

# determine score matrix V_sfx
for i in range(1, m+1):
    for j in range(1, n+1):
        aa1 = S[i-1]  # amino acids
        aa2 = T[j-1]
        opt = [0,
               V[i-1][j-1] + s(aa1, aa2),
               V[i-1][j] + sD,
               V[i][j-1] + sI]
        V[i][j] = max(opt)

# convert V_sfx to a list to then take the maximum
allV = [w for v in V for w in v]
Vsub = max(allV)

# output
print("v_sub = ", Vsub)