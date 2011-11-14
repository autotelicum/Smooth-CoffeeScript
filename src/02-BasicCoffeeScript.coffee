require './prelude'

# Number formats
show '--- Number formats ---'
show 144
show 144.toString 2

show 9.81
show 2.998e8

# Rounding errors
show '--- Rounding errors ---'
p = 1/3
show 6*p is 2
show p+p+p+p+p+p is 2
show 2-1e-15 < p+p+p+p+p+p < 2+1e-15

# Rounding errors accumulate in loops
i = 0
i++ for angle in [0...2*Math.PI] by 1/3*Math.PI
show i # Gives 7 iterations and not 6


# Arithmetic operators
show '--- Arithmetic operators ---'
show 100 + 4 * 11
show (100 + 4) * 11

show 115 * 4 - 4 + 88 / 2

show 314 % 100
show 10 % 3
show 144 % 12


# String types
show '--- String types ---'
show 'Patch my boat with chewing gum.'
show 'The programmer pondered: "0x2b or not 0x2b"'
show "Aha! It's 43 if I'm not a bit off"
show "2 + 2 is equal to #{2 + 2}"

show 'Imagine if this was a
 very long line of text'

show '''First comes A
        then comes B'''

show """  1
        + 1
        ---  # " The next line confuses docco
          #{1 + 1}"""

# Escape characters
show '--- Escape characters ---'
show 'This is the first line\nAnd this is the second'
show 'A newline character is written like \"\\n\".'
show 'con' + 'cat' + 'e' + 'nate'

# String description of a type
show '--- String description of a type ---'
show typeof 4.5

# Unary minus
show '--- Unary minus ---'
show -(10 - 2)

# Booleans
show '--- Booleans ---'
show 3 > 2
show 3 < 2

# Chained comparisons
show '--- Chained comparisons ---'
show 100 < 115 < 200
show 100 < 315 < 200

# String comparisons
show '--- String comparisons ---'
show 'Aardvark' < 'Zoroaster'
show 'Itchy' != 'Scratchy'

# Logical operators
show '--- Logical operators ---'
show true and false
show true or false
show !true
show not false

# Exercise 1
show '--- Exercise 1 ---'
show ((4 >= 6) || ('grass' != 'green')) &&
     !(((12 * 2) == 144) && true)

show (4 >= 6 or 'grass' isnt 'green') and
     not(12 * 2 is 144 and true)

show (false or true) and not(false and true)
show true and not false
show 'grass' != 'green'
show '--- End of Exercise ---'

# Useless program
show '--- Useless program ---'
1; !false
show 'Nothing was intentionally output'

# Variables
show '--- Variables ---'
caught = 5 * 5
show caught
show caught + 1
caught = 4 * 4
show caught

# Tentacles
show '--- Tentacles ---'
luigiDebt = 140
luigiDebt = luigiDebt - 35
show luigiDebt

# Environment
show '--- Environment ---'
# To show the environment, use: show global or show window
show 'Also, your hair is on fire.'

# Function invocation
show '--- Function invocation ---'
show Math.max 2, 4

show 100 + Math.max 7, 4
show Math.max(7, 4) + 100
show Math.max(7, 4 + 100)
show Math.max 7, 4 + 100

# Explore the environment - Try this in the REPL
# show process
# show console
# show _
# show show

# Questions
show '--- Questions ---'
# chain is required here to wait for the answer
confirm 'Shall we, then?', (answer) -> show answer; chain1()

chain1 = ->
  prompt 'Tell us everything you know.', '...',
    (answer) -> show 'So you know: ' + answer; chain2()

chain2 = ->
  prompt 'Pick a number', '', (answer) ->
    theNumber = Number answer
    show 'Your number is the square root of ' +
      (theNumber * theNumber)
    chain3()

chain3 = ->
  # While loops
  show '--- While loops ---'
  show 0
  show 2
  show 4
  show 6
  show 8
  show 10
  show 12

  currentNumber = 0
  while currentNumber <= 12
    show currentNumber
    currentNumber = currentNumber + 2

  counter = 0
  while counter <= 12 then counter = counter + 2

  # Exercise 2
  show '--- Exercise 2 ---'
  result = 1
  counter = 0
  while counter < 10
    result = result * 2
    counter = counter + 1
  show result
  show '--- End of Exercise ---'

  # Exercise 3
  show '--- Exercise 3 ---'
  line = ''
  counter = 0
  while counter < 10
    line = line + '#'
    show line
    counter = counter + 1
  show '--- End of Exercise ---'

  # Sneak peek at Functional solutions
  show '--- Sneak peek at Functional solutions ---'
  show _.reduce [1..10], ((x) -> 2*x), 1
  _.reduce [1..10], ((s) -> show s += '#'), ''

  # For loops
  show '--- For loops ---'
  show 'For on one line'
  for number in [0..12] by 2 then show number
  show 'For with indented body'
  for number in [0..12] by 2
    show number
  show 'For with prepended body'
  show number for number in [0..12] by 2
  show 'For collecting results'
  numbers = (number for number in [0..12] by 2)
  show numbers

  # Comments
  show '--- Comments ---'
  # The variable counter, which is about to be defined,
  # is going to start with a value of 0, which is zero.
  counter = 0
  # Now, we are going to loop, hold on to your hat.
  while  counter < 100 # counter is less than one hundred
    ###
    Every time we loop, we INCREMENT the value of counter
    Seriously, we just add one to it.
    ###
    counter++
  # And then, we are done.


  # Exercise 4
  show '--- Exercise 4 ---'
  result = 1
  for counter in [0...10]
    result = result * 2
  show result

  line = ''
  for counter in [0...10]
    line = line + '#'
    show line
  show '--- End of Exercise ---'

  # Conditionals
  show '--- Conditionals ---'
  for counter in [0..20]
    if counter % 3 == 0 and counter % 4 == 0
      show counter

  for counter in [0..20]
    if counter % 4 == 0
      show counter
    if counter % 4 != 0
      show '(' + counter + ')'

  for counter in [0..20]
    if counter % 4 == 0
      show counter
    else
      show '(' + counter + ')'

  for counter in [0..20]
    if counter > 15
      show counter + '**'
    else if counter > 10
      show counter + '*'
    else
      show counter

  # Exercise 5
  show '--- Exercise 5 ---'
  prompt 'You! What is the value of 2 + 2?', '',
    (answer) ->
      if answer == '4'
        show 'You must be a genius or something.'
      else if answer == '3' || answer == '5'
        show 'Almost!'
      else
        show 'You are an embarrassment.'
      chain4()
  show '--- End of Exercise ---'

chain4 = ->
  # If variation
  show '--- If variation ---'
  fun = on
  show 'The show is on!' unless fun is off

  # Loop variations
  show '--- Loop variations ---'
  current = 20
  loop
    if current % 7 == 0
      break
    current++
  show current

  current = 20
  current++ until current % 7 == 0
  show current

  # Exercise 6
  show '--- Exercise 6 ---'
  luckyNumber = 5 # Choose from 1 to 6
  show "Your lucky number is #{luckyNumber}"
  count = 0
  loop
    show roll = Math.floor Math.random() * 6 + 1
    count++
    if roll is luckyNumber then break
  show "Luck took #{count} roll(s)"

  luckyNumber = 3 # Choose from 1 to 6
  show 'Your lucky number is ' + luckyNumber
  count = 0
  until roll is luckyNumber
    show roll = Math.floor Math.random() * 6 + 1
    count++
  show 'You are lucky ' +
      Math.floor(100/count) + '% of the time'
  show '--- End of Exercise ---'

  # Undefined variable
  show '--- Undefined variable ---'
  show mysteryVariable
  mysteryVariable = 'nothing'

  show console.log 'I am a side effect.'

  # Existential operator
  show '--- Existential operator ---'
  show iam ? undefined
  iam ?= 'I want to be'
  show iam
  iam ?= 'I am already'
  show iam if iam?

  # Type conversions
  show '--- Type conversions ---'
  show false == 0
  show '' == 0
  show '5' == 5

  # String type conversions
  show '--- String type conversions ---'
  show 'Apollo' + 5
  show null + 'ify'
  show '5' * 5
  show 'strawberry' * 5

  show Number('5') * 5

  # NaN
  show '--- NaN ---'
  show NaN == NaN

  # Boolean type conversions
  show '--- Boolean type conversions ---'
  prompt 'What is your name?', '',
    (input) ->
      show 'Well hello ' + (input || 'dear')
      chain5()

chain5 = ->
  # Short circuit operators
  show '--- Short circuit operators ---'
  false || show 'I am happening!'
  true  || show 'Not me.'

  # Exit from the chain of inputs
  process.exit()
