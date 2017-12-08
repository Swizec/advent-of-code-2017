
import numpy as np
import itertools

input = [4, 1, 15, 12, 0, 9, 9, 5, 5, 8, 7, 3, 14, 5, 12, 3]


# Star 1 & 2

def redistributions(banks):
    history = [banks[:]]

    while 1:
        i = np.argmax(banks)
        n = banks[i]
        banks[i] = 0
        while n > 0:
            i += 1
            banks[i%len(banks)] += 1
            n -= 1
        
        if banks in history:
            yield len(history)
            history = []

        print banks

        history.append(banks[:])

print list(itertools.islice(redistributions(input), 2))

#print [1,2,3] == [1,2,3][:]

