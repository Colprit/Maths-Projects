
def mod(m, e, n):
    c = 1
    for i in range(e):
        c = (c*m) % n
    return c


# public and private keys
n = 937513
e = 638471
d = 229703 # calculated with decrypt function from Q7.py

# number
m = 54321

# encrypt
# NOTE: a more concise but slower method would be
#       c = m**e % n
c = mod(m,e,n)

# decrypt
# NOTE: a more concise but slower method would be
#       M = c**d % n
M = mod(c,d,n)

print(m,M)