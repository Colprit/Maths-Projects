
# adapted fact func
# assumes n is the product of two primes
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

# adapted solver func from Q5.py without print statements
def solver(a,b,m):
    d,u,v = euclid(a,m)
    if b % d == 0:
        return v*b/d % (m/d)
    else:
        return False

def decrypt(n,e):
    [p,q] = fact(n)
    tot_n = (p-1)*(q-1)
    d = solver(e,1,tot_n)

    print("Public Key:  (%d, %d)"    % (n,e))
    print("Private Key: (%d, %d) \n" % (n,d))
    return n,d


decrypt(   1764053131,       103471)
decrypt(   1805760301,     39871477)
decrypt(9976901028181, 837856358917)
decrypt(   1723466867,    692581937)
decrypt(6734071952813,         2017)
decrypt(   1603982333,       927145)
