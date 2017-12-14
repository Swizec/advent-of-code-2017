
input = [130,126,1,11,140,2,255,207,18,254,246,164,29,104,0,224]

def knot_1round(pos, skip, lengths, input):
    for length in lengths:
        if pos+length > len(input):
            wrap = (pos+length)%len(input)
        else:
            wrap = 0

        nums = input[pos:pos+length] + input[:wrap]
        nums = list(reversed(nums))
        
        if wrap > 0:
            input = nums[-wrap:] + input[wrap:pos] + nums[:-wrap] + input[pos+length:]
        else:
            input = input[:pos] + nums + input[pos+length:]

        pos = (pos+length+skip)%len(input)
        skip += 1

    return pos, skip, input

def knot(input):
    lengths = [ord(str(c)) for c in input] + [17, 31, 73, 47, 23]

    pos = 0
    skip = 0
    numbers = range(0, 256)
    
    for i in xrange(64):
        pos, skip, numbers = knot_1round(pos, skip, lengths, numbers)
        
    blocks = [reduce(lambda b, n: b^n, numbers[i:i+16]) for i in xrange(0, len(numbers), 16)]

    print numbers[0:16]

    return "".join(["%0.2X" % c for c in blocks])

# Star 1
#pos, skip, hash = knot_1round(0, 0, input)
#print hash[0] * hash[1]

# Star 2
print knot("130,126,1,11,140,2,255,207,18,254,246,164,29,104,0,224")