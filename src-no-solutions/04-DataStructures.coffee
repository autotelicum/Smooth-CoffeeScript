require './prelude'

# Properties
show '--- Properties ---'
text = 'purple haze'
show text['length']
show text.length

# No property
show '--- No property ---'
# try/catch is explained in `Error Handling`,
# it lets the script continue after an error.
try
  nothing = null
  show nothing.length
catch error
  show error.message

# Object properties
show '--- Object properties ---'
cat =
  colour: 'grey'
  name: 'Spot'
  size: 46
# Or: cat = {colour: 'grey', name: 'Spot', size: 46}
cat.size = 47
show cat.size
delete cat.size
show cat.size
show cat

# Property properties
show '--- Property properties ---'
empty = {}
empty.notReally = 1000
show empty.notReally

thing = {'gabba gabba': 'hey', '5': 10}
show thing['5']
thing['5'] = 20
show thing[2 + 3]
delete thing['gabba gabba']
show thing

propertyName = 'length'
text = 'mainline'
show text[propertyName]

# The `of` operator
show '--- The of operator ---'
chineseBox = {}
chineseBox.content = chineseBox
show 'content' of chineseBox
show 'content' of chineseBox.content
show chineseBox, 4

# Showing properties
show '--- Showing properties ---'
abyss = {let:1, us:go:deep:down:7}
show abyss
show abyss, 5

# Exercise 10
show '--- Exercise 10 ---'
process.exit() # Replace this line with your solution
show '--- End of Exercise ---'

# Mutability
show '--- Mutability ---'
object1 = {value: 10}
object2 = object1
object3 = {value: 10}

show object1 == object2
show object1 == object3

object1.value = 15
show object2.value
show object3.value

# Data representation
show '--- Data representation ---'

mailArchive = {
  'the first e-mail': 'Dear nephew, ...'
  'the second e-mail': '...'
  # and so on ...
}

mailArchive = {
  0: 'Dear nephew, ... (mail number 1)'
  1: '(mail number 2)'
  2: '(mail number 3)'
}

for current of mailArchive
  show 'Processing e-mail #' + current +
       ': ' + mailArchive[current]

# Arrays
show '--- Arrays ---'
mailArchive = ['mail one', 'mail two', 'mail three']

for current in [0...mailArchive.length]
  show 'Processing e-mail #' + current +
       ': ' + mailArchive[current]

# Exercise 11
show '--- Exercise 11 ---'
process.exit() # Replace this line with your solution
show '--- End of Exercise ---'

# For expression
show '--- For expression ---'
numbers = (number for number in [0..12] by 2)
show numbers

# Methods on objects
show '--- Methods on objects ---'
doh = 'Doh'
show typeof doh.toUpperCase
show doh.toUpperCase()

mack = []
mack.push 'Mack'
mack.push 'the'
mack.push 'Knife'
show mack.join ' '
show mack.pop()
show mack

# Emails
show '--- Emails ---'
mailArchive = (require "./04-emails").retrieveMails()

for email, i in mailArchive
  show "Processing e-mail ##{i} #{email[0..15]}..."
  # Do more things...

# Split
show '--- Split ---'
words = 'Cities of the Interior'
show words.split ' '

# Exercise 12
show '--- Exercise 12 ---'
process.exit() # Replace this line with your solution
show '--- End of Exercise ---'

# Splitting strings
show '--- Splitting strings ---'
paragraph = 'born 15-11-2003 (mother Spot): White Fang'
show paragraph.charAt(0) == 'b' &&
     paragraph.charAt(1) == 'o' &&
     paragraph.charAt(2) == 'r' &&
     paragraph.charAt(3) == 'n'

show paragraph.slice(0, 4) == 'born'
show paragraph[0...4] == 'born'

# Exercise 13
show '--- Exercise 13 ---'
process.exit() # Replace this line with your solution
show '--- End of Exercise ---'

# String boundaries
show '--- String boundaries ---'
show 'Pip'.charAt 250
show 'Nop'.slice 1, 10
show 'Pin'[1...10]
show startsWith('Idiots', 'Most honoured colleagues')

# Test of startsWith
show '--- Test of startsWith ---'
# Reference implementation
startsWithRef = (str, pat) ->
  if !str? or !pat? then return
  ref = true
  for ch, ix in pat
    if not ref = str[ix] is ch
      break
  ref

qc.declare 'startsWith matches reference',
  [qc.arbString, qc.arbString],
  (c, str, pat) ->
    c.collect ref = startsWithRef str, pat
    c.assert ref == startsWith str, pat

qc.declare 'startsWith matches substrings',
  [qc.arbString, qc.arbWholeNum],
  (c, str, len) ->
    pat = str[0...len]
    c.collect ref = startsWithRef str, pat
    c.assert ref == startsWith str, pat

# Add `if !string? or !pattern? then return`
# to `startsWith` to make it succeed this test
qc.declare 'startsWith handles null/undefined',
  [qc.arbNullOr(qc.arbUndefOr(qc.arbString)),
   qc.arbNullOr(qc.arbUndefOr(qc.arbString))],
  qc.failOnException (c, str, pat) ->
    c.collect ref = startsWithRef str, pat
    c.assert ref == startsWith str, pat

qc.test()

# Quick hack to avoid garbling of output
# when async test cases are reported.
# A better idea is one test suite in one file.
setTimeout ( ->

  # Exercise 14
  show '--- Exercise 14 ---'
  process.exit() # Replace this line with your solution
  show '--- End of Exercise ---'

  # Find living cats
  show '--- Find living cats ---'
  mailArchive = (require './04-emails').retrieveMails()
  livingCats = 'Spot': true

  for email in mailArchive
    paragraphs = email.split '\n'
    for paragraph in paragraphs
      if startsWith paragraph, 'born'
        names = catNames paragraph
        for name in names
          livingCats[name] = true
      else if startsWith paragraph, 'died'
        names = catNames paragraph
        for name in names
          delete livingCats[name]

  show livingCats

  if 'Spot' in livingCats
    show 'Spot lives!'
  else
    show 'Good old Spot, may she rest in peace.'

  for cat of livingCats
    show cat

  # Set functions
  show '--- Set functions ---'
  addToSet = (set, values) ->
    for value in values
      set[value] = true

  removeFromSet = (set, values) ->
    for value in values
      delete set[value]

  livingCats = Spot: true

  for email in mailArchive
    paragraphs = email.split '\n'
    for paragraph in paragraphs
      if startsWith paragraph, 'born'
        addToSet livingCats, catNames paragraph
      else if startsWith paragraph, 'died'
        removeFromSet livingCats, catNames paragraph

  show livingCats

  # Cat functions
  show '--- Cat functions ---'

  findLivingCats = ->
    mailArchive = (require './04-emails').retrieveMails()
    livingCats = 'Spot': true

    handleParagraph = (paragraph) ->
      if startsWith paragraph, 'born'
        addToSet livingCats, catNames paragraph
      else if startsWith paragraph, 'died'
        removeFromSet livingCats, catNames paragraph

    for email in mailArchive
      paragraphs = email.split '\n'
      for paragraph in paragraphs
        handleParagraph paragraph

    livingCats

  howMany = 0
  for cat of findLivingCats()
    howMany++
  show 'There are ' + howMany + ' cats.'

  # Dates
  show '--- Dates ---'
  whenWasIt = year: 1980, month: 2, day: 1
  show whenWasIt
  whenWasIt = new Date 1980, 1, 1
  show whenWasIt

  show new Date
  show new Date 1980, 1, 1
  show new Date 2007, 2, 30, 8, 20, 30

  # Date getters
  show '--- Date getters ---'
  today = new Date();
  show "Year: #{today.getFullYear()}
 month: #{today.getMonth()}
 day: #{today.getDate()}"
  show "Hour: #{today.getHours()}
 minutes: #{today.getMinutes()}
 seconds: #{today.getSeconds()}"
  show "Day of week: #{today.getDay()}"

  today = new Date()
  show today.getTime()

  # Comparing dates
  show '--- Comparing dates ---'
  wallFall = new Date 1989, 10, 9
  gulfWarOne = new Date 1990, 6, 2
  show wallFall < gulfWarOne
  show wallFall == wallFall
  # but
  show wallFall == new Date 1989, 10, 9

  wallFall1 = new Date 1989, 10, 9
  wallFall2 = new Date 1989, 10, 9
  show wallFall1.getTime() == wallFall2.getTime()

  # Timezones
  show '--- Timezones ---'
  now = new Date()
  show now.getTimezoneOffset()

  # Exercise 15
  show '--- Exercise 15 ---'
  process.exit() # Replace this line with your solution
  show '--- End of Exercise ---'

  # Record functions
  show '--- Record functions ---'
  catRecord = (name, birthdate, mother) ->
    name:   name
    birth:  birthdate
    mother: mother

  addCats = (set, names, birthdate, mother) ->
    for name in names
      set[name] = catRecord name, birthdate, mother

  deadCats = (set, names, deathdate) ->
    for name in names
      set[name].death = deathdate

  # Extract function
  show '--- Extract function ---'
  extractMother = (paragraph) ->
    start = paragraph.indexOf '(mother '
    start += '(mother '.length
    end = paragraph.indexOf ')'
    paragraph[start...end]

  show extractMother \
    'born 15/11/2003 (mother Spot): White Fang'

  # Exercise 16
  show '--- Exercise 16 ---'
  process.exit() # Replace this line with your solution
  show '--- End of Exercise ---'

  # Shorter extract function
  show '--- Shorter extract function ---'
  extractMother = (paragraph) ->
    between paragraph, '(mother ', ')'
  show extractMother \
    'born 15/11/2003 (mother Spot): White Fang'

  # Improved cat-algorithm
  show '--- Improved cat-algorithm ---'
  findCats = ->
    mailArchive = (require './04-emails').retrieveMails()
    cats = {'Spot': catRecord 'Spot',
      new Date(1997, 2, 5), 'unknown'}
  
    handleParagraph = (paragraph) ->
      if startsWith paragraph, 'born'
        addCats cats, catNames(paragraph),
                extractDate(paragraph),
                extractMother(paragraph)
      else if startsWith paragraph, 'died'
        deadCats cats, catNames(paragraph),
                 extractDate(paragraph)

    for email in mailArchive
      paragraphs = email.split '\n'
      for paragraph in paragraphs
        handleParagraph paragraph
    cats

  catData = findCats()
  show catData

  # Information functions
  show '--- Information functions ---'
  formatDate = (date) -> "#{date.getDate()}/" +
                         "#{date.getMonth() + 1}/" +
                         "#{date.getFullYear()}"
  catInfo = (data, name) ->
    unless name of data
      return "No cat by the name of #{name} is known."
    cat = data[name]
    message = "#{name}," +
              " born #{formatDate cat.birth}" +
              " from mother #{cat.mother}"
    if "death" of cat
      message += ", died #{formatDate cat.death}"
    "#{message}."

  show catInfo catData, "Fat Igor"

  # Exercise 17
  show '--- Exercise 17 ---'
  process.exit() # Replace this line with your solution
  show '--- End of Exercise ---'

  # Exercise 18
  show '--- Exercise 18 ---'
  process.exit() # Replace this line with your solution
  show '--- End of Exercise ---'

  # Variable arguments
  show '--- Variable arguments ---'
  argumentCounter = ->
    show "You gave me #{arguments.length} arguments."
  argumentCounter 'Death', 'Famine', 'Pestilence'


  # Print variable arguments
  show '--- Print variable arguments ---'
  print = -> show arg for arg in arguments

  print 'From here to', 1/0

  # Optional arguments
  show '--- Optional arguments ---'
  add = (number, howmuch) ->
    if  arguments.length < 2
      howmuch = 1
    number + howmuch

  show add 6
  show add 6, 4

  # Exercise 19
  show '--- Exercise 19 ---'
  process.exit() # Replace this line with your solution
  show '--- End of Exercise ---'

  # Exercise 20
  show '--- Exercise 20 ---'
  process.exit() # Replace this line with your solution
  show '--- End of Exercise ---'

  # Hidden built-in properties
  show '--- Hidden properties ---'
  for name of Math
    show name

  # Hidden array properties
  show '--- Hidden array properties ---'
  for name of ['Huey', 'Dewey', 'Loui']
    show name

  # Show hidden properties
  show '--- Show hidden properties ---'
  show Math, 2, true
  show ['Huey', 'Dewey', 'Loui'], 2, true

  # Watched properties
  show '--- Watched properties ---'
  array = ['Heaven', 'Earth', 'Man']
  array.length = 2
  show array

  ),300

