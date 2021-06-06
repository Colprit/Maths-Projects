from data import proteins, s
from Q5 import v_gap

# strings
S = proteins["A"]
T = proteins["B"]

[score, edit_script] = v_gap(S, T, s, -12)

# output
print("gap-weighted score: ", score)
steps = 50
print(edit_script[0][:steps])
print(edit_script[1][:steps])
print(edit_script[2][:steps])
