require './prelude'
# Bring underscore into global
globalize _

# Slashes and escapes
show '--- Slashes and escapes ---'
slash = /\//
show 'AC/DC'.search slash

asteriskOrBrace = /[\{\*]/
story = 'We noticed the *giant sloth*, ' +
        'hanging from a giant branch.';
show story.search asteriskOrBrace

# Special characters
show '--- Special characters ---'
digitSurroundedBySpace = /\s\d\s/
show '1a 2 3d'.search digitSurroundedBySpace

notABC = /[^ABC]/
show 'ABCBACCBBADABC'.search notABC

# Exercise 32
show '--- Exercise 32 ---'
datePattern = /\d\d\/\d\d\/\d\d\d\d/
show 'born 15/11/2003 (mother Spot): White Fang'\
.search datePattern
show '--- End of Exercise ---'

# Boundaries
show '--- Boundaries ---'
show /a+/.test 'blah'
show /^a+$/.test 'blah'

show /cat/.test 'concatenate'
show /\bcat\b/.test 'concatenate'

# Repetitions
show '--- Repetitions ---'
parenthesizedText = /\(.*\)/
show "Its (the sloth's) claws were gigantic!"\
.search parenthesizedText

datePattern = /\d{1,2}\/\d\d?\/\d{4}/
show 'born 15/11/2003 (mother Spot): White Fang'\
.search datePattern

datePattern = ///
  \d{1,2}   # day
  /         # separator
  \d\d?     # month
  /         # separator
  \d{4}     # year
///
show 'born 15/11/2003 (mother Spot): White Fang'\
.search datePattern

# Exercise 33
show '--- Exercise 33 ---'
mailAddress = /\b[\w\.-]+@[\w\.-]+\.\w{2,3}\b/

mailAddress = ///
  \b[\w\.-]+  # username
  @
  [\w\.-]+\   # provider
  .
  \w{2,3}\b   # domain
///

show mailAddress.test 'kenny@test.net'
show mailAddress.test 'I mailt kenny@tets.nets, ' +
                      'but it didn wrok!'
show mailAddress.test 'the_giant_sloth@gmail.com'
show '--- End of Exercise ---'

# Grouping
show '--- Grouping ---'
cartoonCrying = /boo(hoo+)+/i
show "Then, he exclaimed 'Boohoooohoohooo'"\
.search cartoonCrying

# Choice
show '--- Choice ---'
holyCow = /(sacred|holy) (cow|bovine|bull|taurus)/i
show holyCow.test 'Sacred bovine!'

# Match method
show '--- Match method ---'
show 'No'.match /Yes/
show '... yes'.match /yes/
show 'Giant Ape'.match /giant (\w+)/i

quote = "My mind is a swirling miasma " +
        "(a poisonous fog thought to " +
        "cause illness) of titilating " +
        "thoughts and turgid ideas."
parenthesized = quote.match ///
  (\w+)    # Word
  \s*      # Whitespace
  \((.*)\) # Explanation
///
if parenthesized isnt null
  show "Word: #{parenthesized[1]} " +
       "Explanation: #{parenthesized[2]}"

# Exercise 34
show '--- Exercise 34 ---'
extractDate = (string) ->
  found = string.match /(\d\d?)\/(\d\d?)\/(\d{4})/
  if found == null
    throw new Error "No date found in '#{string}'."
  new Date Number(found[3]),
           Number(found[2]) - 1,
           Number(found[1])
show extractDate \
  "born 5/2/2007 (mother Noog): Long-ear Johnson"
show '--- End of Exercise ---'

# Replace method
show '--- Replace method ---'
show 'Borobudur'.replace /[ou]/g, 'a'

# Numbered parts
show '--- Numbered parts ---'
names = '''Picasso, Pablo
Gauguin, Paul
Van Gogh, Vincent'''

show names.replace /([\w ]+), ([\w ]+)/g, '$2 $1'

show names.replace ///
  ([\w ]+)         # Lastname
  ,
  ([\w ]+)         # Firstname
///g, '$2 $1'

# Replacement function
show '--- Replacement function ---'
eatOne = (match, amount, unit) ->
  amount = Number(amount) - 1
  if amount == 1
    unit = unit.slice 0, unit.length - 1
  else if amount == 0
    unit = unit + 's'
    amount = 'no'
  amount + ' ' + unit

stock = '1 lemon, 2 cabbages, and 101 eggs'
stock = stock.replace /(\d+) (\w+)/g, eatOne
show stock

# Exercise 35
show '--- Exercise 35 ---'
escapeHTML = (text) ->
  replacements = [[/&/g, '&amp;']
                  [/"/g, '&quot;']
                  [/</g, '&lt;']
                  [/>/g, '&gt;']]
  forEach replacements, (replace) ->
    text = text.replace replace[0], replace[1]
  text
show escapeHTML '< " & " >'

escapeHTML = (text) ->
  replacements =
    "<":  "&lt;"
    ">":  "&gt;"
    "&":  "&amp;"
    "\"": "&quot;"
  text.replace /[<>&"]/g, (character) ->
    replacements[character]

show escapeHTML "The 'pre-formatted' tag " +
                "is written \"<pre>\"."
show '--- End of Exercise ---'

# Word filter
show '--- Word filter ---'
badWords = ['ape', 'monkey', 'simian',
            'gorilla', 'evolution']
pattern = new RegExp badWords.join('|'), 'i'
isAcceptable = (text) ->
  !pattern.test text

show isAcceptable 'Mmmm, grapes.'
show isAcceptable 'No more of that monkeybusiness, now.'

# Escape escapes
show '--- Escape escapes ---'
digits = new RegExp '\\d+'
show digits.test '101'

