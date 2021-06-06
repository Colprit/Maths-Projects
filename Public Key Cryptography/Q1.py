
def prime(n):
    i = 2
    while i**2 <= n:
        if n%i == 0:
            return False
        i += 1
    return True


n = int(input("Enter an integer: "))
if prime(n):
    print(n,"is prime")
else:
    print(n,"is not prime")
