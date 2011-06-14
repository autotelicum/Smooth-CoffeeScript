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

# 
show '---  ---'


# 
show '---  ---'


# Do statement
show '--- Do statement ---'
for i in [1..3]
  do (i) ->
    setTimeout (-> show 'With do: ' + i), 0
for i in [1..3]
  setTimeout (-> show 'Without: ' + i), 0

setTimeout (-> chain()), 0
chain = ->

