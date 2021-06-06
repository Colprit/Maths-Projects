
def euclid(a,b):
    a, b = max(a,b), min(a,b)

    # the quotients (the zero added to align quotients and remainders
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

    print("hcf(%d, %d) = %d" % (a, b, d))
    print("%d x %d + %d x %d = %d \n" % (a, u, b, v, d))
    print("%12d     %12d     %5d      %")


euclid(  1996245783,    192784863)
euclid(  2825746811,    758295345)
euclid(249508543104, 338063357376)
euclid(249508543140, 338063357367)