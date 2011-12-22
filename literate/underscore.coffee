
show = console.log
showDocument = (doc, width, height) -> show doc

if exports?
  _ = require 'underscore'
else
  _ = window._ # Workaround for interactive environment quirk.

view = (obj) ->
  show if typeof obj is 'object'
    """{#{"\n  #{k}: #{v}" for own k,v of obj}\n}"""
  else obj

tryIt = ->
  show view # Show equivalent JavaScript
  view {
    'JavaScript' : "we could have been the closest of friends"
    'EcmaScript' : "we might have been the world's greatest lovers"
    'But'        : "now we're just without each other"
  }
# Uncomment the next line to try it
# tryIt()
show _.map [ 1, 2, 3 ], (n) -> n * 2
show _([ 1, 2, 3 ]).map (n) -> n * 2
lyrics = [
  {line : 1, words : "I'm a lumberjack and I'm okay"}
  {line : 2, words : "I sleep all night and I work all day"}
  {line : 3, words : "He's a lumberjack and he's okay"}
  {line : 4, words : "He sleeps all night and he works all day"}
]
view _(lyrics).chain()
  .map((line) -> line.words.split " ")
  .flatten()
  .reduce(((counts, word) ->
    counts[word] = (counts[word] or 0) + 1
    counts), {})
  .value()
_.each [ 1, 2, 3 ], (num) -> show num
_.each {one : 1, two : 2, three : 3}, (num, key) -> show num
show _.map [ 1, 2, 3 ], (num) -> num * 3
show _.map
  one: 1
  two: 2
  three: 3
, (num, key) ->
  num * 3
show sum = _.reduce [1, 2, 3], ((memo, num) -> memo + num), 0
list = [ [ 0, 1 ], [ 2, 3 ], [ 4, 5 ] ]
flat = _.reduceRight list, (a, b) ->
  a.concat b
, []
show flat
show even = _.find [1..6], (num) -> num % 2 is 0
show evens = _.filter [1..6], (num) -> num % 2 is 0
show odds = _.reject [1..6], (num) -> num % 2 is 0
show _.all [true, 1, null, 'yes'], _.identity
show _.any [null, 0, 'yes', false]
show _.include [1, 2, 3], 3
show _.invoke [[5, 1, 7], [3, 2, 1]], 'sort'
stooges = [
  {name : 'moe', age : 40}
  {name : 'larry', age : 50}
  {name : 'curly', age : 60}
]
show _.pluck stooges, 'name'
stooges = [
  {name : 'moe', age : 40}
  {name : 'larry', age : 50}
  {name : 'curly', age : 60}
]
view _.max stooges, (stooge) -> stooge.age
numbers = [10, 5, 100, 2, 1000]
show _.min numbers
show _.sortBy [1..6], (num) -> Math.sin num
view _.groupBy [1.3, 2.1, 2.4], (num) -> Math.floor num
view _.groupBy ['one', 'two', 'three'], 'length'
show _.sortedIndex [10, 20, 30, 40, 50], 35
show _.shuffle [1..6]
(-> show _.toArray(arguments).slice(0))(1, 2, 3)
show _.size {one : 1, two : 2, three : 3}
show _.first [5, 4, 3, 2, 1]
show _.initial [5, 4, 3, 2, 1]
show _.last [5, 4, 3, 2, 1]
show _.rest [5, 4, 3, 2, 1]
show _.compact [0, 1, false, 2, '', 3]
show _.flatten [1, [2], [3, [[[4]]]]]
show _.without [1, 2, 1, 0, 3, 1, 4], 0, 1
show _.union [1, 2, 3], [101, 2, 1, 10], [2, 1]
show _.intersection [1, 2, 3], [101, 2, 1, 10], [2, 1]
show _.difference [1, 2, 3, 4, 5], [5, 2, 10]
show _.uniq [1, 2, 1, 3, 1, 4]
show _.zip ['moe', 'larry', 'curly'], [30, 40, 50], [true, false, false]
show _.indexOf [1, 2, 3], 2
show _.lastIndexOf [1, 2, 3, 1, 2, 3], 2
show _.range 10
show _.range 1, 11
show _.range 0, 30, 5
show _.range 0, -10, -1
show _.range 0
func = (greeting) -> greeting + ': ' + this.name
func = _.bind func, {name : 'moe'}, 'hi'
show func()
timeIt = (func, a...) ->
  before = new Date
  result = func a...
  show "Elapsed: #{new Date - before}ms"
  result

fibonacci = _.memoize (n) ->
  if n < 2 then n else fibonacci(n - 1) + fibonacci(n - 2)

show timeIt fibonacci, 1000
show timeIt fibonacci, 1000
log = _.bind show, console
_.delay log, 1, 'logged later'
# See the end of this document for the output
_.defer -> show 'deferred'
# See the end of this document for the output
updatePosition = (evt) -> show "Position #{evt}"
throttled = _.throttle updatePosition, 100
for i in [0..10]
  throttled i
# $(window).scroll throttled
calculateLayout = -> show "It's quiet now"
lazyLayout = _.debounce calculateLayout, 100
lazyLayout()
# $(window).resize lazyLayout
createApplication = -> show "Created"
initialize = _.once createApplication
initialize()
initialize()
# Application is only created once.
skipFirst = _.after 3, show
for i in [0..3]
  skipFirst i
hello = (name) -> "hello: " + name
hello = _.wrap hello, (func) ->
  "before, #{func "moe"}, after"
show hello()
greet    = (name) -> "hi: " + name
exclaim  = (statement) -> statement + "!"
welcome = _.compose exclaim, greet
show welcome 'moe'
show _.keys {one : 1, two : 2, three : 3}
show _.values {one : 1, two : 2, three : 3}
show _.functions _
view _.extend {name : 'moe'}, {age : 50}
iceCream = {flavor : "chocolate"}
view _.defaults iceCream, {flavor : "vanilla", sprinkles : "lots"}
view _.clone {name : 'moe'}
show _([1,2,3,200]).chain().
  filter((num) -> num % 2 is 0).
  tap(show).
  map((num) -> num * num).
  value()
moe   = {name : 'moe', luckyNumbers : [13, 27, 34]}
clone = {name : 'moe', luckyNumbers : [13, 27, 34]}
moe is clone
show _.isEqual(moe, clone)
show _.isEmpty([1, 2, 3])
show _.isEmpty({})
show _.isElement document?.getElementById 'page'
show (-> _.isArray arguments)()
show _.isArray [1,2,3]
show (-> _.isArguments arguments)(1, 2, 3)
show _.isArguments [1,2,3]
show _.isFunction console.debug
show _.isString "moe"
show _.isNumber 8.4 * 5
show _.isBoolean null
show _.isDate new Date()
show _.isRegExp /moe/
show _.isNaN NaN
show isNaN undefined
show _.isNaN undefined
show _.isNull null
show _.isNull undefined
show _.isUndefined window?.missingVariable
# The examples will stop working if this is enabled
# underscore = _.noConflict()
moe = {name : 'moe'}
show moe is _.identity(moe)
(genie = {}).grantWish = -> show 'Served'
_(3).times -> genie.grantWish()
_.mixin
  capitalize : (string) ->
    string.charAt(0).toUpperCase() +
    string.substring(1).toLowerCase()
show _("fabio").capitalize()
show _.uniqueId 'contact_'
show _.uniqueId 'contact_'
show _.escape 'Curly, Larry & Moe'
compiled = _.template "hello: <%= name %>"
show compiled name : 'moe'
list = "<% _.each(people, function(name) { %> <li><%= name %></li> <% }); %>"
show _.escape _.template list, people : ['moe', 'curly', 'larry']
template = _.template "<b><%- value %></b>"
show _.escape template value : '<script>'
compiled = _.template "<% print('Hello ' + epithet) %>"
show compiled {epithet: "stooge"}
saveSettings = _.templateSettings
_.templateSettings = interpolate : /\{\{(.+?)\}\}/g

template = _.template "Hello {{ name }}!"
show template name : "Mustache"

_.templateSettings = saveSettings
stooges = [
  {name : 'curly', age : 25}
  {name : 'moe', age : 21}
  {name : 'larry', age : 23}
]
youngest = _(stooges).chain()
  .sortBy((stooge) -> stooge.age)
  .map((stooge) -> stooge.name + ' is ' + stooge.age)
  .first()
  .value()
show youngest
show _([1, 2, 3]).value()
show 'Delayed output will show up here'
