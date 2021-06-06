from math import log

# process source text into convenient format
file = open("II-19-2-dataC.txt", "r")
data = file.read().replace("\n", " ").split(" ")
text = [int(m) for m in data if m]
text.pop()   # remove terminating -1

# calculate entropy
alph = [i for i in range(27)]
L = len(text)
probs = [text.count(m)/L for m in alph]
entropy = -sum([p*log(p,2) if p else 0 for p in probs])

# output
print("entropy: ", entropy)