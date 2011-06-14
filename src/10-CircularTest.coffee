cp = require "./10-Circular"
show = console.log

circ = new cp.CircularPosition 0.01
for i in [0...6]
  show "#{i}: #{circ.nextPoint()}"

try
  show "Instantiating a new Point:"
  p = new cp.Point 0, 0
  show "Created a Point"
catch e then show e.message

show "CircularPosition namespace:"
show cp
