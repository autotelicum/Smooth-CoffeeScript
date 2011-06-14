# CoffeeScript encoding: utf-8
start = new Date()
show = console.log

# Create variations to try
permute = (L) ->
  n = L.length
  return ([elem] for elem in L) if n is 1
  [a, L] = [ [L[0]], L.slice 1 ]
  result = []
  for p in permute L
    for i in [0...n]
      result.push p[...i].concat a, p[i...]
  result

# Check a variation
test = (p, n) ->
  for i in [0...n - 1]
    for j in [i + 1...n]
      d = p[i] - p[j]
      return true if j - i == d or i - j == d
  false

# N queens solver
nQueen = (n) ->
  result = []
  for p in permute [0...n]
    result.push p unless test p, n
  result

# Repeat a string a number of times
rep = (s, n) -> (s for [0...n]).join ''

# Display a board with a solution
printBoard = (solution) ->
  board = "\n"
  end = solution.length
  for pos, row in solution
    board += "#{end - row} #{rep ' ☐ ', pos} " +
             "♕ #{rep ' ☐ ', end - pos - 1}\n"
  # Using radix 18 hack!
  board += '   ' + (n.toString 18 \
    for n in [10...18]).join('  ').toUpperCase()
  board + "\n"

# Find all solutions
solve = (n) ->
  for solution, count in nQueen n
    show "Solution #{count+1}:"
    show printBoard solution
  count

solve 8 # Normal chessboard size

show "Timing: #{(new Date() - start)*0.001}s"
