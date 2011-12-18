
show = console.log
showDocument = (doc, width, height) -> show doc

class Point
  constructor: (@x, @y) ->
  draw: (ctx) -> ctx.fillRect @x, @y, 1, 1
  toString: -> "(#{@x}, #{@y})"
euclidean = (p1, p2) ->
  [a, b] = [p1?.x - p2?.x, p1?.y - p2?.y]
  Math.sqrt(Math.pow(a, 2) + Math.pow(b, 2))
draw = (ctx) ->
  # A hard-coded approximate figure
  ctx.beginPath()
  ctx.fillStyle = 'crimson'
  ctx.font = '14pt Times'
  ctx.fillText 'a² + b² = c²', 27, 110

  ctx.fillText 'a', 66, 74
  ctx.beginPath()
  ctx.strokeStyle = 'hotpink'
  ctx.strokeRect 60, 60, 20, 20

  ctx.fillText 'b', 46, 47
  ctx.beginPath()
  ctx.strokeStyle = 'tomato'
  ctx.strokeRect 20, 20, 40, 40

  ctx.fillText 'c', 74, 42
  ctx.beginPath()
  ctx.strokeStyle = 'darkorange'
  ctx.moveTo 60, 20
  ctx.lineTo 80, 60
  ctx.lineTo 120, 40
  ctx.lineTo 100, 0
  ctx.lineTo 60, 20
  ctx.stroke()
hypot = (a, b) ->
  if a is 0
    Math.abs(b)
  else
    Math.abs(a) * Math.sqrt(1 + Math.pow(b/a, 2))
hypotenuse = (p1, p2) ->
  [a, b] = [p1?.x - p2?.x, p1?.y - p2?.y]
  hypot a, b
polar = (p) ->
  [x, y] = [p.x, p.y]
  r = hypot(x, y)
  θ = Math.atan2(y, x)
  [r, θ]
show 'Distance from (0, 0), angle in 2π radians'
show polar new Point 1, 1
show "euclidean vs hypotenuse"
p1 = p2 = undefined
show "#{euclidean p1, p2} vs #{hypotenuse p1, p2}"

p1 = new Point 0, 0
p2 = new Point 0, 0
show "#{euclidean p1, p2} vs #{hypotenuse p1, p2}"

p1 = new Point 1e-200, 1e-200
p2 = new Point 2e-200, 2e-200
show "#{euclidean p1, p2} vs #{hypotenuse p1, p2}"

p1 = new Point 1e200, 1e200
p2 = new Point 2e200, 2e200
show "#{euclidean p1, p2} vs #{hypotenuse p1, p2}"
unless exports?
  _ = window._ # Workaround for interactive environment quirk.
else
  show = console.log
  _ = require 'underscore'
  qc = require 'qc'
  # Import functions into the global namespace with globalize,
  # so that they do not need to be qualified each time.
  globalize = (ns, target = global) ->
    target[name] = ns[name] for name of ns
  # qc is only used for testing so ignore namespace pollution.
  globalize qc

if exports?
  # Set to `no` to get monochrome output
  useColors = no

  # Node colored output for QuickCheck.
  class NodeListener extends ConsoleListener
    constructor: (@maxCollected = 10) ->
    log: (str) -> show str
    passed: (str) -> # print message in green
      console.log if useColors then "\033[32m#{str}\033[0m" else "#{str}"
    invalid: (str) -> # print message in yellow
      console.warn if useColors then "\033[33m#{str}\033[0m" else "#{str}"
    failure: (str) -> # print message in red
      console.error if useColors then "\033[31m#{str}\033[0m" else "#{str}"
    done: ->
      show 'Completed test.'
      resetProps() # Chain here if needed

  # Enhanced noteArg returning its argument so it can be used inline.
  Case::note = (a) -> @noteArg a; a
  # Same as Case::note but also logs the noted args.
  Case::noteVerbose = (a) -> @noteArg a; show @args; a
  
  # Helper to declare a named test property for
  # a function func taking types as arguments.
  # Property is passed the testcase, the arguments
  # and the result of calling func, it must return
  # a boolean indicating success or failure.
  testPure = (func, types, name, property) ->
    declare name, types, (c, a...) ->
      c.assert property c, a..., c.note func a...
  
  # Default qc configuration with 100 pass and 1000 invalid tests
  qcConfig = new Config 100, 1000
  
  # Test all known properties
  test = (msg, func) ->
    _.each [msg, func, runAllProps qcConfig, new NodeListener],
      (o) -> unless _.isUndefined o then show o
declare 'same results for normal range numbers',
  [arbInt, arbInt, arbInt, arbInt],
  (c, x1, y1, x2, y2) ->
    p1 = new Point x1, y1
    p2 = new Point x2, y2
    d1 = euclidean p1, p2
    d2 = hypotenuse p1, p2
    diff = (d1 - d2)
    epsilon = 1e-10
    c.assert -epsilon < diff < epsilon
arbBig = arbRange(1e155, 1e165)
declare 'different results for big range numbers',
  [arbBig, arbBig, arbBig, arbBig],
  (c, x1, y1, x2, y2) ->
    p1 = new Point x1, y1
    p2 = new Point x2, y2
    d1 = euclidean p1, p2
    d2 = hypotenuse p1, p2
    diff = Math.abs d1 - d2
    epsilon = 1e-10
    c.assert diff > epsilon
declare 'different results for large numbers',
  [arbInt, arbInt, arbInt, arbInt, arbInt, arbInt],
  (c, x1, y1, e1, x2, y2, e2) ->
    p1 = new Point x1*Math.pow(10, e1), y1*Math.pow(10, e1)
    p2 = new Point x2*Math.pow(10, e2), y2*Math.pow(10, e2)
    d1 = euclidean p1, p2
    d2 = hypotenuse p1, p2
    diff = Math.abs d1 - d2
    c.guard diff > 1
    exp = 9
    c.assert e1 < -exp or e1 > exp or e2 < -exp or e2 > exp
do test
