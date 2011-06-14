require './prelude'
# Bring underscore into global
globalize _


# Road representations
show '--- Road representations ---'
roads = [
  { point1: 'Point Kiukiu', point2: 'Hanaiapa', length: 19 }
  { point1: 'Point Kiukiu', point2: 'Mt Feani', length: 15 }
] # and so on
show roads

roads = { 'Point Kiukiu': [ {to: 'Hanaiapa', distance: 19},
                            {to: 'Mt Feani', distance: 15},
                            {to: 'Taaoa', distance: 15} ],
          'Taaoa':        [ ] # et cetera
        }
show roads

# Function makeRoad
show '--- Function makeRoad ---'
roads = {}
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

# Exercise 26
show '--- Exercise 26 ---'
makeRoads = (start) ->
  for i in [1...arguments.length] by 2
    makeRoad start, arguments[i], arguments[i + 1]
show '--- End of Exercise ---'

# Build roads
show '--- Build roads ---'
roads = {}
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

# Function roadsFrom
show '--- Function roadsFrom ---'
roadsFrom = (place) ->
  found = roads[place]
  return found if found?
  throw new Error "No place named '#{place}' found."
    
try
  show roadsFrom "Hanaiapa"
  show roadsFrom "Hanalapa"
catch error
  show "Oops #{error}"

# Function gamblerPath
show '--- Function gamblerPath ---'
gamblerPath = (from, to) ->

  randomInteger = (below) ->
    Math.floor Math.random() * below

  randomDirection = (from) ->
    options = roadsFrom from
    options[randomInteger(options.length)].to

  path = []
  loop
    path.push from
    break if from == to
    from = randomDirection from
  path

show gamblerPath 'Hanaiapa', 'Mt Feani'


# Functional samples
#--------------------

# Member function 1
show '--- Member function 1 ---'
_member = (array, value) ->
  found = false
  array.forEach (element) ->
    if element == value
      found = true
  found
show _member [6, 7, "Bordeaux"], 7

# forEach with break
show '--- forEach with break ---'
_break = toString: -> "Break"
_forEach = (array, action) ->
  try
    for element in array
      action element
  catch exception
    if exception != _break
      throw exception
show _forEach [1..3], (n) -> n*n
# Which btw could in CoffeeScript be written as
show (i*i for i in [1..3])

# Member function 2
show '--- Member function 2 ---'
_member = (array, value) ->
  found = false
  _forEach array, (element) ->
    if element == value
      found = true
      throw _break
  found
show _member [6, 7, "Bordeaux"], 7

# Member function 3
show '--- Member function 3 ---'
_member = (array, value) ->
  found = false
  for element in array
    if element == value
      found = true
      break
  found
show _member [6, 7, "Bordeaux"], 7

# Operator in
show '--- Operator in ---'
show 7 in [6, 7, "Bordeaux"]

# Any function
show '--- Any function ---'
_any = (array, test) ->
  for element in array
    if test element
      return true
  false
show _any [3, 4, 0, -3, 2, 1], (n) -> n < 0
show _any [3, 4, 0, 2, 1], (n) -> n < 0
# Using Underscore
show any [3, 4, 0, -3, 2, 1], (n) -> n < 0

# Redefining member with any
_member = (array, value) ->
  partial = (func, a...) -> (b...) -> func a..., b...
  any array, partial ((a,b) -> a == b), value
show _member ["Fear", "Loathing"], "Denial"
show _member ["Fear", "Loathing"], "Loathing"

# Every function
show '--- Every function ---'
_every = (array, test) ->
  for element in array
    if not test element
      return false
  true
show _every [1, 2, 0, -1], (n) -> n != 0
show _every [1, 2, -1], (n) -> n != 0
show every [1, 2, -1], (n) -> n != 0 # Using Underscore

# Flatten function
show '--- Flatten function ---'
_flatten = (array) ->
  result = []
  for element in array
    if isArray element
      result = result.concat _flatten element
    else
      result.push element
  result
show _flatten [[1], [2, [3, 4]], [5, 6]]
# Using Underscore
show flatten [[1], [2, [3, 4]], [5, 6]]

# Exercise 27
show '--- Exercise 27 ---'
_filter = (array, test) ->
  result = []
  for element in array
    if test element
      result.push element
  result
show _filter [0, 4, 8, 12], (n) -> n < 5

isOdd = (n) -> n % 2 != 0
show filter [0..6], isOdd # Using Underscore
show '--- End of Exercise ---'

# End of Functional samples
#---------------------------


# Possible routes
show '--- Possible routes ---'
possibleRoutes = (from, to) ->
  findRoutes = (route) ->
    notVisited = (road) ->
      not (road.to in route.places)
    continueRoute = (road) ->
      findRoutes 
        places: route.places.concat([road.to]),
        length: route.length + road.distance
    end = route.places[route.places.length - 1]
    if end == to
      [route]
    else
      flatten map filter(roadsFrom(end), notVisited),
                  continueRoute
  findRoutes {places: [from], length: 0}

show (possibleRoutes 'Point Teohotepapapa',
                     'Point Kiukiu').length
show possibleRoutes 'Hanapaoa', 'Mt Ootua'


# Exercise 28
show '--- Exercise 28 ---'
shortestRoute = (from, to) ->
  currentShortest = null
  forEach possibleRoutes(from, to), (route) ->
    if not currentShortest or
       currentShortest.length > route.length
      currentShortest = route 
  currentShortest
show (shortestRoute 'Point Kiukiu',
  'Point Teohotepapapa').places

# Functional alternative
minimise = (func, array) ->
  minScore = null
  found = null
  forEach array, ( (element) ->
    score = func element
    if minScore == null || score < minScore
      minScore = score
      found = element )
  found

getProperty = (propName) ->
  (object) -> object[propName]

shortestRoute = (from, to) ->
  minimise getProperty('length'),
           possibleRoutes(from, to)
show '--- End of Exercise ---'

# Shortest route
show '--- Shortest route ---'
show (shortestRoute 'Point Kiukiu',
  'Point Teohotepapapa').places

# Height map
show '--- Height map ---'
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

# Same point
show '--- Same point ---'
weightedDistance = (pointA, pointB) ->
  heightDifference =
    heightAt(pointB) - heightAt(pointA)
  climbFactor = if heightDifference < 0 then 1 else 2
  flatDistance =
    if pointA.x == pointB.x or pointA.y == pointB.y
      100
    else
      141
  flatDistance + climbFactor * Math.abs heightDifference
show weightedDistance (x: 0, y: 0), (x: 1, y: 1)

point = (x, y) -> {x, y} # Same as {x: x, y: y}
addPoints = (a, b) -> point a.x + b.x, a.y + b.y
samePoint = (a, b) -> a.x == b.x and a.y == b.y

show samePoint addPoints(point(10, 10), point(4, -2)),
                         point(14, 8)

# Exercise 29
show '--- Exercise 29 ---'
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
  filter (map directions,
              partial addPoints, from), insideMap

show possibleDirections point 0, 0
show '--- End of Exercise ---'

# Binary heap
show '--- Binary heap ---'
bh = require './A2-BinaryHeap'
globalize bh

heap = new BinaryHeap()
forEach [2, 4, 5, 1, 6, 3], (number) ->
  heap.push number

while heap.size() > 0
  show heap.pop()

# Exercise 30
show '--- Exercise 30 ---'
estimatedDistance = (pointA, pointB) ->
  dx = Math.abs pointA.x - pointB.x
  dy = Math.abs pointA.y - pointB.y
  if dx > dy
    (dx - dy) * 100 + dy * 141
  else
    (dy - dx) * 100 + dx * 141

show estimatedDistance point(3,3), point(9,6)
show '--- End of Exercise ---'

# Exercise 31
show '--- Exercise 31 ---'
makeReachedList = () -> {}

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

# Alternative
pointID = (point) ->
  point.x + '-' + point.y

makeReachedList = -> {}
storeReached = (list, point, route) ->
  list[pointID(point)] = route
findReached = (list, point) ->
  list[pointID(point)]
show '--- End of Exercise ---'

# Path finder
show '--- Path finder ---'
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

    forEach possibleDirections(route.point),
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

# Show route
show '--- Show route ---'
traverseRoute = (routes..., func) ->
  each [routes...], (route) ->
    while route
      func
        x: route.point.x
        y: route.point.y
      route = route.from

showRoute = (routes...) ->
  traverseRoute routes..., show

route = findRoute point(0, 0), point(19, 19)
showRoute route

# Multiple routes
show '--- Multiple routes ---'
showRoute findRoute(point( 0,  0), point(11, 17)),
          findRoute(point(11, 17), point(19, 19))

# Route canvas
show '--- Route canvas ---'
webpage = kup.render -> 
  doctype 5
  html ->
    head ->
      meta charset: 'utf-8'
      title 'Route'
      style '''
        body {font-family: sans-serif}
        header, nav, section, footer {display: block}
        #background {position: absolute; top: 80px; left: 20px}
        #drawCanvas {position: absolute; top: 0px; left: 0px}
      '''
      coffeescript ->
        wsUri = 'ws://localhost:8080/'
        show = (msg) -> console.log msg
        circle = (ctx, x, y) ->
          ctx.strokeStyle = 'rgba(255,40,20,1)'
          ctx.fillStyle = 'rgba(255,40,20,0.7)'
          ctx.shadowOffsetX = 5
          ctx.shadowOffsetY = 5
          ctx.shadowBlur = 10
          ctx.shadowColor = 'black'
          ctx.beginPath()
          ctx.arc x*30+15, y*30+15, 10, 0, 2*Math.PI, false
          ctx.stroke()
          ctx.fill()
        window.onload = ->
          canvas = document.getElementById 'drawCanvas'
          context = canvas.getContext '2d'
          websocket = new WebSocket wsUri
          websocket.onopen = (evt) -> show evt
          websocket.onclose = (evt) -> show evt
          websocket.onerror = (evt) -> show evt
          websocket.onmessage = (evt) ->
            show evt
            vals = evt.data.split ' '
            x = parseInt vals[0], 10
            y = parseInt vals[1], 10
            circle context, x, y
            return
          return
    body ->
      header -> h1 'Route'
      div id: 'background', ->
        img src: '../img/height.png'
        canvas id: 'drawCanvas', width: 600, height: 600

renderRoute = (routes...) ->
  wsHandler = (websocket) ->
    websocket.on 'connect', (resource) ->
      traverseRoute routes..., (point) ->
        websocket.write "#{point.x} #{point.y}"
  wsServer = ws.createServer wsHandler
  wsServer.listen 8080
  viewServer webpage

renderRoute findRoute(point( 0,  0), point(11, 17)),
            findRoute(point(11, 17), point(19, 19))

setTimeout process.exit, 5000
