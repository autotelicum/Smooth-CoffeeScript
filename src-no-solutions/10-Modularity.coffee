require './prelude'

# Top level environment
show '--- Top level environment ---'
show global.process.argv[0]
show global.console.log == console.log
show global.global.global.global.global.console

# Pollution
show '--- Pollution ---'
HTML =
  tag: (name, content, properties) ->
    name: name
    properties: properties
    content: content
  link: (target, text) ->
    HTML.tag 'a', [text], {href: target}
  # ... many more HTML-producing functions ...

globalize HTML
show link 'http://citeseerx.ist.psu.edu/viewdoc/' +
  'download?doi=10.1.1.102.244&rep=rep1&type=pdf',
  'What Every Computer Scientist Should Know ' +
  'About Floating-Point Arithmetic'

# Unfriendly function
show '--- Unfriendly function ---'
range = (start, end, stepSize, length) ->
  if stepSize == undefined
    stepSize = 1
  if end == undefined
    end = start + stepSize * (length - 1)
  result = []
  while start <= end
    result.push start
    start += stepSize
  result
show range 0, undefined, 4, 5

# Object argument
show '--- Object argument ---'
defaultTo = (object, values) ->
  for name, value of values
    if not object.hasOwnProperty name
      object[name] = value

range = (args) ->
  defaultTo args, {start: 0, stepSize: 1}
  if args.end == undefined
    args.end = args.start +
               args.stepSize * (args.length - 1)
  result = [];
  while args.start <= args.end
    result.push args.start
    args.start += args.stepSize
  result
show range {stepSize: 4, length: 5}

# CoffeeScript eval
show '--- CoffeeScript eval ---'
eval 'function IamJavaScript() {' +
     '  console.log(\"Repeat after me:' +
     ' Give me more {();};.\");};' +
     ' IamJavaScript();'

cs = (require 'coffee-script').CoffeeScript
cs.eval 'show ((a, b) -> a + b) 3, 4'


