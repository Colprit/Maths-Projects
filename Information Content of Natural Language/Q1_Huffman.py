# convert source text into convenient format
file = open("II-19-2-dataC.txt", "r")
data = file.read().replace("\n", " ").split(" ")
text = [int(m) for m in data if m]
text.pop()   # remove terminating -1

# estimate message probabilities
alph = list(set(text))
L = len(text)
msg_probs = {m: text.count(m) / L for m in alph}

def huffman(probs):
    # input: alphabet of messages and corresponding probabilities
    # output: the Huffman code
    def collapse(probs):
        # collapse list of probabilities by repeatedly
        # pairing up messages (or groups of messages)
        if len(probs) == 1:
            return probs
        else:
            sort = sorted(probs, key=lambda p: p[1])
            new_m = [sort[0][0] , sort[1][0]]
            new_p =  sort[0][1] + sort[1][1]
            new_probs = [[new_m, new_p]] + sort[2:]
            return collapse(new_probs)

    def unpack(codes):
        # unpack collapsed probabilities
        # record codewords in the process
        new_codes = []
        fully_decoded = True
        for c in codes:
            if isinstance(c[0], list):
                c0 = [c[0][1], c[1]+"0"]
                c1 = [c[0][0], c[1]+"1"]
                new_codes += [c0, c1]
                fully_decoded = False
            else:
                new_codes.append(c)
        return new_codes if fully_decoded else unpack(new_codes)

    return unpack([[collapse(probs)[0][0], ""]])

# apply huffman function to calculate code
probs = list(msg_probs.items())
codebook = huffman(probs)

# expected codeword length
exp_len = sum([msg_probs[c[0]] * len(c[1]) for c in codebook])

# output
print("Huffman Code:")
alphabet = ['_', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
                 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
for c in sorted(codebook):
    print("%2d - %s - %s" % (c[0], alphabet[c[0]], c[1]))
print("expected codeword length: ", exp_len)