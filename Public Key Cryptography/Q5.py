
# adapted euclid func from Q3.py without print statements
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
    print("%dx ≡ %d (mod %d)" % (a,b,m))
    d,u,v = euclid(a,m)
    if b % d == 0:
        print("=> x = %d (mod %d) \n" % (v*b/d % (m/d), m/d))
    else:
        print("=> no solution \n",
               "  because hcf(%d,%d) does not divide %d \n" % (a,b,m))


solver(146295, 2017, 313567)
solver( 93174, 2015, 267975)
solver(113314, 2014, 660115)