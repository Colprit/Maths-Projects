# collect string input
S = input("Enter a string: ")
T = input("Enter a string: ")
m = len(S)
n = len(T)

# initialise distance matrix D
D = [[0 for j in range(n+1)] for i in range(m+1)]
# boundary conditions
for i in range(m+1):
    D[i][0] = i
for j in range(n+1):
    D[0][j] = j

# score function
s = lambda i,j: S[i-1] != T[j-1]

for i in range(1, m+1):
    for j in range(1, n+1):
        opt = [D[i-1][ j ]+1,       # delete
               D[ i ][j-1]+1,       # insert
               D[i-1][j-1]+s(i,j)]  # match or replace
        D[i][j] = min(opt)

# output
print("edit distance: ", D[m][n])