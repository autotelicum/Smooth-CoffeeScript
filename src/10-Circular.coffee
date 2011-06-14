
Pi2 = Math.PI*2
# Create an array with angles on the unit circle.
angles = (angle for angle in [0...Pi2] by 1/3*Math.PI)
# Remove the last element if 2*PI were included
# due to floating point rounding on additions.
epsilon = 1e-14
lastAngle = angles[angles.length - 1]
# Use an interval to test floating point value
if Pi2 - epsilon < lastAngle < Pi2 + epsilon
  angles.length = angles.length - 1

# Encapsulation of a pair of (x, y) coordinates
class Point
  constructor: (@x, @y) ->
  toString: -> "{x:#{@x.toPrecision 4}," +
               " y:#{@y.toPrecision 4}}"

# Math class that returns points on the unit
# circle, offset by step if given non-zero.
class CircularPosition
  constructor: (@_step = 0) -> @_count = 0
  nextPoint: ->
    index = @_count % angles.length 
    angle = angles[index] + @_step * @_count++
    new Point Math.cos(angle), Math.sin(angle)

(exports ? this).CircularPosition = CircularPosition
