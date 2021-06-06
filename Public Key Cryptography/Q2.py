

def fact(n, start=2):
    i = start
    while i**2 <= n:
        if n % i == 0:
            return [i] + fact(n/i, i)
        if i == 2:
            i += 1
        else:
            i += 2
    return [int(n)]


n = int(input("Enter number to be factorised: "))
print(n, "has the factors", fact(n))
