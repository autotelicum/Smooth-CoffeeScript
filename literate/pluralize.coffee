
show = console.log
showDocument = (doc, width, height) -> show doc

test = (func) ->
  for points in [-3..3]
    func points
test (points) ->
  show "0: You got #{points} point#{if points > 1 then 's' else ''}"
test (points) ->
  pluralIf = (stem, cond) -> stem + (if cond then 's' else '')
  show "1: You got #{points} #{pluralIf 'point', points > 1}"
test (points) ->
  pluralUnless = (stem, cond) -> stem + (unless cond then 's' else '')
  show "2: You got #{points} #{pluralUnless 'point', -2 < points < 2}"
test (points) ->
  String::pluralIf ?= (cond) -> this + (if cond then 's' else '')
  show "3: You got #{points} #{'point'.pluralIf points > 1}"
test (points) ->
  show "4: You got #{points} point#{('s' if points > 1) ? ''}"
test (points) ->
  show "5: You got #{points} point#{['','s'][+(points > 1)]}"
test (points) ->
  show "6: You got #{points} point#{'s'.charAt points <= 1}"
test (points) ->
  show "7: You got #{points} point#{Array(1+(points>1)).join 's'}"
test (points) ->
  show "8: You got #{points} point#{[].concat ('s' if points > 1)}"
test (points) ->
  show "9: You got #{points} point#{['s' if points > 1]}"
