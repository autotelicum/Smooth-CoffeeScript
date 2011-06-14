require './prelude'

# Pure functions
show '--- Pure functions ---'
add = (a, b) -> a + b
show add 2, 2

power = (base, exponent) ->
  result = 1
  for count in [0...exponent]
    result *= base
  result
show power 2, 10

# Exercise 7
show '--- Exercise 7 ---'
absolute = (number) ->
  if number < 0
    -number
  else
    number
show absolute -144
show '--- End of Exercise ---'

# Declarative tests
show '--- Declarative tests ---'
testAbsolute = (name, property) ->
  qc.testPure absolute, [qc.arbInt], name, property

testAbsolute 'returns positive integers',
  (c, arg, result) -> result >= 0

testAbsolute 'positive returns positive',
  (c, arg, result) -> c.guard arg >= 0; result is arg

testAbsolute 'negative returns positive',
  (c, arg, result) -> c.guard arg < 0; result is -arg

qc.testPure power, [qc.arbInt, qc.arbInt],
  'power == Math.pow for integers',
  (c, base, exponent, result) ->
    result == c.note Math.pow base, exponent

qc.testPure power, [qc.arbWholeNum, qc.arbWholeNum],
  'power == Math.pow for positive integers',
  (c, base, exponent, result) ->
    result == c.note Math.pow base, exponent

qc.test()

# Quick hack to avoid garbling of output
# when async test cases are reported.
# A better idea is one test suite in one file.
setTimeout ( ->

  # Exercise 8

  intensify = (n) ->
    2 # This will fail

  show '--- Exercise 8 ---'
  intensify = (n) ->
    if n > 0
      n + 2
    else if n < 0
      n - 2
    else
      n
  show '--- End of Exercise ---'

  qc.testPure intensify, [qc.arbInt],
    'intensify grows by 2 when positive',
    (c, arg, result) ->
      c.guard arg > 0
      arg + 2 == result

  qc.testPure intensify, [qc.arbInt],
    'intensify grows by 2 when negative',
    (c, arg, result) ->
      c.guard arg < 0
      arg - 2 == result

  qc.testPure intensify, [qc.arbConst(0)],
    'only non-zero intensify grows',
    (c, arg, result) ->
      result is arg

  qc.test()

  setTimeout ( ->
    
    # Return revisited
    show '--- Return revisited ---'
    yell = (message) ->
      show message + '!!'
      return
    yell 'Yow'

    # Local scopes
    show '--- Local scopes ---'
    dino = 'I am alive'
    reptile = 'I am A-OK'
    meteor = (reptile) ->
      show reptile            # Argument
      dino = 'I am extinct'
      reptile = 'I survived'
      possum = 'I am new'
    show dino                 # Outer
    meteor 'What happened?'
    show dino                 # Outer changed
    show reptile              # Outer unchanged
    try show possum catch e
      show e.message          # Error undefined

    # Local environment
    show '--- Local environment ---'
    variable = 'first'                    # Definition

    showVariable = ->
      show 'In showVariable, the variable holds: ' +
            variable                      # second

    test = ->
      variable = 'second'                 # Assignment
      show 'In test, the variable holds ' +
           variable + '.'                 # second
      showVariable()

    show 'The variable is: ' + variable   # first
    test()
    show 'The variable is: ' + variable   # second

    # Siblings and children
    show '--- Siblings and children ---'
    andHere = ->
      try show aLocal                     # Not defined
      catch e then show e.message
    isHere = ->
      aLocal = 'aLocal is defined'
      andHere()
    isHere()

    isHere = ->
      andHere = ->
        try show aLocal                   # Is defined
        catch e then show e.message
      aLocal = 'aLocal is defined'
      andHere()
    isHere()

    # Internal function variable
    show '--- Internal function variable ---'
    varWhich = 'top-level'
    parentFunction = ->
      varWhich = 'local'
      childFunction = ->
        show varWhich
      childFunction
    child = parentFunction()
    child()

    # Synthesized function
    show '--- Synthesized function ---'
    makeAddFunction = (amount) ->
      add = (number) -> number + amount

    addTwo = makeAddFunction 2
    addFive = makeAddFunction 5
    show addTwo(1) + addFive(1)

    # Recursion
    show '--- Recursion ---'
    powerRec = (base, exponent) ->
      if exponent == 0
        1
      else
        base * powerRec base, exponent - 1
    show 'power 3, 3 = ' + powerRec 3, 3

    # Timing
    show '--- Timing ---'
    timeIt = (func) ->
      start = new Date()
      for i in [0...1000000] then func()
      show "Timing: #{(new Date() - start)*0.001}s"

    timeIt -> p = add 9,18                # 0.042s
    timeIt -> p = Math.pow 9,18           # 0.049s
    timeIt -> p = power 9,18              # 0.464s
    timeIt -> p = powerRec 9,18           # 0.544s

    # Indirect recursion
    show '--- Indirect recursion ---'
    chicken = ->
      show 'Lay an egg'
      egg()
    egg     = ->
      show 'Chick hatched'
      chicken()
    try show chicken() + ' came first.'
    catch error then show error.message

    # Recursive puzzle solving
    show '--- Recursive puzzle solving ---'
    findSequence = (goal) ->
      find = (start, history) ->
        if start == goal
          history
        else if start > goal
          null
        else
          find(start + 5, '(' + history + ' + 5)') ? \
          find(start * 3, '(' + history + ' * 3)')
      find 1, '1'
    show findSequence 24

    # Anonymous functions
    show '--- Anonymous functions ---'
    makeAddFunction = (amount) ->
      (number) -> number + amount
    show makeAddFunction(11) 3

    # Exercise 9
    show '--- Exercise 9 ---'
    greaterThan = (x) ->
      (y) -> y > x
    greaterThanTen = greaterThan 10
    show greaterThanTen 9
    show '--- End of Exercise ---'

    # Extra function arguments
    show '--- Extra function arguments ---'
    yell 'Hello', 'Good Evening', 'How do you do?'
    yell()

    # Variable number of arguments
    show '--- Variable number of arguments ---'
    console.log 'R', 2, 'D', 2

    ),300
  ),300





