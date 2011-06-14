require './prelude'

# For each loops
show '--- For each loops ---'
thing = [5..7]
doSomething = show

for i in [0...thing.length] then doSomething thing[i]
show '-'
for element in thing then doSomething element
show '-'
printArray = (array) ->
  for element in array
    show element
  return
printArray [7..9]

# For each implementation
show '--- For each implementation ---'
forEach = (array, action) ->
  for element in array
    action element
  #return
forEach ['Wampeter', 'Foma', 'Granfalloon'], show

# Sum with forEach
show '--- Sum with forEach ---'
sum = (numbers) ->
  total = 0
  forEach numbers, (number) -> total += number
  total
show sum [1, 10, 100]

# Paragraph with forEach
show '--- Paragraph with forEach ---'
mailArchive = []
for email in mailArchive
  paragraphs = email.split '\n'
  for paragraph in paragraphs
    handleParagraph paragraph

for email in mailArchive
  forEach email.split('\n'), handleParagraph

# Negate function
show '--- Negate function ---'
negate = (func) ->
  (x) -> not func x

isNotNaN = negate isNaN
show isNotNaN NaN

# Variable function arguments
show '--- Variable function arguments ---'
show Math.min.apply null, [5, 6]

negate = (func) ->
  -> not func.apply null, arguments

morethan = (x,y) -> x > y
lessthan = negate morethan
show lessthan 5, 7

negate = (func) ->
  (args...) -> not func args...

morethan = (x,y) -> x > y
lessthan = negate morethan
show lessthan 5, 7

# Reduce function
show '--- Reduce function ---'
reduce = (array, combine, base) ->
  forEach array, (element) ->
    base = combine base, element
  base

add = (a, b) -> a + b
sum = (numbers) -> reduce numbers, add, 0
show sum [1, 10, 100]

# Exercise 21
show '--- Exercise 21 ---'
countZeroes = (array) ->
  counter = (total, element) ->
    total++ if element is 0
    total
  reduce array, counter, 0

bits = [1, 0, 1, 0, 0, 1, 1, 1, 0]
show countZeroes bits

count = (test, array) ->
  reduce array, ((total, element) ->
    total + if test element then 1 else 0), 0

equals = (x) ->
  (element) -> x == element

countZeroes = (array) ->
  count equals(0), array

show countZeroes bits
show '--- End of Exercise ---'

# Map function
show '--- Map function ---'
map = (array, func) ->
  result = []
  forEach array, (element) ->
    result.push func element
  result

show map [0.01, 2, 9.89, Math.PI], Math.round

# Leave out result since forEach already returns it
map = (array, func) ->
  forEach array, (element) ->
    func element

# Leave out func arguments
map = (array, func) ->
  forEach array, func

# Leave out forEach arguments
map = forEach

# Could add return statement to forEach
show map [0.01, 2, 9.89, Math.PI], Math.round

# View an HTML page
show '--- View an HTML page ---'
viewURL '06-Quote.html'

# Alternative:
# viewServer '06-Quote.html'
# Or:
# viewServer stroustrupQuote
# Type `stopServer()` or Ctrl-C when done.
stroustrupQuote = readTextFile '06-Quote.html'
show stroustrupQuote

# Recluse file
show '--- Recluse file ---'
recluseFile = readTextFile "06-RecluseFile.text"

paragraphs = recluseFile.split "\n\n"
show "Found #{paragraphs.length} paragraphs."

# Exercise 22
show '--- Exercise 22 ---'
processParagraph = (paragraph) ->
  header = 0
  while paragraph[0] == '%'
    paragraph = paragraph.slice 1
    header++
  type: if header == 0 then 'p' else 'h' + header,
  content: paragraph

show processParagraph paragraphs[0]
show '--- End of Exercise ---'

# Process paragraph types
show '--- Process paragraph types ---'
paragraphs = map recluseFile.split('\n\n'),
                 processParagraph
show paragraphs[0..2]

# Exercise 23
show '--- Exercise 23 ---'
splitParagraph = (text) ->
  # Find character position or end of text
  indexOrEnd = (character) ->
    index = text.indexOf character
    if index == -1 then text.length else index

  # Return and remove text upto next special
  # character or end of text
  takeNormal = () ->
    end = reduce map(['*', '{'], indexOrEnd),
                 Math.min, text.length
    part = text.slice 0, end
    text = text.slice end
    part

  # Return and remove text upto character
  takeUpTo = (character) ->
    end = text.indexOf character, 1
    if end == -1
      throw new Error 'Missing closing ' +
                      '"' + character + '"'
    part = text.slice 1, end
    text = text.slice end + 1
    part

  fragments = [];

  while text != ''
    if text[0] == '*'
      fragments.push
        type: 'emphasised',
        content: takeUpTo '*'
    else if text[0] == '{'
      fragments.push
        type: 'footnote',
        content: takeUpTo '}'
    else
      fragments.push
        type: 'normal',
        content: takeNormal()
  fragments

takeNormalAlternative = () ->
  nextAsterisk = text.indexOf '*'
  nextBrace = text.indexOf '{'
  end = text.length
  if nextAsterisk != -1
    end = nextAsterisk
  if nextBrace != -1 and nextBrace < end
    end = nextBrace
  part = text.slice 0, end
  text = text.slice end
  part
show '--- End of Exercise ---'

# Adhoc test of splitParagraph
show '--- Adhoc test of splitParagraph ---'
processParagraph = (paragraph) ->
  header = 0
  while paragraph[0] == '%'
    paragraph = paragraph.slice 1
    header++
  type: if header == 0 then 'p' else 'h' + header,
  content: splitParagraph paragraph

# Adhoc test
recluseFile = readTextFile '06-RecluseFile.text'
paragraphs = map recluseFile.split('\n\n'),
                 processParagraph
show paragraphs, 3

# Handle footnotes
show '--- Handle footnotes ---'
extractFootnotes = (paragraphs) ->
  footnotes = []
  currentNote = 0
  replaceFootnote = (fragment) ->
    if fragment.type == 'footnote'
      ++currentNote
      footnotes.push fragment
      fragment.number = currentNote
      type: 'reference', number: currentNote
    else
      fragment

  forEach paragraphs, (paragraph) ->
    paragraph.content = map paragraph.content,
                            replaceFootnote
  footnotes

show '\nFootnotes from the recluse:'
show extractFootnotes paragraphs
show paragraphs[20], 3

# Link in string
show '--- Link in string ---'
url = "http://www.gokgs.com/"
text = "Play Go!"
linkText = "<a href=\"#{url}\">#{text}</a>"
show linkText

# Link in object
show '--- Link in object ---'
linkObject =
  name: 'a'
  attributes:
    href: 'http://www.gokgs.com/'
  content: ['Play Go!']
show linkObject

tag = (name, content, attributes) ->
  name: name
  attributes: attributes
  content: content

link = (target, text) ->
  tag "a", [text], href: target

show link "http://www.gokgs.com/", "Play Go!"

htmlDoc = (title, bodyContent) ->
  tag "html", [tag("head", [tag "title", [title]]),
               tag "body", bodyContent]

show htmlDoc "Quote", "In his house at R'lyeh " +
                      "dead Cthulu waits dreaming."

# Exercise 24
show '--- Exercise 24 ---'

image = (src) ->
  tag 'img', [], src: src

show image '../img/ostrich.jpg'
show '--- End of Exercise ---'

# Escape strings
show '--- Escape strings ---'
escapeHTML = (text) ->
  replacements = [[/&/g, '&amp;']
                  [/"/g, '&quot;']
                  [/</g, '&lt;']
                  [/>/g, '&gt;']]
  forEach replacements, (replace) ->
    text = text.replace replace[0], replace[1]
  text

show escapeHTML '< " & " >'

# Render HTML
show '--- Render HTML ---'
renderHTML = (element) ->
  pieces = []

  renderAttributes = (attributes) ->
    result = []
    if attributes
      for name of attributes 
        result.push ' ' + name + '="' +
          escapeHTML(attributes[name]) + '"'
    result.join ''

  render = (element) ->
    # Text node
    if typeof element is 'string'
      pieces.push escapeHTML element
    # Empty tag
    else if not element.content or
                element.content.length == 0
      pieces.push '<' + element.name +
        renderAttributes(element.attributes) + '/>'
    # Tag with content
    else
      pieces.push '<' + element.name +
        renderAttributes(element.attributes) + '>'
      forEach element.content, render
      pieces.push '</' + element.name + '>'

  render element
  pieces.join ''

show renderHTML link 'http://www.nedroid.com',
                     'Drawings!'

# View rendered HTML
show '--- View rendered HTML ---'
body = [tag('h1', ['The Test']),
        tag('p', ['Here is a paragraph ' +
                  'and an image...']),
        image('../img/ostrich.jpg')]
doc = htmlDoc 'The Test', body
show renderHTML doc
# Type `stopServer()` or Ctrl-C when done.
viewServer renderHTML doc

# Footnote tag
show '--- Footnote tag ---'
footnote = (number) ->
  tag 'sup',
    [link '#footnote' + number, String number]

show footnote(42), 3

# Exercise 25
show '--- Exercise 25 ---'
renderFragment = (fragment) ->
  if fragment.type == 'reference'
    footnote fragment.number
  else if fragment.type == 'emphasised'
    tag 'em', [fragment.content]
  else if fragment.type == 'normal'
    fragment.content

renderParagraph = (paragraph) ->
  tag paragraph.type,
    map paragraph.content, renderFragment

show renderParagraph paragraphs[7]
show '--- End of Exercise ---'

# View recluse file
show '--- View recluse file ---'
renderFootnote = (footnote) ->
  anchor = tag "a", [],
    name: "footnote" + footnote.number
  number = "[#{footnote.number}] "
  tag "p", [tag("small",
    [anchor, number, footnote.content])]

renderFile = (file, title) ->
  paragraphs = map file.split('\n\n'),
                   processParagraph
  footnotes = map extractFootnotes(paragraphs),
                  renderFootnote
  body = map paragraphs,
             renderParagraph
  body = body.concat footnotes
  renderHTML htmlDoc title, body

page = renderFile recluseFile, 'The Book of Programming'
show page
# Type `stopServer()` or Ctrl-C when done.
viewServer page

# Operator function
show '--- Operator function ---'
op = {
       '+':   (a, b) -> a + b
       '==':  (a, b) -> a == b
       '!':   (a)    -> !a
       # and so on
     }
show reduce [1..10], op['+'], 0

add = (a, b) -> a + b
show reduce [1..10], add, 0


# Partial function
show '--- Partial function ---'
partial = (func, a...) ->
  (b...) -> func a..., b...

f = (a,b,c,d) -> show "#{a} #{b} #{c} #{d}"
g = partial f, 1, 2
g 3, 4

equals10 = partial op['=='], 10
show map [1, 10, 100], equals10

# Partial reverse
show '--- Partial reverse ---'
square = (x) -> x * x
try
  show map [[10, 100], [12, 16], [0, 1]],
           partial map, square # Incorrect
catch error
  show error.message

partialReverse = (func, a) -> (b) -> func b, a

mapSquared = partialReverse map, square
show map [[10, 100], [12, 16], [0, 1]], mapSquared

show map [[10, 100], [12, 16], [0, 1]],
  (sublist) -> map sublist, (x) -> x * x

# Negate revisited
show '--- Negate revisited ---'
negate = (func) ->
  (args...) -> not func args...

# Compose function
show '--- Compose function ---'
compose = (func1, func2) ->
  (args...) -> func1 func2 args...

isUndefined = (value) -> value is undefined
isDefined = compose ((v) -> not v), isUndefined
show 'isDefined Math.PI  = ' + isDefined Math.PI
show 'isDefined Math.PIE = ' + isDefined Math.PIE

