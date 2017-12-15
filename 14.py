
from ten import knot

input = "hxtvlmkl"
inputs = [input+"-"+str(i) for i in xrange(128)]

def star1(inputs):
    used = 0

    for input in inputs:
        hash = knot(input)
        used += sum(bin(int(c, 16))[2:].count('1') for c in hash)

    return used


print star1(inputs)