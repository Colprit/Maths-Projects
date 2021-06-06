# func: collapse list of probabilities
def collapse(probs):
    if len(probs) == 1:
        return probs
    else:
        sort = sorted(probs, key = lambda p: p[1])
        newM = [sort[0][0] , sort[1][0]]
        newP =  sort[0][1] + sort[1][1]
        newProbs = [[newM, newP]] + sort[2:]
        return collapse(newProbs)