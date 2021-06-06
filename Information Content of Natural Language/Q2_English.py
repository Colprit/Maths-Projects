from Q1_Huffman import huffman

# to consider the case with spaces: comment out line 8

file = open("II-19-2-dataC.txt", "r")
data = file.read().replace("\n", " ").split(" ")
text = [int(m) for m in data if m]
text = [t for t in text if t != 0]
text.pop()   # remove terminating -1

# sample all segments from the text to compute the set of messages
seg = 2
seg_text = [tuple(text[i:i+seg]) for i in range(len(text)-seg+1)]
msgs = list(set(seg_text))

# process source text to estimate message probabilities
L = len(text)
msg_probs = {m: seg_text.count(m) / L for m in msgs}

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
