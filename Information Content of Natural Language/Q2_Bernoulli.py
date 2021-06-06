from Q1_Huffman import huffman

# to consider the case with spaces: comment out lines 8 and 12

file = open("II-19-2-dataC.txt", "r")
data = file.read().replace("\n", " ").split(" ")
text = [int(m) for m in data if m]
text = [t for t in text if t != 0]
text.pop()   # remove terminating -1

alph = [i for i in range(27)]
alph = [i for i in range(1,27)]

# estimate letter probabilities
L = len(text)
letter_probs = {letter: text.count(letter) / L for letter in alph}

# compute the set of messages
seg = 2
msgs = [(a,) for a in alph]
for i in range(seg-1):
    msgs = [m + (a,) for m in msgs for a in alph]

msg_probs = {}
for msg in msgs:
    msg_prob = 1
    for p in [letter_probs[m] for m in msg]:
        msg_prob *= p
    msg_probs[msg] = msg_prob

# apply huffman function to calculate code
probs = list(msg_probs.items())
codebook = huffman(probs)

# expected codeword length
exp_len = sum([msg_probs[c[0]] * len(c[1]) for c in codebook])

# output
print("Huffman Code:")
alphabet = ['_', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
                 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
for code in sorted(codebook, key=lambda x: msg_probs[x[0]], reverse=True)[0:15]:
    msg = ''.join([alphabet[m] for m in code[0]])
    print(msg, ":", code[1])
print("length of codebook: ", len(codebook))
print("expected length per block:  {:.4}".format(exp_len))
print("expected length per letter: {:.4}".format(exp_len/seg))
