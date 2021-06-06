file = open("II-19-2-dataC.txt", "r")
data = file.read().replace("\n", " ").split(" ")
text = [int(m) for m in data if m]
text.pop()   # remove terminating -1

# process source text to estimate message probabilities
alph = list(set(text))
probs = [[m, text.count(m)/len(text)] for m in alph]

def shannon(probs):
    # input: list of messages and corresponding probabilities
    # output: a Shannon-Fano coding and expected code length

    from math import log, ceil

    # calculate list of alphabet values and their codeword lengths
    lengths = [[p[0], ceil(-log(p[1], 2))] for p in probs]

    # expected codeword length
    exp_len = sum([lengths[m][1] * probs[m][1] for m in range(len(probs))])

    # sort alphabet by codeword lengths
    lengths = sorted(lengths, key=lambda x: x[1])

    # input: i in decimal
    # output: reversed string of i in binary with preceding 0's to length l
    b = lambda i, l: format(i, '0'+str(l)+'b')[::-1]

    def prefix_free(new, words):
        # check whether adding new to words preserves prefix-free
        # (note: assumes new is longer than any word in words)
        for w in words:
            if w[1] in new and new.index(w[1]) == 0:
                return False
        return True

    codebook = []
    i = 0
    for length in lengths:
        L = length[1]
        while not prefix_free(b(i,L), codebook):
            i += 1
        codebook.append([length[0], b(i, L)])

    return codebook, exp_len

# apply shannon function to calculate codebook and expected codeword length
codebook, exp_len = shannon(probs)

# output
print("Shannon-Fano Code:")
alphabet = ['_', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
                 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
for c in sorted(codebook):
    print("%2d - %s - %s" % (c[0], alphabet[c[0]], c[1]))
print("expected codeword length: ", exp_len)