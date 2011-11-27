show = if exports? then console.log else alert
test = (points) ->
  show "0: You got #{points} point#{if points > 1 then 's' else ''}"
  pluralIf = (stem, cond) -> stem + (if cond then 's' else '')
  show "1: You got #{points} #{pluralIf 'point', points > 1}"
  pluralUnless = (stem, cond) -> stem + (unless cond then 's' else '')
  show "2: You got #{points} #{pluralUnless 'point', -2 < points < 2}"
  String::pluralIf ?= (cond) -> this + (if cond then 's' else '')
  show "3: You got #{points} #{'point'.pluralIf points > 1}"
  show "4: You got #{points} point#{('s' if points > 1) ? ''}"
  show "5: You got #{points} point#{['','s'][+(points > 1)]}"
  show "6: You got #{points} point#{'s'.charAt points <= 1}"
  show "7: You got #{points} point#{Array(1+(points>1)).join 's'}"
  show "8: You got #{points} point#{[].concat ('s' if points > 1)}"
  show "9: You got #{points} point#{['s' if points > 1]}"
test n for n in [-3..3]
