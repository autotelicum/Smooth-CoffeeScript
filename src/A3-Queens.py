# CPython encoding: utf-8
import time
t=time.clock()

def permute(L):
    "Create variations to try"
    n = len(L)
    if n == 1:
        for elem in L:
            yield [elem]
    else:
        a = [L.pop(0)]
        for p in permute(L):
            for i in range(n):
                yield p[:i] + a + p[i:]

def test(p, n):
    "Check a variation"
    for i in range(n - 1):
        for j in range(i + 1, n):
            d = p[i] - p[j]
            if j - i == d or i - j == d:
                return True
    return False

def n_queen(n):
    "N queens solver"
    for p in permute(range(n)):
        if not test(p, n): yield p

# Start columns from A
base_char = ord('A')

def print_board(solution):
    "Display a board with a solution"
    board = []
    end = len(solution)
    for row, pos in enumerate(solution):
        board += ["\n%s %s ♕ %s" % ((end - row),
          (' ☐ ' * pos),
          (' ☐ ' * (end - pos - 1)))]
    # Using character set hack!
    board += '\n   ' + \
      '  '.join([chr(base_char+i)
        for i in range(0, end)])
    return ''.join(board) + '\n'

def solve(n):
    "Find all solutions"
    for count, solution in enumerate(n_queen(n)):
        print "Solution %d:" % (count + 1)
        print print_board(solution)
    return count

solve(8) # Normal chessboard size

print "Timing: ", time.clock()-t, "s"
