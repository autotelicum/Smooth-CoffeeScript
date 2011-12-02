draw = (ctx) -> # Try changing colors below
  ctx.beginPath(); ctx.strokeStyle = 'gold'
  drawMove ctx, (ix for ix in [0...90] by 10)
  ctx.beginPath(); ctx.strokeStyle = 'salmon'
  drawPath ctx, (ix for ix in [0...90] by 10)

movement = (ctx, ax, ay, cp1x, cp1y, cp2x, cp2y, x, y) ->
  ctx.moveTo ax, ay
  ctx.bezierCurveTo cp1x, cp1y, cp2x, cp2y, x, y

drawMove = (ctx, args) ->
  args.forEach (ix) -> movement ctx,
    0, 0, 30, 30, 150+ix, 50, 110+ix, 90
  ctx.stroke()
_ = undefined
partialFree = (func, a...) -> (b...) ->
  b.reverse()
  func (for arg in a then arg ?= b.pop())...

swirl = partialFree movement, _, _, 0, 30, 30, _, 50, _, 90

drawPath = (ctx, args) ->
  args.forEach (ix) -> swirl ctx, 200, 150+ix, 110+ix
  ctx.stroke()
_ = {}
partial15lines = () ->
  [func, args...] = arguments
  wrapper = () ->
    i = 0
    j = 0
    res_args = []
    while i < args.length
      if args[i] == _
        res_args.push arguments[j]
        j++
      else
        res_args.push args[i]
      i++
    return func.apply null, res_args
_ = {}
partial12lines = (func, args...) ->
  (moreargs...) ->
    i = j = 0
    res_args = []
    while i < args.length
      if args[i] == _
        res_args.push moreargs[j++]
      else
        res_args.push args[i]
      i++
    func.apply null, res_args
_ = {}
partial10lines = (func, args...) ->
  (moreargs...) ->
    i = j = 0
    func.apply null,
      while i++ < args.length
        if args[i-1] == _
          moreargs[j++]
        else
          args[i-1]
_ = {}
partial8lines = (func, a...) -> (b...) ->
  i = 0
  func (for arg in a
    if arg is _
      b[i++]
    else
      arg)...
_ = {}
partial5lines = (func, a...) -> (b...) ->
  b.reverse()
  func (for arg in a
    if arg is _ then b.pop() else arg)...
_ = undefined
partial4lines = (func, a...) -> (b...) ->
  b.reverse()
  func (for arg in a then arg ?= b.pop())...
test = ->
  f = (x, y, z) -> x + 2*y + 5*z
  g = partialFree f, _, 1, _
  show "g 3, 5 => #{g 3, 5} Expected: 30"

  # Modified from an alexkg example
  fold = (f, z, xs) ->
    z = f(z, x) for x in xs
    z
  max = partialFree fold, Math.max, -Infinity, _
  show "max [-10..10] => #{max [-10..10]} Expected: 10"

  # Without free vars
  partial = (f, a...) -> (b...) -> f a..., b...
  min = partial fold, Math.min, Infinity
  show "min [-10..10] => #{min [-10..10]} Expected: -10"
partialFree = partial4lines
test()
