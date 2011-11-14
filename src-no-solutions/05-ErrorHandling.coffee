require './prelude'

# Error checking
show '--- Error checking ---'
between = (string, start, end) ->
  startAt = string.indexOf start
  if startAt == -1 then return
  startAt += start.length
  endAt = string.indexOf end, startAt
  if endAt == -1 then return
  string[startAt...endAt]

show between 'bu ] boo [ bah ] gzz', '[ ', ' ]'
show between 'bu [ boo bah gzz', '[ ', ' ]'

prompt "Tell me something", "", (answer) ->
  parenthesized = between answer, "(", ")"
  if parenthesized?
    show "You parenthesized '#{parenthesized}'."
  chain1()

chain1 = ->

  # Mixed return value
  show '--- Mixed return value ---'
  lastElement = (array) ->
    if array.length > 0
      array[array.length - 1]
    else
      undefined
  show lastElement [1, 2, undefined]

  # Try/catch sample
  show '--- Try/catch sample ---'
  lastElement = (array) ->
    if array.length > 0
      array[array.length - 1]
    else
      throw 'Can not take the last element' +
            ' of an empty array.'

  lastElementPlusTen = (array) ->
    lastElement(array) + 10

  try
    show lastElementPlusTen []
  catch error
    show 'Something went wrong: ' + error

  # Keyword finally
  show '--- Keyword finally ---'
  currentThing = null

  processThing = (thing) ->
    if currentThing != null
      throw 'Oh no! We are already processing a thing!'

    currentThing = thing
    # do complicated processing...
    currentThing = null

  processThing = (thing) ->
    if currentThing != null
      throw 'Oh no! We are already processing a thing!'

    currentThing = thing
    try
      # do complicated processing...
    finally
      currentThing = null

  # System errors
  show '--- System errors ---'
  try
    show Sasquatch
  catch error
    show 'Caught: ' + error.message

  # Throwing an error
  show '--- Throwing an error ---'
  try
    throw new Error 'Fire!'
  catch error
    show error

  # Seven Truths
  show '--- Seven Truths ---'
  FoundSeven = {}
  hasSevenTruths = (object) ->
    counted = 0
    count = (object) ->
      for name of object
        if object[name] == true
          if (++counted) == 7
            throw FoundSeven
        if typeof object[name] == 'object'
          count object[name]
    try
      count object
      return false
    catch exception
      if exception != FoundSeven
        throw exception
      return true

  testdata =
    a: true
    b: true
    c: false
    d:
      a: true
      b: false
      c: true
      d:
        a: true
        b:
          a: true
      e:
        a: false
        b: true
        c: true
  show hasSevenTruths testdata

  # Exit from the chain of inputs
  process.exit()
