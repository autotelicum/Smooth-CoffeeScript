require './prelude'

# Switch statement
show '--- Switch statement ---'
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

# Continue statement
show '--- Continue statement ---'
for i in [20...30]
  if i % 3 != 0
    continue
  show i + ' is divisible by three.'

# Pattern matching
show '--- Pattern matching ---'
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

# Unicode identifiers
show '--- Unicode identifiers ---'
pi = π = Math.PI
sphereSurfaceArea = (r) -> 4 * π * r * r
radius = 1
show '4 * π * r * r when r = ' + radius
show sphereSurfaceArea radius

# When filter
show '--- When filter ---'
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

# Destructuring assignment
show '--- Destructuring assignment ---'
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

# Bound function
show '--- Bound function ---'
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

# Do statement
show '--- Do statement ---'
n = 3
f = -> show "Say: 'Yes!'"
do f
(do -> show "Yes!") while n-- > 0

echoEchoEcho = (msg) -> msg() + msg() + msg()
show echoEchoEcho -> "No"

foo = (fun) -> 10*fun()
show foo -> 12

for i in [1..3]
  do (i) ->
    setTimeout (-> show 'With do: ' + i), 0
for i in [1..3]
  setTimeout (-> show 'Without: ' + i), 0

setTimeout (-> chain()), 0
chain = ->

