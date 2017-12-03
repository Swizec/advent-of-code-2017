
import numpy as np

input = "277678"

# Star 1
"""
Each square on the grid is allocated in a spiral pattern starting at a location marked 1 and then counting up while spiraling outward. For example, the first few squares are allocated like this:

17  16  15  14  13
18   5   4   3  12
19   6   1   2  11
20   7   8   9  10
21  22  23---> ...
While this is very space-efficient (no squares are skipped), requested data must be carried back to square 1 (the location of the only access port for this memory system) by programs that can only move up, down, left, or right. They always take the shortest path: the Manhattan Distance between the location of the data and square 1.

For example:

Data from square 1 is carried 0 steps, since it's at the access port.
Data from square 12 is carried 3 steps, such as: down, left, left.
Data from square 23 is carried only 2 steps: up twice.
Data from square 1024 must be carried 31 steps.
How many steps are required to carry the data from the square identified in your puzzle input all the way to the access port?
"""

def manhattan_distance(x, y):
    # https://en.wikipedia.org/wiki/Taxicab_geometry
    # q = (0, 0)
    # p = (x, y)
    # d = |p1 - q1| + |p2 - q2|
    # d = p1 + p2
    return abs(x) + abs(y)

def spiral(N):
    x = 0
    y = 0
    w = 1
    h = 1
    i = 1

    while i <= N:
        # go max right
        if i + w <= N:
            i += w
            x += w
            w += 1
        else:
            x += N-i
            return x, y

        # go max up
        if i + h <= N:
            i += h
            y -= h
            h += 1
        else:
            y -= N-i
            return x, y

        # go max left
        if i + w <= N:
            i += w 
            x -= w
            w += 1
        else:
            x -= N-i
            return x, y

        #go max down
        if i + h <= N:
            i += h 
            y += h
            h += 1
        else:
            y += N-i
            return x, y

    return x, y

x, y = spiral(277678)
print manhattan_distance(x, y)


# Star 2
"""
same allocation order as shown above, they store the sum of the values in all adjacent squares, including diagonals.

So, the first few squares' values are chosen as follows:

Square 1 starts with the value 1.
Square 2 has only one adjacent filled square (with value 1), so it also stores 1.
Square 3 has both of the above squares as neighbors and stores the sum of their values, 2.
Square 4 has all three of the aforementioned squares as neighbors and stores the sum of their values, 4.
Square 5 only has the first and fourth squares as neighbors, so it gets the value 5.
Once a square is written, its value does not change. Therefore, the first few squares would receive the following values:

147  142  133  122   59
304    5    4    2   57
330   10    1    1   54
351   11   23   25   26
362  747  806--->   ...
What is the first value written that is larger than your puzzle input?
"""

def filled_spiral(N):
    matrix = np.zeros((1200,1200))
    matrix[600][600] = 1

    def valAt(x, y):
        # center of real space
        x += 600
        y += 600
        if matrix[x][y] > 0:
            return matrix[x][y]
        else:
            val = sum([matrix[x-1][y-1],
                        matrix[x][y-1],
                        matrix[x+1][y-1],
                        matrix[x-1][y],
                        matrix[x+1][y],
                        matrix[x-1][y+1],
                        matrix[x][y+1],
                        matrix[x+1][y+1]])
        # set and return
        matrix[x][y] = val
        return val
    
    x = 0 
    y = 0
    w = 1
    h = 1

    while 1:
        val = valAt(x, y)

        print w, h, val

        # right
        tx = x
        while tx < x + w:
            tx += 1
            if valAt(tx, y) > N:
                print matrix
                return valAt(tx, y)
            
        w += 1
        x = tx

        # up
        ty = y
        print "B:",x, y, w, h
        while ty > y - h:
            ty -= 1
            if valAt(x, ty) > N:
                print matrix
                return valAt(x, ty)
            
        h += 1
        y = ty

        #print "got here 2", x, y, w, h

        # left
        tx = x
        while tx > x - w:
            tx -= 1
            if valAt(tx, y) > N:
                print matrix
                return valAt(tx, y)
            
        w += 1
        x = tx

        #print "got here 3", x, y, w, h

        # down
        ty = y
        while ty < y + h:
            ty += 1
            if valAt(x, ty) > N:
                print matrix
                return valAt(x, ty)
            
        h += 1
        y = ty

        #print "got here 4", x, y, w, h
        

print filled_spiral(277678)
# wrong guess 483912.0