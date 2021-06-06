# operations
opsKey = "D", "I", "M", "R"
ops = {"D": [1,0],  # delete
       "I": [0,1],  # insert
       "M": [1,1],  # match
       "R": [1,1]}  # replace


# process Proteins
filePro = open("II-9-3-2018-proteins.txt", "r")
dataPro = filePro.read().replace("\n","").split("######")[1:-1]
l = len("Protein ")
proteins = {pro[l]:pro[l+1:] for pro in dataPro}


# process Blosum matrix
fileBlo = open("II-9-3-2018-blosum.txt", "r")
dataBlo = fileBlo.read().split("\n\n")
bloKey = dataBlo[0].split()     # protein key for blosum matrix
blosum = [row.split()[1:] for row in dataBlo[1:-2]]
blosum = [[int(y) for y in x] for x in blosum]


# blosum score function
#   aa - amino acid
def s(aa1, aa2):
    i = bloKey.index(aa1)
    j = bloKey.index(aa2)
    return blosum[i][j]