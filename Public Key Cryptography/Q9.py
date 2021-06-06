
# functions fact, euclid and solver have been taken from Q7.py
def fact(n):
    if n % 2 == 0:
        return n/2, 2
    i = 3
    while i**2 <= n:
        if n % i == 0:
            return n/i, i
        i += 2

def euclid(a,b):
    a, b = max(a, b), min(a, b)

    # the quotients (the zero added to align quotients and remainders)
    q = [0, a//b]
    # b and the remainders
    r = [b, a-q[1]*b]
    while r[-1] != 0:
        q += [r[-2] // r[-1]]
        r += [r[-2] - q[-1] * r[-1]]
    d = r[-2]

    u = 1
    v = -q[-2]
    for i in range(3,len(r)):
        u, v = v, u-v*q[-i]
    return d, u, v

def solver(a,b,m):
    d,u,v = euclid(a,m)
    if b % d == 0:
        return v*b/d % (m/d)
    else:
        return False

# function mod taken from Q8.py
def mod(m, e, n):
    c = 1
    for i in range(e):
        c = (c*m) % n
    return c

# adaption of decrypt from Q7.py without the print statements
def decrypt(n,e):
    [p,q] = fact(n)
    tot_n = (p-1)*(q-1)
    d = solver(e,1,tot_n)
    return int(d)


lib = [' ','a','b','c','d','e','f','g','h','i','j','k','l','m','n',
       'o','p','q','r','s','t','u','v','w','x','y','z','.',':',"'"]

encrypted = [179232,  6825,263565,126615,474921,750809,900050,  9287,
             554344,413204,757176, 66356,716784,382286,696566,610518,
             510930,459403,922484,390971,773831,655925,633419,519880]

n = 937513
e = 638471
d = decrypt(n,e)

decrypted = [mod(c,d,n) for c in encrypted]
code = ["0"*(6-len(i))+i for i in (str(j) for j in decrypted)]
code = "".join(code)

msg = ""
while code != "":
    x, code = code[:2], code[2:]
    msg += lib[int(x)]

print(msg)
