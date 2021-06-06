from Q5 import v_gap
from random import random


# generate (a,b)-protein
def gen_pro(n, p):
    # alphabet of 'a' and 'b' represented by 0 and 1 respectively
    pro = [random() > p for i in range(n)]
    pro = [str(int(p)) for p in pro]
    return "".join(pro)


def s(a,b):
    return 1 if a == b else -1


# fix value of n for estimate
n = 100
p = 0.5
u = -3

# sample size
N = 5
samples = [v_gap(gen_pro(n, p), gen_pro(n, p), s, u)[0]/n for i in range(N)]
estimate = sum(samples) / N
print(estimate)