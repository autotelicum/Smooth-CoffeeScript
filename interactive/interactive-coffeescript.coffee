

{CoffeeScript} = require 'coffee-script'
_ = require 'underscore'
CoffeeKup = require 'coffeekup'


show = console.log
showDocument = (doc, width, height) -> show doc

draw = (ctx) -> # ctx is an HTML5 Canvas context
  class Point
    constructor: (@x, @y) ->
    drawDisc: (context, style, size = 10) ->
      context.beginPath()
      context.fillStyle = style
      context.arc @x, @y, size, 0, 2*Math.PI, false
      context.fill()

  renderInStyle = (context, {back, front}, render) ->
    background = (context, style) ->
      context.beginPath()
      context.fillStyle = style
      context.fillRect 0, 0,
        context.canvas.width, context.canvas.height
    background context, back
    context.beginPath()
    context.fillStyle = front
    render()

  drawDrabSurface = (context, font, text, style) ->
    drawRepeatRotated = (angle = 0.2) ->
      context.save()
      context.rotate angle
      context.font = font
      distance = 2 * parseInt font, 10
      textWidth = context.measureText(text).width
      height = context.canvas.height
      for x in [0...context.canvas.width] by textWidth
        for y in [-height...height] by distance
          context.fillText text, x, y
      context.restore()
    renderInStyle context, style, drawRepeatRotated

  drawPreciousBrush = (context, lines, style) ->
    createCanvasContext = ({width, height}) ->
      canvas = document.createElement 'canvas'
      [canvas.width, canvas.height] = [width, height]
      canvas.getContext '2d'
    ctxBrush = createCanvasContext context.canvas
    renderInStyle ctxBrush, style, ->
      for {text, font, x, y} in lines
        ctxBrush.font = font
        ctxBrush.fillText text, x, y
      return
    context.createPattern ctxBrush.canvas, 'repeat'

  # Slight obfuscation. The ... converts an array to arguments
  decode = (nums) -> String.fromCharCode nums...
  [smallFont, bigFont] = ['12px sans-serif','52px sans-serif']
  surfaceText = 'CoffeeScript   ✵   Scratch Card  ✵  '
  hidden = [{x:15, y:100, font: bigFont, text: decode \
              [67,111,102,102,101,101,83,99,114,105,112,116]}
            {x:80, y:180, font: bigFont, text: decode \
              [73,116,39,115,32,106,117,115,116]}
            {x:30, y:260, font: bigFont, text: decode \
              [74,97,118,97,83,99,114,105,112,116,33]}
            {x:190, y:310, font: smallFont, text: decode \
              [68,79,85,66,76,69,80,76,85,83,71,79,79,68]}]
  brush = drawPreciousBrush ctx, hidden,
    back:'darkgrey', front:'grey'
  drawDrabSurface ctx, smallFont, surfaceText,
    back:'silver', front:'#663300'

  # Hook the brush up to mouse and touch events
  ctx.canvas.onmousemove = onmove = (evt) ->
    pos = new Point evt.pageX - ctx.canvas.offsetLeft,
                    evt.pageY - ctx.canvas.offsetTop
    pos.drawDisc ctx, brush
  ctx.canvas.ontouchmove = ontouch = (evt) ->
    evt.preventDefault() # Don't scroll on touch
    onmove touch for touch in evt.targetTouches
    return

# The CoffeeScript is about ⅔ the size of the JavaScript.
# Remove the # sign on the next line to see the JavaScript.
# show draw
webdesign = -> 
  doctype 5
  html ->
    head ->
      meta charset: 'utf-8'
      title 'My drawing | My awesome website'
      style '''
        body {font-family: sans-serif}
        header, nav, section, footer {display: block}
      '''
      coffeescript ->
        draw = (ctx, x, y) ->
          circle = (ctx, x, y) ->
            ctx.beginPath()
            ctx.arc x, y, 100, 0, 2*Math.PI, false
            ctx.stroke()
          ctx.strokeStyle = 'rgba(255,40,20,0.7)'
          circle ctx, x, y
          for angle in [0...2*Math.PI] by 1/3*Math.PI
            circle ctx, x+100*Math.cos(angle),
                        y+100*Math.sin(angle)
        window.onload = ->
          canvas = document.getElementById 'drawCanvas'
          context = canvas.getContext '2d'
          draw context, 300, 200
    body ->
      header -> h1 'Seed of Life'
      canvas id: 'drawCanvas', width: 550, height: 400

kup = if exports? then require 'coffeekup' else CoffeeKup
webpage = kup.render webdesign, format:on
showDocument webpage, 565, 500
show """
  Library            Version
------------------   -------------
Coffeescript         #{CoffeeScript.VERSION}
Underscore           #{_.VERSION}
CoffeeKup            #{CoffeeKup.version}
QuickCheck           qc.js-2009"""
# Show timing for compilation and execution of code blocks
@showTiming = off

# Variable names that are promoted from the execution
# environment to the global environment. These names can
# be used in other code blocks than where they are defined. 
@globalNames = 'Account HTML Rabbit _break _forEach absolute
 addCats addPoints addToSet between bits blackRabbit catData catNames
 catRecord deadCats escapeHTML estimatedDistance extractDate
 extractFootnotes extractMother fatRabbit findReached findRoute
 footnote forEach hasSevenTruths heightAt htmlDoc image killerRabbit
 link linkOstrich livingCats livingCats mailArchive makeReachedList
 makeRoad makeRoads map oldestCat op paragraph paragraphs partial
 point possibleDirections possibleRoutes power powerRec processParagraph
 range recluseFile reduce removeFromSet renderFootnote renderHTML
 renderParagraph retrieveMails roadsFrom route samePoint shortestRoute
 shortestRouteAbstract simpleObject speak splitParagraph square
 startsWith storeReached tag traverseRoute weightedDistance yell'

# An encoded picture of the signature ostrich. To obtain a base64
# encoding of a file run the CoffeeScript compiler like this:
# coffee -e "console.log require('fs').readFileSync('../img/ostrich.jpg').toString 'base64'"
@ostrich = ostrich = 'data:image/png;base64,/9j/4AAQSkZJRgABAgAAZABkAAD/7AARRHVja3kAAQAEAAAAHgAA/+4ADkFkb2JlAGTAAAAAAf/bAIQAEAsLCwwLEAwMEBcPDQ8XGxQQEBQbHxcXFxcXHx4XGhoaGhceHiMlJyUjHi8vMzMvL0BAQEBAQEBAQEBAQEBAQAERDw8RExEVEhIVFBEUERQaFBYWFBomGhocGhomMCMeHh4eIzArLicnJy4rNTUwMDU1QEA/QEBAQEBAQEBAQEBA/8AAEQgAWgBaAwEiAAIRAQMRAf/EAIYAAAIDAQEBAAAAAAAAAAAAAAQFAgMGAAEHAQEBAQEBAAAAAAAAAAAAAAACAQMABBAAAgEDAwIDBQYFBQEAAAAAAQIDABEEITESQQVhIhNRcYGhMrFCMxQVBpHBUmJDcqIjUzQ1EQACAgICAgIDAAAAAAAAAAAAARECITFBElFhcaHBIgP/2gAMAwEAAhEDEQA/AMtBEzW3o9ICBUsWG9qPWHTavPa2TZIDENx1qxI7WvRHEA6Uwwe1evxyMg8YL6KPqe32CopZXgAQAUdBBE/l4sQw/EPQ+FNJcjs+DFI6wxsVGq738LtSXJ/c8EbGD0OOPIBqAAyk+weyr19yTt6ITxMjFG3XehJUa2hNTHdcOWVTJo4urno69D764EMGN9msviLXvRiCyATcgLXNBSEnrameQnKhGxz7KdWFoFQsrbmir+J+mq0j81qK9Mf7aU5JBZiMRqaY+cwGYWKqeJA3FKYHKi23zptjIqQmVnLBgeSrp5RsdayssjQNI3AGQgkDUr1tUcvvxkUeivkQeXXa39tC5vcV+kPzXxFiPfQQMUqtYWO5+NKtfKC34LTm5mTxlPKXgeTCwVVHhrQjRnmVD+oSwW4Gt99KIWZorBVFiOJuP6tzTjHxsJceKZQpyI+DWUEkm9yoBsSRtTbjgmxNNjH8xxhQqIyRITtyP0r8qtORLCI1IvLExDBhbS2laTgmH6QCI6yHk6cbt6h6szgdTakWefWeQqi+RmvIu21+Itp8RU3tFiCw5MT8OZCO6huOttakGjlBEZ5eIpbMuRIy2GllBB95ozFj9MlmIUMblR0otJIqZJILtfeifQ+yjsSGOYC2/W1F/p/9w2oyywjLRMVfanU2eZYjBCllIs5OpNht4ClSY8ryqsQJdiAoHtphMpjurqL3N2F9TVbIjNZ6OkpO19Bapfp2Tr6ciyzqvqPDGSzKgsSSdtL6gUz9PEfuOOJyBCWHNjsF9poPP7aqZTMJAOOu41HRgeoNaK8RJy/n2mNrieOSjHkZivIXuQCfcafYYAaOc6kCykai/wBX2mhcbtU57eJuJtIzPbrw2U2rSdiwZAkWRIto7WWMDRr7tY1Hl4DoDZMhsmR52u8YW0SnzctW8NTyoKZLEgLxBbz21BtqSTWpzO0JLOkoJGOtiygnTieVh76Q9/xUSKXJwrLEt/VjB2c25Fajq5KmZ/IzURLfe020/hQP52d2trr93f7K8m5hwQnK4AG++9GxQKncIGVfTuoZhuAaWESLPOtfY8/bjZLLcxFkPW38603n/wCofT4UsTusMYCgC/Wwq39VHyvQ7L8izoSiBgbjQjYjeo5JkWKxJa/QnX505jxhuRQvcsc+g1h40SmYmkBewTfQAmtBidjxpcaOZoNRbmisWI5amyXtb3Vm/VBkCML67bWp3h50UMKoh5MDsGPEDfVSfsrRhXJr8bGUYrLJ5kItxPQW/lV0UsarwH+Py2pR23v8bERyNzhbdGN3S/3lc/Uvv1FB9+7zldqzA2NgPNBoWnflwcW2XhsffST1AX7NQ8SzQsDpyv8AZWRkR1xpo528zlkkVRYctdSPnWsxclMvt2PloCiTIHVTuAwBsay3fHwl/c2JiJzWSfi8jg+Tz3AFvtqXrMNcHVZn82F8ObkqcogRyBNzp0vQqyvLlGeQ2JOi/wBKjYU87/DFFkMuPYq44sx+pjsSvsFIVThLY73/AIVFz5E23Clx4GXM35A1d+Yb29KGRgwtVnE/KiU2CkBaHyQGjYFb6bVR+bFSE4kNuVvGo7I6GYzumPJFO9l4A6hfCgVyJkOjWp73lY/UK3Y3OrEaUhljYagfGtaOUgWUMmmfJGwJ1tsb6i/srYftv92RMq4eawZNk5bgezxFYU71wuCCDYjY0uq+Ayz7XFlYuTF/wlSg0BW1tPdSPuGUkOohDTqvGOZtBY3vyfw3rC9v/cWfgyrIrliNGF/qH91d3HvWZ3NzyuikWKA6W9nuotN40JdV7O7h3P8AMZhkXzKiiOM9NN2+Jr3Fj5ed73NDxQAbijYmCWtpUeoRVPIZGgA2tV1h8qEjmuas9Tx6UIYgh8hlFShmEikN10ub2A9ulUP8KPX/AOZ/i3P4P4m33qOCiPNZg11tx0A1NhQWQxMY06EUc/8A5D/q+Hx8aAyfxW3361tUFtgbC1QNTPwrw/CtDM4UVjRlt/hQw26Uww/o6UWVFuwr0Iz2C163wonF3H00Bl2LgXF2or9NTxojH2G3woj+FZ/tI8H/2Q=='

# When changes are made in a code block, only that block is
# evaluated. Turning this `off` will cause an evaluation of all
# code in the book on *every* keystroke. Only for articles.
@incrementalEvaluation = on

# Dummy definitions for standalone execution
if exports?
  view = show
  runOnDemand = confirm = prompt = ->
total = 0
count = 1
while count <= 10
  total += count
  count += 1
total
total = 0
total += count for count in [1..10]
total
# Summation using a reduce function
sum = (v) -> _.reduce v, ((a,b) -> a+b), 0
sum [1..10]
# Summation using reduce attached to Array
Array::sum = -> @reduce ((a,b) -> a+b), 0
show [1..10].sum()
delete Array::sum
144
9.81
2.998e8
100 + 4 * 11
(100 + 4) * 11
# Compose a solution here
'Patch my boat with chewing gum.'
'The programmer pondered: "0x2b or not 0x2b"'
"Aha! It's 43 if I'm not a bit off"
"2 + 2 gives #{2 + 2}"
'Imagine if this was a
 very long line of text'
'''First comes A
   then comes B'''
"""Math 101:
     1
   + 1
   ---
     #{1 + 1}"""
'This is the first line\nAnd this is the second'
'A newline character is written like "\\n".'
'con' + 'cat' + 'e' + 'nate'
typeof 4.5
-(10 - 2)
3 > 2
3 < 2
100 < 115 < 200
100 < 315 < 200
'Aardvark' < 'Zoroaster'
'Itchy' isnt 'Scratchy'
true and false
true or false
# Compose a solution here
(false or true) and not (false and true)
true and not false
true
1; not false
caught = 5 * 5
caught = 4 * 4
luigiDebt = 140
luigiDebt = luigiDebt - 35
show 'Also, your hair is on fire.'
show Math.max 2, 4
show 100 + Math.max 7, 4
show Math.max(7, 4) + 100
show Math.max(7, 4 + 100)
show Math.max 7, 4 + 100
show Math.PI
show console if console?
show showDocument
show 1 + 2 + 3 + 4 + 5 + view 6 + 7
confirm 'Shall we, then?', (answer) -> show answer
prompt 'Tell us everything you know', '...',
  (answer) -> show 'So you know: ' + answer
prompt 'Pick a number', '', (answer) ->
  theNumber = Number answer
  show 'Your number is the square root of ' +
    (theNumber * theNumber)
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
# Compose a solution here
result = 1
counter = 0
while counter < 10
  result = result * 2
  counter = counter + 1
show result
# Compose a solution here
line = ''
counter = 0
while counter < 10
  line = line + '#'
  show line
  counter = counter + 1
for number in [0..12] by 2 then show number
# For with indented body
for number in [0..12] by 2
  show number
# For with prepended body
show number for number in [0..12] by 2
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
# Compose a solution here
result = 1
for counter in [0...10]
  result = result * 2
show result
line = ''
for counter in [0...10]
  line = line + '#'
  show line
for counter in [0..20]
  if counter % 3 is 0 and counter % 4 is 0
    show counter
for counter in [0..20]
  if counter % 4 is 0
    show counter
  if counter % 4 isnt 0
    show '(' + counter + ')'
for counter in [0..20]
  if counter % 4 is 0
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
# Compose a solution here
prompt 'You! What is the value of 2 + 2?', '',
  (answer) ->
    if answer is '4'
      show 'You must be a genius or something.'
    else if answer is '3' or answer is '5'
      show 'Almost!'
    else
      show 'You are an embarrassment.'
fun = on
show 'The show is on!' unless fun is off
current = 20
loop
  if current % 7 is 0
    break
  current++
show current
current = 20
current++ until current % 7 is 0
show current
roll = Math.floor Math.random() * 6 + 1
# Compose a solution here
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
show mysteryVariable
mysteryVariable = 'nothing'
show show 'I am a side effect.'
show iam ? undefined
iam ?= 'I want to be'
show iam
iam ?= 'I am already'
show iam if iam?
show false == 0
show '' == 0
show '5' == 5
show `null === undefined`
show `false === 0`
show `'' === 0`
show `'5' === 5`
show 'Apollo' + 5
show null + 'ify'
show '5' * 5
show 'strawberry' * 5
show Number('5') * 5
prompt 'What is your name?', '',
  (input) -> show 'Well hello ' + (input or 'dear')
false or show 'I am happening!'
true  or show 'Not me.'
add = (a, b) -> a + b
add 2, 2
power = (base, exponent) ->
  result = 1
  for count in [0...exponent]
    result *= base
  result
power 2, 10
# Compose a solution here
absolute = (number) ->
  if number < 0
    -number
  else
    number
absolute -144
runOnDemand -> # Create the Run button further down
  testAbsolute = (name, property) ->
    testPure absolute, [arbInt], name, property

  testAbsolute 'returns positive integers',
    (c, arg, result) ->
      result >= 0

  testAbsolute 'positive returns positive',
    (c, arg, result) ->
      c.guard arg >= 0
      result is arg

  testAbsolute 'negative returns positive',
    (c, arg, result) ->
      c.guard arg < 0
      result is -arg

  test()
runOnDemand ->
  testPure power, [arbInt, arbInt],
    'power equals Math.pow for integers',
    (c, base, exponent, result) ->
      result is c.note Math.pow base, exponent
  test()
runOnDemand ->
  testPure power, [arbWholeNum, arbWholeNum],
    'power equals Math.pow for positive integers',
    (c, base, exponent, result) ->
      result is c.note Math.pow base, exponent
  test()
intensify = (n) ->
  2

runOnDemand ->
  testPure intensify, [arbInt],
    'intensify grows by 2 when positive',
    (c, arg, result) ->
      c.guard arg > 0
      arg + 2 is result
  
  testPure intensify, [arbInt],
    'intensify grows by 2 when negative',
    (c, arg, result) ->
      c.guard arg < 0
      arg - 2 is result
  
  testPure intensify, [arbConst(0)],
    'only non-zero intensify grows',
    (c, arg, result) ->
      result is 0
  
  test()
intensify = (n) ->
  if n > 0
    n + 2
  else if n < 0
    n - 2
  else
    n
yell = (message) ->
  view message + '!!'
  return
yell 'Yow'
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
variable = 'first'                    # Definition

showVariable = ->
  show 'In showVariable, the variable holds: ' +
        variable                      # second

testIt = ->
  variable = 'second'                 # Assignment
  show 'In test, the variable holds ' +
       variable + '.'                 # second
  showVariable()

show 'The variable is: ' + variable   # first
testIt()
show 'The variable is: ' + variable   # second
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
varWhich = 'top-level'
parentFunction = ->
  varWhich = 'local'
  childFunction = ->
    show varWhich
  childFunction
child = parentFunction()
child()
makeAddFunction = (amount) ->
  add = (number) -> number + amount

addTwo = makeAddFunction 2
addFive = makeAddFunction 5
show addTwo(1) + addFive(1)
powerRec = (base, exponent) ->
  if exponent is 0
    1
  else
    base * powerRec base, exponent - 1
show 'power 3, 3 = ' + powerRec 3, 3
timeIt = (func) ->
  start = new Date()
  for i in [0...1000000] then func()
  show "Timing: #{(new Date() - start)*0.001}s"

add = (n, m) -> n + m # Baseline comparison

runOnDemand ->
  timeIt -> p = add 9,18                # 0.042s
  timeIt -> p = Math.pow 9,18           # 0.049s
  timeIt -> p = power 9,18              # 0.464s
  timeIt -> p = powerRec 9,18           # 0.544s
chicken = ->
  show 'Lay an egg'
  egg()

egg = ->
  show 'Chick hatched'
  chicken()

# WARNING! Clicking `Run` may cause your
# browser to enter a catatonic state
runOnDemand ->
  try show chicken() + ' came first.'
  catch error then show error.message
findSequence = (goal) ->
  find = (start, history) ->
    if start is goal
      history
    else if start > goal
      null
    else
      find(start + 5, '(' + history + ' + 5)') ? \
      find(start * 3, '(' + history + ' * 3)')
  find 1, '1'
show findSequence 24
makeAddFunction = (amount) ->
  (number) -> number + amount

show makeAddFunction(11) 3
# Compose a solution here
greaterThan = (x) ->
  (y) -> y > x

greaterThanTen = greaterThan 10
show greaterThanTen 9
yell 'Hello', 'Good Evening', 'How do you do?'
yell()
console?.log 'R', 2, 'D', 2
text = 'purple haze'
show text['length']
show text.length
nothing = null
try show nothing.length catch error then show error.message
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
chineseBox = {}
chineseBox.content = chineseBox
show 'content' of chineseBox
show 'content' of chineseBox.content
show chineseBox
abyss = {lets:1, go:deep:down:into:the:abyss:7}
show abyss
show abyss, on
# Compose a solution here
set = {'Spot': true}
# Add 'White Fang' to the set
set['White Fang'] = true
# Remove 'Spot'
delete set['Spot']
# See if 'Asoka' is in the set
show 'Asoka' of set
object1 = {value: 10}
object2 = object1
object3 = {value: 10}

show object1 is object2
show object1 is object3

object1.value = 15
show object2.value
show object3.value
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
mailArchive = ['mail one', 'mail two', 'mail three']

for current in [0...mailArchive.length]
  show 'Processing e-mail #' + current +
       ': ' + mailArchive[current]
# Compose a solution here
range = (upto) ->
  result = []
  i = 0
  while i <= upto
    result[i] = i
    i++
  result
show range 4
range = (upto) -> i for i in [0..upto]
show range 4
range = (upto) -> [0..upto]
show range 4
numbers = (number for number in [0..12] by 2)
show numbers
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
retrieveMails = -> [
  "Nephew,\n\nI bought a computer as soon as I received your letter. It took me two days to make it do 'internet', but I just kept calling the nice man at the computer shop, and in the end he came down to help personally. Send me something back if you receive this, so I know whether it actually works.\n\nLove,\nAunt Emily"
  "Dear Nephew,\n\nVery good! I feel quite proud about being so technologically minded, having a computer and all. I bet Mrs. Goor down the street wouldn't even know how to plug it in, that witch.\n\nAnyway, thanks for sending me that game, it was great fun. After three days, I beat it. My friend Mrs. Johnson was quite worried when I didn't come outside or answer the phone for three days, but I explained to her that I was working with my computer.\n\nMy cat had two kittens yesterday! I didn't even realize the thing was pregnant. I've listed the names at the bottom of my letter, so that you will know how to greet them the next time you come over.\n\nSincerely,\nAunt Emily\n\nborn 15/02/1999 (mother Spot): Clementine, Fireball"
  "[... and so on ...]\n\nborn 21/09/2000 (mother Spot): Yellow Emperor, Black Leclère"
  "...\n\nborn 02/04/2001 (mother Clementine): Bugeye, Wolverine, Miss Bushtail"
  "...\n\ndied 12/12/2002: Clementine\n\ndied 15/12/2002: Wolverine"
  "...\n\nborn 15/11/2003 (mother Spot): White Fang"
  "...\n\nborn 10/04/2003 (mother Miss Bushtail): Yellow Bess"
  "...\n\ndied 30/05/2004: Yellow Emperor"
  "...\n\nborn 01/06/2004 (mother Miss Bushtail): Catharina, Fat Igor"
  "...\n\nborn 20/09/2004 (mother Yellow Bess): Doctor Hobbles the 2nd, Noog"
  "...\n\nborn 15/01/2005 (mother Yellow Bess): The Moose, Liger\n\ndied 17/01/2005: Liger"
  "Dear nephew,\n\nYour mother told me you have taken up skydiving. Is this true? You watch yourself, young man! Remember what happened to my husband? And that was only from the second floor!\n\nAnyway, things are very exciting here. I have spent all week trying to get the attention of Mr. Drake, the nice gentleman who moved in next\ndoor, but I think he is afraid of cats. Or allergic to them? I am\ngoing to try putting Fat Igor on his shoulder next time I see him, very curious what will happen.\n\nAlso, the scam I told you about is going better than expected. I have already gotten back five 'payments', and only one complaint. It is starting to make me feel a bit bad though. And you are right that it is probably illegal in some way.\n\n(... etc ...)\n\nMuch love,\nAunt Emily\n\ndied 27/04/2006: Black Leclère\n\nborn 05/04/2006 (mother Lady Penelope): Red Lion, Doctor Hobbles the 3rd, Little Iroquois"
  "...\n\nborn 22/07/2006 (mother Noog): Goblin, Reginald, Little Maggie"
  "...\n\ndied 13/02/2007: Spot\n\ndied 21/02/2007: Fireball"
  "...\n\nborn 05/02/2007 (mother Noog): Long-ear Johnson"
  "...\n\nborn 03/03/2007 (mother Catharina): Asoka, Dark Empress, Rabbitface"
]
mailArchive = retrieveMails()

for email, i in mailArchive
  show "Processing e-mail ##{i} #{email[0..15]}..."
  # Do more things...
words = 'Cities of the Interior'
show words.split ' '
# Compose a solution here
array = ['a', 'b', 'c d']
show array.join(' ').split(' ')
paragraph = 'born 15-11-2003 (mother Spot): White Fang'
show paragraph.charAt(0) is 'b' and
     paragraph.charAt(1) is 'o' and
     paragraph.charAt(2) is 'r' and
     paragraph.charAt(3) is 'n'
show paragraph.slice(0, 4) is 'born'
show paragraph[0...4] is 'born'
# Compose a solution here
startsWith = (string, pattern) ->
  string.slice(0, pattern.length) is pattern
# or
startsWith = (string, pattern) ->
  string[0...pattern.length] is pattern
show startsWith 'rotation', 'rot'
show 'Pip'.charAt 250
show 'Nop'.slice 1, 10
show 'Pin'[1...10]
# Compose a solution here
catNames = (paragraph) ->
  colon = paragraph.indexOf ':'
  paragraph[colon+2...].split ', '

show catNames 'born 20/09/2004 (mother Yellow Bess): ' +
              'Doctor Hobbles the 2nd, Noog'
mailArchive = retrieveMails()
livingCats = 'Spot': true

for email, i in mailArchive
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

show livingCats, on
if 'Spot' in livingCats
  show 'Spot lives!'
else
  show 'Good old Spot, may she rest in peace.'
for cat of livingCats
  show cat
addToSet = (set, values) ->
  for i in [0..values.length]
    set[values[i]] = true

removeFromSet = (set, values) ->
  for i in [0..values.length]
    delete set[values[i]]
livingCats = 'Spot': true

for email in mailArchive
  paragraphs = email.split '\n'
  for paragraph in paragraphs
    if startsWith paragraph, 'born'
      addToSet livingCats, catNames paragraph
    else if startsWith paragraph, 'died'
      removeFromSet livingCats, catNames paragraph

show livingCats, on
findLivingCats = ->
  mailArchive = retrieveMails()
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
whenWasIt = year: 1980, month: 2, day: 1
whenWasIt = new Date 1980, 1, 1
show whenWasIt
show new Date
show new Date 1980, 1, 1
show new Date 2007, 2, 30, 8, 20, 30
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
wallFall = new Date 1989, 10, 9
gulfWarOne = new Date 1990, 6, 2
show wallFall < gulfWarOne
show wallFall is wallFall
# but
show wallFall is new Date 1989, 10, 9
wallFall1 = new Date 1989, 10, 9
wallFall2 = new Date 1989, 10, 9
show wallFall1.getTime() is wallFall2.getTime()
now = new Date()
show now.getTimezoneOffset()
# Compose a solution here
extractDate = (paragraph) ->
  numberAt = (start, length) ->
    Number paragraph[start...start + length]
  new Date numberAt(11, 4),     # Year
           numberAt( 8, 2) - 1, # Month
           numberAt( 5, 2)      # Day

show extractDate 'died 27-04-2006: Black Leclère'
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
'born 15/11/2003 (mother Spot): White Fang'
extractMother = (paragraph) ->
  start = paragraph.indexOf '(mother '
  start += '(mother '.length
  end = paragraph.indexOf ')'
  paragraph[start...end]

show extractMother \
  'born 15/11/2003 (mother Spot): White Fang'
# Compose a solution here
between = (string, start, end) ->
  startAt = string.indexOf start
  startAt += start.length
  endAt = string.indexOf end, startAt
  string[startAt...endAt]
show between 'bu ] boo [ bah ] gzz', '[ ', ' ]'
extractMother = (paragraph) ->
  between paragraph, '(mother ', ')'
findCats = ->
  mailArchive = retrieveMails()
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

show catData['Clementine'], on
show catData[catData['Clementine'].mother], on
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
# Compose a solution here
formatDate = (date) ->
  pad = (number) ->
    if number < 10
      "0" + number
    else
      number
  "#{pad date.getDate()}/" +
  "#{pad date.getMonth() + 1}/" +
  "#{date.getFullYear()}"

show formatDate new Date 2000, 0, 1
# Compose a solution here
oldestCat = (data) ->
  oldest = null
  for name of data
    cat = data[name]
    unless 'death' of cat
      if oldest is null or oldest.birth > cat.birth
        oldest = cat
  oldest?.name
show oldestCat catData
for cat, info of catData # Test with dead cats
  delete catData[cat] unless 'death' of info
show oldestCat catData
argumentCounter = ->
  show "You gave me #{arguments.length} arguments."

argumentCounter "Death", "Famine", "Pestilence"
print = ->
  show arg for arg in arguments
  return

print 'From here to', 1/0
add = (number, howmuch) ->
  if  arguments.length < 2
    howmuch = 1
  number + howmuch

show add 6
show add 6, 4
# Compose a solution here
range = (start, end) ->
  if arguments.length < 2
    end = start
    start = 0
  result = []
  for i in [start..end]
    result.push i
  result

show range 4
show range 2, 4
# Compose a solution here
sum = (numbers) ->
  total = 0
  for num in numbers
    total += num
  total

show sum [1..10]
show sum range 1, 10
for name of Math
  show name
for name of ['Huey', 'Dewey', 'Loui']
  show name
array = ['Heaven', 'Earth', 'Man']
array.length = 2
show array
power = (base, exponent) ->
  result = 1
  for count in [0...exponent]
    result *= base
  result
between = (string, start, end) ->
  startAt = string.indexOf start
  startAt += start.length 
  endAt = string.indexOf end, startAt
  string[startAt...endAt]
show between 'Your mother!', '{-', '-}'
between = (string, start, end) ->
  startAt = string.indexOf start
  if startAt is -1 then return
  startAt += start.length
  endAt = string.indexOf end, startAt
  if endAt is -1 then return
  string[startAt...endAt]

show between 'bu ] boo [ bah ] gzz', '[ ', ' ]'
show between 'bu [ boo bah gzz', '[ ', ' ]'
prompt "Tell me something", "", (answer) ->
  parenthesized = between answer, "(", ")"
  if parenthesized?
    show "You parenthesized '#{parenthesized}'."
lastElement = (array) ->
  if array.length > 0
    array[array.length - 1]
  else
    undefined
show lastElement [1, 2, undefined]
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
currentThing = null

processThing = (thing) ->
  if currentThing isnt null
    throw 'Oh no! We are already processing a thing!'

  currentThing = thing
  # do complicated processing...
  currentThing = null
processThing = (thing) ->
  if currentThing isnt null
    throw 'Oh no! We are already processing a thing!'

  currentThing = thing
  try
    # do complicated processing...
  finally
    currentThing = null
try
  show Sasquatch
catch error
  show 'Caught: ' + error.message
try
  throw new Error 'Fire!'
catch error
  show error.toString()
FoundSeven = {}
hasSevenTruths = (object) ->
  counted = 0
  count = (object) ->
    for name of object
      if object[name] is true
        if (++counted) is 7
          throw FoundSeven
      if typeof object[name] is 'object'
        count object[name]
  try
    count object
    return false
  catch exception
    if exception isnt FoundSeven
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
# Say we have:
thing = [5..7]
doSomething = show

# then
for i in [0...thing.length] then doSomething thing[i]
# or better - you can see the generated code with: show -> \
for element in thing then doSomething element
printArray = (array) ->
  for element in array
    show element
  return

printArray [7..9]
forEach = (array, action) ->
  for element in array
    action element
  #return

forEach ['Wampeter', 'Foma', 'Granfalloon'], show
runOnDemand -> show forEach # View generated code
sum = (numbers) ->
  total = 0
  forEach numbers, (number) -> total += number
  total
show sum [1, 10, 100]
negate = (func) ->
  (x) -> not func x

isNotNaN = negate isNaN
show isNotNaN NaN
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
reduce = (array, combine, base) ->
  forEach array, (element) ->
    base = combine base, element
  base

add = (a, b) -> a + b
sum = (numbers) -> reduce numbers, add, 0
show sum [1, 10, 100]
# Compose a solution here
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
  (element) -> x is element

countZeroes = (array) ->
  count equals(0), array

show countZeroes bits
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

show map [0.01, 2, 9.89, Math.PI], Math.round
# You could access a picture with its URL
imageSource = 'http://autotelicum.github.com/Smooth-CoffeeScript'
linkOstrich = "#{imageSource}/img/ostrich.jpg"

# But I will use a predefined image to avoid a server round-trip
showDocument """
<!DOCTYPE HTML>
<html>
  <head>
    <meta charset="utf-8"/>
    <title>A quote</title>
  </head>
  <body>
    <h1>A quote</h1>
    <blockquote>
      <p>The connection between the language in which we
      think/program and the problems and solutions we can
      imagine is very close. For this reason restricting
      language features with the intent of eliminating
      programmer errors is at best dangerous.</p>
      <p>-- Bjarne Stroustrup</p>
    </blockquote>
    <p>Mr. Stroustrup is the inventor of the C++
    programming language, but quite an insightful
    person nevertheless.</p>
    <p>Also, here is a picture of an ostrich:</p>
    <img src="#{ostrich}"/>
  </body>
</html>
""", 565, 420
recluseFile = """
% The Book of Programming

%% The Two Aspects

Below the surface of the machine, the program moves.
Without effort, it expands and contracts. In great harmony, 
electrons scatter and regroup. The forms on the monitor
are but ripples on the water. The essence stays invisibly
below.

When the creators built the machine, they put in the
processor and the memory. From these arise the two aspects
of the program.

The aspect of the processor is the active substance. It is
called Control. The aspect of the memory is the passive 
substance. It is called Data.

Data is made of merely bits, yet it takes complex forms.
Control consists only of simple instructions, yet it
performs difficult tasks. From the small and trivial, the
large and complex arise.

The program source is Data. Control arises from it. The
Control proceeds to create new Data. The one is born from
the other, the other is useless without the one. This is
the harmonious cycle of Data and Control.

Of themselves, Data and Control are without structure. The
programmers of old moulded their programs out of this raw
substance. Over time, the amorphous Data has crystallised
into data types, and the chaotic Control was restricted
into control structures and functions.

%% Short Sayings

When a student asked Fu-Tzu about the nature of the cycle
of Data and Control, Fu-Tzu replied 'Think of a compiler,
compiling itself.'

A student asked 'The programmers of old used only simple
machines and no programming languages, yet they made
beautiful programs. Why do we use complicated machines
and programming languages?'. Fu-Tzu replied 'The builders
of old used only sticks and clay, yet they made beautiful
huts.'

A hermit spent ten years writing a program. 'My program can
compute the motion of the stars on a 286-computer running
MS DOS', he proudly announced. 'Nobody owns a 286-computer
or uses MS DOS anymore.', Fu-Tzu responded.

Fu-Tzu had written a small program that was full of global
state and dubious shortcuts. Reading it, a student asked
'You warned us against these techniques, yet I find them in
your program. How can this be?' Fu-Tzu said 'There is no
need to fetch a water hose when the house is not on fire.'
{This is not to be read as an encouragement of sloppy
programming, but rather as a warning against neurotic
adherence to rules of thumb.}

%% Wisdom

A student was complaining about digital numbers. 'When I
take the root of two and then square it again, the result
is already inaccurate!'. Overhearing him, Fu-Tzu laughed.
'Here is a sheet of paper. Write down the precise value of
the square root of two for me.'

Fu-Tzu said 'When you cut against the grain of the wood,
much strength is needed. When you program against the grain
of a problem, much code is needed.'

Tzu-li and Tzu-ssu were boasting about the size of their
latest programs. 'Two-hundred thousand lines', said Tzu-li,
'not counting comments!'. 'Psah', said Tzu-ssu, 'mine is
almost a *million* lines already.' Fu-Tzu said 'My best
program has five hundred lines.' Hearing this, Tzu-li and
Tzu-ssu were enlightened.

A student had been sitting motionless behind his computer
for hours, frowning darkly. He was trying to write a
beautiful solution to a difficult problem, but could not
find the right approach. Fu-Tzu hit him on the back of his
head and shouted '*Type something!*' The student started
writing an ugly solution. After he had finished, he
suddenly understood the beautiful solution.

%% Progression

A beginning programmer writes his programs like an ant
builds her hill, one piece at a time, without thought for
the bigger structure. His programs will be like loose sand.
They may stand for a while, but growing too big they fall
apart{Referring to the danger of internal inconsistency
and duplicated structure in unorganised code.}.

Realising this problem, the programmer will start to spend
a lot of time thinking about structure. His programs will
be rigidly structured, like rock sculptures. They are solid,
but when they must change, violence must be done to them
{Referring to the fact that structure tends to put
restrictions on the evolution of a program.}.

The master programmer knows when to apply structure and
when to leave things in their simple form. His programs
are like clay, solid yet malleable.

%% Language

When a programming language is created, it is given
syntax and semantics. The syntax describes the form of
the program, the semantics describe the function. When the
syntax is beautiful and the semantics are clear, the
program will be like a stately tree. When the syntax is
clumsy and the semantics confusing, the program will be
like a bramble bush.

Tzu-ssu was asked to write a program in the language
called  Java, which takes a very primitive approach to
functions. Every morning, as he sat down in front of his
computer, he started complaining. All day he cursed,
blaming the language for all that went wrong. Fu-Tzu
listened for a while, and then reproached him, saying
'Every language has its own way. Follow its form, do not
try to program as if you were using another language.'
"""
show # 'The End'
paragraphs = recluseFile.split "\n\n"
show "Found #{paragraphs.length} paragraphs."
# Compose a solution here
processParagraph = (paragraph) ->
  header = 0
  while paragraph[0] is '%'
    paragraph = paragraph.slice 1
    header++
  type: if header is 0 then 'p' else 'h' + header,
  content: paragraph

show processParagraph paragraphs[0]
paragraphs = map recluseFile.split('\n\n'),
                 processParagraph
show paragraph for paragraph in paragraphs[0..2]
# Compose a solution here
splitParagraph = (text) ->
  # Find character position or end of text
  indexOrEnd = (character) ->
    index = text.indexOf character
    if index is -1 then text.length else index

  # Return and remove text upto next special
  # character or end of text
  takeNormal = ->
    end = reduce map(['*', '{'], indexOrEnd),
                 Math.min, text.length
    part = text.slice 0, end
    text = text.slice end
    part

  # Return and remove text upto character
  takeUpTo = (character) ->
    end = text.indexOf character, 1
    if end is -1
      throw new Error 'Missing closing ' +
                      '"' + character + '"'
    part = text.slice 1, end
    text = text.slice end + 1
    part

  fragments = [];

  while text isnt ''
    if text[0] is '*'
      fragments.push
        type: 'emphasised',
        content: takeUpTo '*'
    else if text[0] is '{'
      fragments.push
        type: 'footnote',
        content: takeUpTo '}'
    else
      fragments.push
        type: 'normal',
        content: takeNormal()
  fragments
takeNormalAlternative = ->
  nextAsterisk = text.indexOf '*'
  nextBrace = text.indexOf '{'
  end = text.length
  if nextAsterisk isnt -1
    end = nextAsterisk
  if nextBrace isnt -1 and nextBrace < end
    end = nextBrace
  part = text.slice 0, end
  text = text.slice end
  part
processParagraph = (paragraph) ->
  header = 0
  while paragraph[0] is '%'
    paragraph = paragraph.slice 1
    header++
  type: if header is 0 then 'p' else 'h' + header,
  content: splitParagraph paragraph

# Adhoc test
paragraphs = map recluseFile.split('\n\n'),
                 processParagraph
show paragraph for paragraph in paragraphs[0..2]
extractFootnotes = (paragraphs) ->
  footnotes = []
  currentNote = 0
  replaceFootnote = (fragment) ->
    if fragment.type is 'footnote'
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

show 'Footnotes from the recluse:'
show extractFootnotes paragraphs
show paragraphs[20]
url = "http://www.gokgs.com/"
text = "Play Go!"
linkText = "<a href=\"#{url}\">#{text}</a>"
show _.escape linkText
# Without the _.escape it becomes a link
show linkText
linkObject =
  name: 'a'
  attributes:
    href: 'http://www.gokgs.com/'
  content: ['Play Go!']
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
# Compose a solution here
image = (src) ->
  tag 'img', [], src: src

show image linkOstrich
escapeHTML = (text) ->
  replacements = [[/&/g, '&amp;']
                  [/"/g, '&quot;']
                  [/</g, '&lt;']
                  [/>/g, '&gt;']]
  forEach replacements, (replace) ->
    text = text?.replace replace[0], replace[1]
  text

show escapeHTML '< " & " >'
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
                element.content.length is 0
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
show renderHTML link 'http://www.nedroid.com', 'Drawings!'
body = [tag('h1', ['The Test']),
        tag('p', ['Here is a paragraph ' +
                  'and an image...']),
        image(ostrich)]
doc = htmlDoc 'The Test', body
show renderHTML doc
footnote = (number) ->
  tag 'sup',
    [link '#footnote' + number, String number]

show footnote(42), 3
# Compose a solution here
renderFragment = (fragment) ->
  if fragment.type is 'reference'
    footnote fragment.number
  else if fragment.type is 'emphasised'
    tag 'em', [fragment.content]
  else if fragment.type is 'normal'
    fragment.content

renderParagraph = (paragraph) ->
  tag paragraph.type,
    map paragraph.content, renderFragment

show renderParagraph paragraphs[7]
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

runOnDemand ->
  page = renderFile recluseFile, 'The Book of Programming'
  showDocument page, 565, 500
op = {
       '+':   (a, b) -> a + b
       '==':  (a, b) -> a == b
       '!':   (a)    -> !a
       # and so on
     }
show reduce [1..10], op['+'], 0
add = (a, b) -> a + b
show reduce [1..10], add, 0
partial = (func, a...) ->
  (b...) -> func a..., b...

f = (a,b,c,d) -> show "#{a} #{b} #{c} #{d}"
g = partial f, 1, 2
g 3, 4
equals10 = partial op['=='], 10
show map [1, 10, 100], equals10
square = (x) -> x * x
try
  show map [[10, 100], [12, 16], [0, 1]],
           partial map, square # Incorrect
catch error
  show "Error: #{error.message}"
partialReverse = (func, a) -> (b) -> func b, a

mapSquared = partialReverse map, square
show map [[10, 100], [12, 16], [0, 1]], mapSquared
show map [[10, 100], [12, 16], [0, 1]],
  (sublist) -> map sublist, (x) -> x * x
negate = (func) ->
  (args...) -> not func args...
compose = (func1, func2) ->
  (args...) -> func1 func2 args...

isUndefined = (value) -> value is undefined
isDefined = compose ((v) -> not v), isUndefined
show 'isDefined Math.PI  = ' + isDefined Math.PI
show 'isDefined Math.PIE = ' + isDefined Math.PIE
# List functions in Underscore
runOnDemand -> show _.functions _
show roads = [
  { point1: 'Point Kiukiu', point2: 'Hanaiapa', length: 19 }
  { point1: 'Point Kiukiu', point2: 'Mt Feani', length: 15 }
] # and so on
show roads =
  'Point Kiukiu': [ {to: 'Hanaiapa', distance: 19}
                    {to: 'Mt Feani', distance: 15}
                    {to: 'Taaoa', distance: 15} ]
  'Taaoa':        [ ] # et cetera
@roads = {}
makeRoad = (from, to, length) ->
  addRoad = (from, to) ->
    roads[from] = [] if not (from of roads)
    roads[from].push to: to, distance: length
  addRoad from, to
  addRoad to, from
makeRoad 'Point Kiukiu', 'Hanaiapa', 19
makeRoad 'Point Kiukiu', 'Mt Feani', 15
makeRoad 'Point Kiukiu', 'Taaoa', 15
show roads
# Compose a solution here
makeRoads = (start) ->
  for i in [1...arguments.length] by 2
    makeRoad start, arguments[i], arguments[i + 1]
@roads = {}
makeRoads 'Point Kiukiu',
  'Hanaiapa', 19, 'Mt Feani', 15, 'Taaoa', 15
makeRoads 'Airport',
  'Hanaiapa', 6, 'Mt Feani', 5,
  'Atuona', 4, 'Mt Ootua', 11
makeRoads 'Mt Temetiu',
  'Mt Feani', 8, 'Taaoa', 4
makeRoads 'Atuona',
  'Taaoa', 3, 'Hanakee pearl lodge', 1
makeRoads 'Cemetery',
  'Hanakee pearl lodge', 6, 'Mt Ootua', 5
makeRoads 'Hanapaoa',
  'Mt Ootua', 3
makeRoads 'Puamua',
  'Mt Ootua', 13, 'Point Teohotepapapa', 14
show 'Roads from the Airport:'
show roads['Airport']
roadsFrom = (place) ->
  found = roads[place]
  return found if found?
  throw new Error "No place named '#{place}' found."
    
try
  show roadsFrom "Hanaiapa"
  show roadsFrom "Hanalapa"
catch error
  show "Oops #{error}"
gamblerPath = (from, to) ->

  randomInteger = (below) ->
    Math.floor Math.random() * below

  randomDirection = (from) ->
    options = roadsFrom from
    options[randomInteger(options.length)].to

  path = []
  loop
    path.push from
    break if from is to
    from = randomDirection from
  path

show gamblerPath 'Hanaiapa', 'Mt Feani'
_member = (array, value) ->
  found = false
  array.forEach (element) ->
    if element is value
      found = true
  found
show _member [6, 7, "Bordeaux"], 7
_break = toString: -> "Break"
_forEach = (array, action) ->
  try
    for element in array
      action element
  catch exception
    if exception isnt _break
      throw exception
show _forEach [1..3], (n) -> n*n
# Which btw could in CoffeeScript be written as
show (i*i for i in [1..3])
_member = (array, value) ->
  found = false
  _forEach array, (element) ->
    if element is value
      found = true
      throw _break
  found
show _member [6, 7, "Bordeaux"], 7
_member = (array, value) ->
  found = false
  for element in array
    if element is value
      found = true
      break
  found
show _member [6, 7, "Bordeaux"], 7
show 7 in [6, 7, "Bordeaux"]
_any = (array, test) ->
  for element in array
    if test element
      return true
  false

show _any [3, 4, 0, -3, 2, 1], (n) -> n < 0
show _any [3, 4, 0, 2, 1], (n) -> n < 0
# Using Underscore
show _.any [3, 4, 0, -3, 2, 1], (n) -> n < 0
# Redefining member with any
_member = (array, value) ->
  partial = (func, a...) -> (b...) -> func a..., b...
  _.any array, partial ((a,b) -> a is b), value
show _member ["Fear", "Loathing"], "Denial"
show _member ["Fear", "Loathing"], "Loathing"
_every = (array, test) ->
  for element in array
    if not test element
      return false
  true
show _every [1, 2, 0, -1], (n) -> n isnt 0
show _every [1, 2, -1], (n) -> n isnt 0
show _.every [1, 2, -1], (n) -> n isnt 0 # Using Underscore
_flatten = (array) ->
  result = []
  for element in array
    if _.isArray element
      result = result.concat _flatten element
    else
      result.push element
  result

show _flatten [[1], [2, [3, 4]], [5, 6]]
# Using Underscore
show _.flatten [[1], [2, [3, 4]], [5, 6]]
# Compose a solution here
_filter = (array, test) ->
  result = []
  for element in array
    if test element
      result.push element
  result

show _filter [0, 4, 8, 12], (n) -> n < 5

isOdd = (n) -> n % 2 isnt 0
show _.filter [0..6], isOdd # Using Underscore
possibleRoutes = (from, to) ->
  findRoutes = (route) ->
    notVisited = (road) ->
      not (road.to in route.places)
    continueRoute = (road) ->
      findRoutes 
        places: route.places.concat([road.to]),
        length: route.length + road.distance
    end = route.places[route.places.length - 1]
    if end is to
      [route]
    else
      _.flatten _.map _.filter(roadsFrom(end), notVisited),
                  continueRoute
  findRoutes {places: [from], length: 0}

show (possibleRoutes 'Point Teohotepapapa', 'Point Kiukiu').length
show possibleRoutes 'Hanapaoa', 'Mt Ootua' 
# Compose a solution here
shortestRoute = (from, to) ->
  currentShortest = null
  _.each possibleRoutes(from, to), (route) ->
    if not currentShortest or
       currentShortest.length > route.length
      currentShortest = route 
  currentShortest
minimise = (func, array) ->
  minScore = null
  found = null
  _.each array, (element) ->
    score = func element
    if minScore is null or score < minScore
      minScore = score
      found = element
  found

getProperty = (propName) ->
  (object) -> object[propName]

shortestRouteAbstract = (from, to) ->
  minimise getProperty('length'),
           possibleRoutes(from, to)
show (shortestRoute 'Point Kiukiu',  'Point Teohotepapapa').places
show (shortestRouteAbstract 'Point Kiukiu',  'Point Teohotepapapa').places
heightAt = (point) ->
  heights = [[111,111,122,137,226,192,246,275,285,333,328,264,202,175,151,222,250,222,219,146]
  [205,186,160,218,217,233,268,300,316,357,276,240,240,253,215,201,256,312,224,200]
  [228,176,232,258,246,289,306,351,374,388,319,333,299,307,261,286,291,355,277,258]
  [228,207,263,264,284,348,368,358,391,387,320,344,366,382,372,394,360,314,259,207]
  [238,237,275,315,353,355,341,332,350,315,283,310,355,350,336,405,361,273,264,228]
  [245,264,289,340,359,349,336,303,267,259,285,340,315,290,333,372,306,254,220,220]
  [264,287,331,365,382,381,386,360,299,258,254,284,264,276,295,323,281,233,202,160]
  [300,327,360,355,365,402,393,343,307,274,232,226,221,262,289,250,252,228,160,160]
  [343,379,373,337,309,336,378,352,303,290,294,241,176,204,235,205,203,206,169,132]
  [348,348,364,369,337,276,321,390,347,354,309,259,208,147,158,165,169,169,200,147]
  [320,328,334,348,354,316,254,315,303,297,283,238,229,207,156,129,128,161,174,165]
  [297,331,304,283,283,279,250,243,264,251,226,204,155,144,154,147,120,111,129,138]
  [302,347,332,326,314,286,223,205,202,178,160,172,171,132,118,116,114, 96, 80, 75]
  [287,317,310,293,284,235,217,305,286,229,211,234,227,243,188,160,152,129,138,101]
  [260,277,269,243,236,255,343,312,280,220,252,280,298,288,252,210,176,163,133,112]
  [266,255,254,254,265,307,350,311,267,276,292,355,305,250,223,200,197,193,166,158]
  [306,312,328,279,287,320,377,359,289,328,367,355,271,250,198,163,139,155,153,190]
  [367,357,339,330,290,323,363,374,330,331,415,446,385,308,241,190,145, 99, 88,145]
  [342,362,381,359,353,353,369,391,384,372,408,448,382,358,256,178,143,125, 85,109]
  [311,337,358,376,330,341,342,374,411,408,421,382,271,311,246,166,132,116,108, 72]]
  heights[point.y][point.x]

show heightAt x:  0, y:  0
show heightAt x: 11, y: 18
weightedDistance = (pointA, pointB) ->
  heightDifference =
    heightAt(pointB) - heightAt(pointA)
  climbFactor = if heightDifference < 0 then 1 else 2
  flatDistance =
    if pointA.x is pointB.x or pointA.y is pointB.y
      100
    else
      141
  flatDistance + climbFactor * Math.abs heightDifference
show weightedDistance (x: 0, y: 0), (x: 1, y: 1)
point = (x, y) -> {x, y} # Same as {x: x, y: y}
addPoints = (a, b) -> point a.x + b.x, a.y + b.y
samePoint = (a, b) -> a.x is b.x and a.y is b.y

show samePoint addPoints(point(10, 10), point(4, -2)),
                         point(14, 8)
# Compose a solution here
possibleDirections = (from) ->
  mapSize = 20
  insideMap = (point) ->
    point.x >= 0 and point.x < mapSize and
    point.y >= 0 and point.y < mapSize
  directions = [ point(-1,  0), point( 1,  0)
                 point( 0, -1), point( 0,  1)
                 point(-1, -1), point(-1,  1)
                 point( 1,  1), point( 1, -1)]
  partial = (func, a...) -> (b...) -> func a..., b...
  _.filter (_.map directions,
              partial addPoints, from), insideMap

show possibleDirections point 0, 0
@BinaryHeap = class BinaryHeap

  # Public
  #--------
  constructor: (@scoreFunction = (x) -> x) ->
    @content = []

  push: (element) ->
    # Add the new element to the end of the array.
    @content.push element
    # Allow it to bubble up.
    @_bubbleUp @content.length - 1
  
  pop: ->
    # Store the first element so we can return it later.
    result = @content[0]
    # Get the element at the end of the array.
    end = @content.pop()
    # If there are any elements left, put the end
    # element at the start, and let it sink down.
    if @content.length > 0
      @content[0] = end
      @_sinkDown 0
    result

  size: -> @content.length

  remove: (node) ->
    len = @content.length
    # To remove a value, we must search through the
    # array to find it.
    for i in [0...len]
      if @content[i] is node
        # When it is found, the process seen in 'pop'
        # is repeated to fill up the hole.
        end = @content.pop()
        if i isnt len - 1
          @content[i] = end
          if @scoreFunction(end) < @scoreFunction(node)
            @_bubbleUp i
          else
            @_sinkDown i
        return
    throw new Error 'Node not found.'

  # Private
  #---------
  _bubbleUp: (n) ->
    # Fetch the element that has to be moved.
    element = @content[n]
    # When at 0, an element can not go up any further.
    while n > 0
      # Compute the parent element index, and fetch it.
      parentN = Math.floor((n + 1) / 2) - 1
      parent = @content[parentN]
      # Swap the elements if the parent is greater.
      if @scoreFunction(element) < @scoreFunction(parent)
        @content[parentN] = element
        @content[n] = parent
        # Update 'n' to continue at the new position.
        n = parentN
      # Found a parent that is less,
      # no need to move it further.
      else
        break
    return

  _sinkDown: (n) ->
    # Look up the target element and its score.
    length = @content.length
    element = @content[n]
    elemScore = @scoreFunction element
    loop
      # Compute the indices of the child elements.
      child2N = (n + 1) * 2
      child1N = child2N - 1
      # This is used to store the new position of
      # the element, if any.
      swap = null
      # If the first child exists (is inside the array)...
      if child1N < length
        # Look it up and compute its score.
        child1 = @content[child1N]
        child1Score = this.scoreFunction child1
        # If the score is less than our elements,
        # we need to swap.
        if child1Score < elemScore
          swap = child1N
      # Do the same checks for the other child.
      if child2N < length
        child2 = @content[child2N]
        child2Score = @scoreFunction child2
        compScore = if swap is null
            elemScore
          else
            child1Score
        if child2Score < compScore
          swap = child2N
      # If the element needs to be moved,
      # swap it, and continue.
      if swap isnt null
        @content[n] = @content[swap]
        @content[swap] = element
        n = swap
      # Otherwise, we are done.
      else
        break
    return
heap = new BinaryHeap()
_.each [2, 4, 5, 1, 6, 3], (number) ->
  heap.push number

while heap.size() > 0
  show heap.pop()
# Compose a solution here
estimatedDistance = (pointA, pointB) ->
  dx = Math.abs pointA.x - pointB.x
  dy = Math.abs pointA.y - pointB.y
  if dx > dy
    (dx - dy) * 100 + dy * 141
  else
    (dy - dx) * 100 + dx * 141

show estimatedDistance point(3,3), point(9,6)
# Compose a solution here
makeReachedList = -> {}

storeReached = (list, point, route) ->
  inner = list[point.x]
  if inner is undefined
    inner = {}
    list[point.x] = inner
  inner[point.y] = route

findReached = (list, point) ->
  inner = list[point.x]
  if inner is undefined
    undefined
  else
    inner[point.y]
pointID = (point) ->
  point.x + '-' + point.y

makeReachedList = -> {}
storeReached = (list, point, route) ->
  list[pointID(point)] = route
findReached = (list, point) ->
  list[pointID(point)]
findRoute = (from, to) ->
 
  routeScore = (route) ->
    if route.score is undefined
      route.score = route.length +
        estimatedDistance route.point, to
    route.score

  addOpenRoute = (route) ->
    open.push route
    storeReached reached, route.point, route

  open = new BinaryHeap routeScore
  reached = makeReachedList()
  addOpenRoute point: from, length: 0

  while open.size() > 0
    route = open.pop()
    if samePoint route.point, to
      return route

    _.each possibleDirections(route.point),
      (direction) ->
        known = findReached reached, direction
        newLength = route.length +
          weightedDistance route.point, direction
        if not known or known.length > newLength
          if known
            open.remove known
          addOpenRoute
            point:  direction,
            from:   route,
            length: newLength
  return null
route = findRoute point(0, 0), point(19, 19)
runOnDemand -> show route
traverseRoute = (routes..., func) ->
  _.each [routes...], (route) ->
    while route
      func
        x: route.point.x
        y: route.point.y
      route = route.from

showRoute = (routes...) ->
  traverseRoute routes..., show

runOnDemand ->
  show '\n   Easy route'
  showRoute route
  show '\n   Sightseeing'
  showRoute findRoute(point( 0,  0), point(11, 17)),
            findRoute(point(11, 17), point(19, 19))
showSortedRoute = (routes...) ->
  points = []
  traverseRoute routes..., (point) -> points.push point
  # A sort needs a function that compares two points 
  # Pattern matching can decompose them into unique names
  points.sort ({x:x1, y:y1}, {x:x2, y:y2}) ->
    return dx if dx = x1 - x2
    return dy if dy = y1 - y2
    0
  # The Underscore uniq function can get rid of doublets with
  # help from a function that serializes the relevant properties
  points = _.uniq points, true, ({x, y}) -> "#{x} #{y}"
  show point for point in points

runOnDemand ->
  showSortedRoute findRoute(point( 0,  0), point(11, 17)),
                  findRoute(point(11, 17), point(19, 19))
renderRoute = (routes...) ->
  kup = if exports? then require 'coffeekup' else window.CoffeeKup

  webdesign = ->
    doctype 5
    html ->
      head ->
        style '.map {position: absolute; left: 33px; top: 80px}'
      body ->
        header -> h1 'Route'
        div class: 'map', ->
          img src: 'http://autotelicum.github.com/' +
                   'Smooth-CoffeeScript/img/height-small.png'
          img class: 'map', src: "#{ostrich}",  width: size, height: size, \
              style: "left: #{x*size}px; top: #{y*size}px" for {x, y} in points

  points = []
  traverseRoute routes..., (point) -> points.push point
  routePage = kup.render webdesign,
    locals:
      size: 500 / 20 # Square map: size divided by fields
      points: points
  showDocument routePage, 565, 600
  return

runOnDemand ->
  renderRoute findRoute(point( 0,  0), point(11, 17)),
              findRoute(point(11, 17), point(19, 19))
  renderRoute findRoute(point( 0,  0), point(15,  3)),
              findRoute(point(15,  3), point(19, 19))
rabbit = {}
rabbit.speak = (line) ->
  show "The rabbit says '#{line}'"
rabbit.speak "Well, now you're asking me."
speak = (line) ->
  show "The #{this.adjective} rabbit says '#{line}'"

whiteRabbit = adjective: "white", speak: speak
fatRabbit = adjective: "fat", speak: speak

whiteRabbit.speak "Oh my ears and whiskers, " +
                  "how late it's getting!"
fatRabbit.speak "I could sure use a carrot right now."
speak.apply fatRabbit, ['Yum.']
speak.call fatRabbit, 'Burp.'
class Rabbit
  constructor: (@adjective) ->
  speak: (line) ->
    show "The #{@adjective} rabbit says '#{line}'"

whiteRabbit = new Rabbit "white"
fatRabbit = new Rabbit "fat"

whiteRabbit.speak "Hurry!"
fatRabbit.speak "Tasty!"
killerRabbit = new Rabbit 'killer'
killerRabbit.speak 'GRAAAAAAAAAH!'
show killerRabbit
makeRabbit = (adjective) ->
  adjective: adjective
  speak: (line) -> show adjective + ': ' + line
blackRabbit = makeRabbit 'black'
show killerRabbit.constructor.name
show blackRabbit.constructor.name
class WeightyRabbit extends Rabbit
  constructor: (adjective, @weight) ->
    super adjective
  adjustedWeight: (relativeGravity) ->
    (@weight * relativeGravity).toPrecision 2

tinyRabbit = new WeightyRabbit "tiny", 1.01
jumboRabbit = new WeightyRabbit "jumbo", 7.47

moonGravity = 1/6
jumboRabbit.speak "Carry me, I weigh 
#{jumboRabbit.adjustedWeight(moonGravity)} stones"
tinyRabbit.speak "He ain't heavy, he is my brother"
class Account
  constructor: -> @balance = 0
  transfer: (amount) -> @balance += amount
  getBalance: -> @balance
  batchTransfer: (amtList) ->
    for amount in amtList
      @transfer amount

yourAccount = new Account()
oldBalance = yourAccount.getBalance()
yourAccount.transfer salary = 1000
newBalance = yourAccount.getBalance()
show "Books balance:
 #{salary is newBalance - oldBalance}."
class AccountWithFee extends Account
  fee: 5
  transfer: (amount) ->
    super amount - @fee
    # feeAccount.transfer @fee

yourAccount = new AccountWithFee()
oldBalance = yourAccount.getBalance()
yourAccount.transfer salary = 1000
newBalance = yourAccount.getBalance()
show "Books balance:
 #{salary is newBalance - oldBalance}."
class LimitedAccount extends Account
  constructor: -> super; @resetLimit()
  resetLimit: -> @dailyLimit = 50
  transfer: (amount) ->
    if amount < 0 and (@dailyLimit += amount) < 0
      throw new Error "You maxed out!"
    else
      super amount
lacc = new LimitedAccount()
lacc.transfer 50
show "Start balance #{lacc.getBalance()}"

try lacc.batchTransfer [-1..-10]
catch error then show error.message
show "After batch balance #{lacc.getBalance()}"
class Account
  constructor: -> @balance = 0
  transfer: (amount) -> @balance += amount
  getBalance: -> @balance
  batchTransfer: (amtList) ->
    add = (a,b) -> a+b
    sum = (list) -> _.reduce list, add, 0
    @balance += sum amtList

class LimitedAccount extends Account
  constructor: -> super; @resetLimit()
  resetLimit: -> @dailyLimit = 50
  transfer: (amount) ->
    if amount < 0 and (@dailyLimit += amount) < 0
      throw new Error "You maxed out!"
    else
      super amount

lacc = new LimitedAccount()
lacc.transfer 50
show "Starting with #{lacc.getBalance()}"

try lacc.batchTransfer [-1..-10]
catch error then show error.message
show "After batch balance #{lacc.getBalance()}"
simpleObject = {}
show simpleObject.constructor.name
show simpleObject.toString()
show _.methods Rabbit
show _.methods Rabbit.prototype
show Rabbit.prototype.constructor.name
Rabbit.prototype.speak 'I am generic' 
Rabbit::speak 'I am not initialized'
Rabbit::speak 'I am not initialized'
show killerRabbit.toString is simpleObject.toString
Rabbit::teeth = 'small'
show killerRabbit.teeth

killerRabbit.teeth = 'long, sharp, and bloody'
show killerRabbit.teeth

show Rabbit::teeth
Rabbit::dance = ->
  show "The #{@adjective} rabbit dances a jig."
killerRabbit.dance()
Rabbit = (adjective) ->
  @adjective = adjective

Rabbit::speak = (line) ->
  show "The #{@adjective} rabbit says '#{line}'"

hazelRabbit = new Rabbit "hazel"
hazelRabbit.speak "Good Frith!"
noCatsAtAll = {}
if "constructor" of noCatsAtAll
  show "Yes, there is a cat called 'constructor'."
Object::allProperties = ->
  for property of this
    property

test = x: 10, y: 3
show test.allProperties()
delete Object::allProperties
Object::ownProperties = ->
  for own property of this
    property

test = 'Fat Igor': true, 'Fireball': true
show test.ownProperties()
delete Object::ownProperties
forEachOf = (object, action) ->
  for own property, value of object
    action property, value

chimera = head: "lion", body: "goat", tail: "snake"
forEachOf chimera, (name, value) ->
  view "The #{name} of a #{value}."
forEachIn = (object, action) ->
  for property of object
    if Object::hasOwnProperty.call object, property
      action property, object[property]

test = name: "Mordecai", hasOwnProperty: "Uh-oh"
forEachIn test, (name, value) ->
  view "Property #{name} = #{value}"
test = name: "Mordecai", hasOwnProperty: "Uh-oh"
for own property, value of test
  show "Property #{property} = #{value}"
obj = foo: 'bar'

# This test is needed to avoid hidden properties ...
show Object::hasOwnProperty.call(obj, 'foo') and
     Object::propertyIsEnumerable.call(obj, 'foo')
# ... because this returns true ...
show Object::hasOwnProperty.call(obj, '__proto__')
# ... this is required to get false.
show Object::hasOwnProperty.call(obj, '__proto__') and
     Object::propertyIsEnumerable.call(obj, '__proto__')
class Dictionary
  constructor: (@values = {}) ->

  store: (name, value) ->
    @values[name] = value

  lookup: (name) ->
    @values[name]

  contains: (name) ->
    Object::hasOwnProperty.call(@values, name) and
    Object::propertyIsEnumerable.call(@values, name)

  each: (action) ->
    for own property, value of @values
      action property, value

colours = new Dictionary
  Grover: 'blue'
  Elmo:   'orange'
  Bert:   'yellow'

show colours.contains 'Grover'
colours.each (name, colour) ->
  view name + ' is ' + colour
slash = /\//;
show 'AC/DC'.search slash
asteriskOrBrace = /[\{\*]/
story = 'We noticed the *giant sloth*, ' +
        'hanging from a giant branch.';
show story.search asteriskOrBrace
digitSurroundedBySpace = /\s\d\s/
show '1a 2 3d'.search digitSurroundedBySpace
notABC = /[^ABC]/
show 'ABCBACCBBADABC'.search notABC
# Compose a solution here
datePattern = /\d\d\/\d\d\/\d\d\d\d/
show 'born 15/11/2003 (mother Spot): White Fang'\
.search datePattern
show /a+/.test 'blah'
show /^a+$/.test 'blah'
show /cat/.test 'concatenate'
show /\bcat\b/.test 'concatenate'
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
# Compose a solution here
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
cartoonCrying = /boo(hoo+)+/i
show "Then, he exclaimed 'Boohoooohoohooo'"\
.search cartoonCrying
holyCow = /(sacred|holy) (cow|bovine|bull|taurus)/i
show holyCow.test 'Sacred bovine!'
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
# Compose a solution here
extractDate = (string) ->
  found = string.match /(\d\d?)\/(\d\d?)\/(\d{4})/
  if found is null
    throw new Error "No date found in '#{string}'."
  new Date Number(found[3]),
           Number(found[2]) - 1,
           Number(found[1])
show extractDate \
  "born 5/2/2007 (mother Noog): Long-ear Johnson"
names = '''Picasso, Pablo
Gauguin, Paul
Van Gogh, Vincent'''

show names.replace /([\w ]+), ([\w ]+)/g, '$2 $1'

show names.replace ///
  ([\w ]+)         # Lastname
  ,
  ([\w ]+)         # Firstname
///g, '$2 $1'
eatOne = (match, amount, unit) ->
  amount = Number(amount) - 1
  if amount is 1
    unit = unit.slice 0, unit.length - 1
  else if amount is 0
    unit = unit + 's'
    amount = 'no'
  amount + ' ' + unit

stock = '1 lemon, 2 cabbages, and 101 eggs'
stock = stock.replace /(\d+) (\w+)/g, eatOne
show stock
# Compose a solution here
escapeHTML2 = (text) ->
  replacements =
    "<":  "&lt;"
    ">":  "&gt;"
    "&":  "&amp;"
    "\"": "&quot;"
  text.replace /[<>&"]/g, (character) ->
    replacements[character] ? character

show escapeHTML2 "The 'pre-formatted' tag " +
                "is written \"<pre>\"."
badWords = ['ape', 'monkey', 'simian', 'gorilla', 'evolution']
pattern = new RegExp badWords.join('|'), 'i'
isAcceptable = (text) ->
  !pattern.test text

show isAcceptable 'Mmmm, grapes.'
show isAcceptable 'No more of that monkeybusiness, now.'
digits = new RegExp '\\d+'
show digits.test '101'
HTML =
  tag: (name, content, properties) ->
    name: name
    properties: properties
    content: content
  link: (target, text) ->
    HTML.tag 'a', [text], {href: target}
  # ... many more HTML-producing functions ...
# As defined in the prelude
globalize = (ns, target = global) ->
  target[name] = ns[name] for name of ns

globalize HTML, window?
show link 'http://citeseerx.ist.psu.edu/viewdoc/' +
  'download?doi=10.1.1.102.244&rep=rep1&type=pdf',
  'What Every Computer Scientist Should Know ' +
  'About Floating-Point Arithmetic'
range = (start, end, stepSize, length) ->
  if stepSize is undefined
    stepSize = 1
  if end is undefined
    end = start + stepSize * (length - 1)
  result = []
  while start <= end
    result.push start
    start += stepSize
  result
show range 0, undefined, 4, 5
defaultTo = (object, values) ->
  for name, value of values
    if not object.hasOwnProperty name
      object[name] = value

range = (args) ->
  defaultTo args, {start: 0, stepSize: 1}
  if args.end is undefined
    args.end = args.start +
               args.stepSize * (args.length - 1)
  result = [];
  while args.start <= args.end
    result.push args.start
    args.start += args.stepSize
  result
show range {stepSize: 4, length: 5}
runOnDemand ->
  eval 'function IamJavaScript() {' +
       '  alert(\"Repeat after me:' +
       ' Give me more {();};.\");};' +
       ' IamJavaScript();'
runOnDemand ->
  CoffeeScript.eval 'alert ((a, b) -> a + b) 3, 4'
weatherAdvice = (weather) ->
  show 'When it is ' + weather
  switch weather
    when 'sunny'
      show 'Dress lightly.'
      show 'Go outside.'
    when 'cloudy'
      show 'Go outside.'
    when 'tornado', 'hurricane'
      show 'Seek shelter'
    else
      show 'Unknown weather type: ' + weather
weatherAdvice 'sunny'
weatherAdvice 'cloudy'
weatherAdvice 'tornado'
weatherAdvice 'hailstorm'
for i in [20...30]
  if i % 3 isnt 0
    continue
  show i + ' is divisible by three.'
class Point
  constructor: (@x, @y) ->
pt = new Point 3, 4

{x, y} = pt
show "x is #{x} and y is #{y}"
firstName = "Alan"
lastName = "Turing"

name = {firstName, lastName}
show name
decorate = ({firstName, lastName}) ->
  show "Distinguished #{firstName} " +
       "of the #{lastName} family."
decorate name
pi = π = Math.PI
sphereSurfaceArea = (r) -> 4 * π * r * r
radius = 1
show '4 * π * r * r when r = ' + radius
show sphereSurfaceArea radius
evens = (n) -> i for i in [0..n] when i % 2 is 0
show evens 6

steppenwolf = 
  title:   'Tonight at the Magic Theater'
  warning: 'For Madmen only'
  caveat:  'Price of Admittance: Your Mind.'
  caution: 'Not for Everybody.'

stipulations = (text for key, text of steppenwolf \
  when key in ['warning', 'caveat'])
show stipulations
show ultimatum for ultimatum in stipulations \
  when ultimatum.match /Price/
tautounlogical = "the reason is because I say so"
splitStringAt = (str, n) ->
  [str.substring(0,n), str.substring(n)]
[pre, post] = splitStringAt tautounlogical, 14
[pre, post] = [post, pre] # swap
show "#{pre} #{post}"
[re,mi,fa,sol,la,ti] = [1..6]
[dal,ra...,mim] = [ti,re,fa,sol,la,mi]
show "#{dal}, #{ra} and #{mim}"

[key, word] = if re > ti then [mi, fa] else [fa, mi]
show "#{key} and #{word}"
class Widget
  id: 'I am a widget'
  display: => show @id

class Container
  id: 'I am a container'
  callback: (f) ->
    show @id
    f()

a = new Widget
a.display()
b = new Container
b.callback a.display
n = 3
f = -> show "Say: 'Yes!'"
do f
(do -> show "Yes!") while n-- > 0
echoEchoEcho = (msg) -> msg() + msg() + msg()
show echoEchoEcho -> "No"
class BinaryHeap

  # Public
  #--------
  constructor: (@scoreFunction = (x) -> x) ->
    @content = []

  push: (element) ->
    # Add the new element to the end of the array.
    @content.push element
    # Allow it to bubble up.
    @_bubbleUp @content.length - 1
  
  pop: ->
    # Store the first element so we can return it later.
    result = @content[0]
    # Get the element at the end of the array.
    end = @content.pop()
    # If there are any elements left, put the end
    # element at the start, and let it sink down.
    if @content.length > 0
      @content[0] = end
      @_sinkDown 0
    result

  size: -> @content.length

  remove: (node) ->
    len = @content.length
    # To remove a value, we must search through the
    # array to find it.
    for i in [0...len]
      if @content[i] is node
        # When it is found, the process seen in 'pop'
        # is repeated to fill up the hole.
        end = @content.pop()
        if i isnt len - 1
          @content[i] = end
          if @scoreFunction(end) < @scoreFunction(node)
            @_bubbleUp i
          else
            @_sinkDown i
        return
    throw new Error 'Node not found.'

  # Private
  #---------
  _bubbleUp: (n) ->
    # Fetch the element that has to be moved.
    element = @content[n]
    # When at 0, an element can not go up any further.
    while n > 0
      # Compute the parent element index, and fetch it.
      parentN = Math.floor((n + 1) / 2) - 1
      parent = @content[parentN]
      # Swap the elements if the parent is greater.
      if @scoreFunction(element) < @scoreFunction(parent)
        @content[parentN] = element
        @content[n] = parent
        # Update 'n' to continue at the new position.
        n = parentN
      # Found a parent that is less,
      # no need to move it further.
      else
        break
    return

  _sinkDown: (n) ->
    # Look up the target element and its score.
    length = @content.length
    element = @content[n]
    elemScore = @scoreFunction element
    loop
      # Compute the indices of the child elements.
      child2N = (n + 1) * 2
      child1N = child2N - 1
      # This is used to store the new position of
      # the element, if any.
      swap = null
      # If the first child exists (is inside the array)...
      if child1N < length
        # Look it up and compute its score.
        child1 = @content[child1N]
        child1Score = this.scoreFunction child1
        # If the score is less than our elements,
        # we need to swap.
        if child1Score < elemScore
          swap = child1N
      # Do the same checks for the other child.
      if child2N < length
        child2 = @content[child2N]
        child2Score = @scoreFunction child2
        compScore = if swap is null
            elemScore
          else
            child1Score
        if child2Score < compScore
          swap = child2N
      # If the element needs to be moved,
      # swap it, and continue.
      if swap isnt null
        @content[n] = @content[swap]
        @content[swap] = element
        n = swap
      # Otherwise, we are done.
      else
        break
    return

(exports ? this).BinaryHeap = BinaryHeap
runOnDemand ->
  sortByValue = (obj) -> _.sortBy obj, (n) -> n
  buildHeap = (c, a) ->
      heap = new BinaryHeap
      heap.push number for number in a
      c.note heap
  
  declare 'heap is created empty', [],
    (c) -> c.assert (new BinaryHeap).size() is 0
  
  declare 'heap pop is undefined when empty', [],
    (c) -> c.assert _.isUndefined (new BinaryHeap).pop()
  
  declare 'heap contains number of inserted elements',
    [arbArray(arbInt)], (c, a) ->
      c.assert buildHeap(c, a).size() is a.length
  
  declare 'heap contains inserted elements',
    [arbArray(arbInt)], (c, a) ->
      heap = buildHeap c, a
      c.assert _.isEqual sortByValue(a), \
        sortByValue(heap.content)
  
  declare 'heap pops elements in sorted order',
    [arbArray(arbInt)], (c, a) ->
      heap = buildHeap c, a
      for n in sortByValue a then c.assert n is heap.pop()
      c.assert heap.size() is 0
  
  declare 'heap does not remove non-existent elements',
    [arbArray(arbInt), arbInt],
    expectException (c, a, b) ->
      if b in a then c.guard false
      heap = buildHeap c, a
      heap.remove b
  
  declare 'heap removes existing elements',
    [arbArray(arbInt), arbInt], (c, a, b) ->
      if not (b in a) then c.guard false
      aSort = sortByValue _.without a, b
      count = a.length - aSort.length
      heap = buildHeap c, a
      heap.remove b for i in [0...count]
      for n in aSort then c.assert n is heap.pop()
      c.assert heap.size() is 0

  test()
# CoffeeScript

runOnDemand ->
  start = new Date()
  
  N = 1000000
  a = Array(N)
  for i in [0...N]
    a[i] = Math.random()
  
  s = 0
  for v in a
    s += v
  
  t = 0
  for v in a
    t += v*v
  t = Math.sqrt t
  
  duration = new Date() - start
  show "N: #{N} in #{duration*0.001} s"
  show "Result: #{s} and #{t}"
# CoffeeScript encoding: utf-8

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
      return true if j - i is d or i - j is d
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

runOnDemand ->
  start = new Date()
  solve 8 # Normal chessboard size
  show "Timing: #{(new Date() - start)*0.001}s"
