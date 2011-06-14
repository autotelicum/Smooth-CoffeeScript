require './prelude'
# Bring underscore into global
globalize _

# Attach function
show '--- Attach function ---'
rabbit = {}
rabbit.speak = (line) ->
  show "The rabbit says '#{line}'"
rabbit.speak "Well, now you're asking me."

# Object programming
show '--- Object programming ---'
speak = (line) ->
  show "The #{this.adjective} rabbit says '#{line}'"

whiteRabbit = adjective: "white", speak: speak
fatRabbit = adjective: "fat", speak: speak

whiteRabbit.speak "Oh my ears and whiskers, " +
                  "how late it's getting!"
fatRabbit.speak "I could sure use a carrot right now."

speak.apply fatRabbit, ['Yum.']
speak.call fatRabbit, 'Burp.'

# Class concept
show '--- Class concept ---'
class Rabbit
  constructor: (@adjective) ->
  speak: (line) ->
    show "The #{@adjective} rabbit says '#{line}'"

whiteRabbit = new Rabbit "white"
fatRabbit = new Rabbit "fat"

whiteRabbit.speak "Hurry!"
fatRabbit.speak "Tasty!"

# New constructor
show '--- New constructor ---'
killerRabbit = new Rabbit 'killer'
killerRabbit.speak 'GRAAAAAAAAAH!'
show killerRabbit

makeRabbit = (adjective) ->
  adjective: adjective
  speak: (line) -> show adjective + ': ' + line
blackRabbit = makeRabbit 'black'

show killerRabbit.constructor.name
show blackRabbit.constructor.name

# Extends keyword
show '--- Extends keyword ---'
class WeightyRabbit extends Rabbit
  constructor: (adjective, @weight) ->
    super adjective
  adjustedWeight: (relativeGravity) ->
    (@weight * relativeGravity).toPrecision 2

tinyRabbit = new WeightyRabbit "tiny", 1.01
jumboRabbit = new WeightyRabbit "jumbo", 7.47

moonGravity = 1/6
jumboRabbit.speak "Carry me, I weigh #{jumboRabbit.adjustedWeight(moonGravity)} stones"
tinyRabbit.speak "He ain't heavy, he is my brother"


# Inheritance pitfalls
show '--- Inheritance pitfalls ---'
class Account
  constructor: -> @balance = 0
  transfer: (amount) -> @balance += amount
  getBalance: -> @balance
  batchTransfer: (amtList) ->
    for amount in amtList
      @transfer amount

yourAccount = new Account()
oldBalance = yourAccount.getBalance()
yourAccount.transfer salary = 1000
newBalance = yourAccount.getBalance()
show "Books balance: #{salary == newBalance - oldBalance}."

# Violation of substitution property
show '--- Violation of substitution property ---'
class AccountWithFee extends Account
  fee: 5
  transfer: (amount) ->
    super amount - @fee
    # feeAccount.transfer @fee

yourAccount = new AccountWithFee()
oldBalance = yourAccount.getBalance()
yourAccount.transfer salary = 1000
newBalance = yourAccount.getBalance()
show "Books balance: #{salary == newBalance - oldBalance}."

# Limited account class
show '--- Limited account class ---'
class LimitedAccount extends Account
  constructor: -> super; @resetLimit()
  resetLimit: -> @dailyLimit = 50
  transfer: (amount) ->
    if amount < 0 and (@dailyLimit += amount) < 0
      throw new Error "You maxed out!"
    else
      super amount
lacc = new LimitedAccount()
lacc.transfer 50
show "Start balance #{lacc.getBalance()}"

try lacc.batchTransfer [-1..-10]
catch error then show error.message
show "After batch balance #{lacc.getBalance()}"

# Fragile base class
show '--- Fragile base class ---'
class Account
  constructor: -> @balance = 0
  transfer: (amount) -> @balance += amount
  getBalance: -> @balance
  batchTransfer: (amtList) ->
    add = (a,b) -> a+b
    sum = (list) -> reduce list, add, 0
    @balance += sum amtList

class LimitedAccount extends Account
  constructor: -> super; @resetLimit()
  resetLimit: -> @dailyLimit = 50
  transfer: (amount) ->
    if amount < 0 and (@dailyLimit += amount) < 0
      throw new Error "You maxed out!"
    else
      super amount

lacc = new LimitedAccount()
lacc.transfer 50
show "Starting with #{lacc.getBalance()}"

try lacc.batchTransfer [-1..-10]
catch error then show error.message
show "After batch balance #{lacc.getBalance()}"

# Prototypes
show '--- Prototypes ---'
simpleObject = {}
show simpleObject.constructor.name
show simpleObject.toString()

show Rabbit.prototype
show Rabbit.prototype.constructor.name
Rabbit.prototype.speak 'I am generic'
Rabbit::speak 'I am not initialized'

show killerRabbit.toString == simpleObject.toString

# Shared properties
show '--- Shared properties ---'
Rabbit::teeth = 'small'
show killerRabbit.teeth
killerRabbit.teeth = 'long, sharp, and bloody'
show killerRabbit.teeth
show Rabbit::teeth

Rabbit::dance = ->
  show "The #{@adjective} rabbit dances a jig."
killerRabbit.dance()

Rabbit = (adjective) ->
  @adjective = adjective

Rabbit::speak = (line) ->
  show "The #{@adjective} rabbit says '#{line}'"

hazelRabbit = new Rabbit "hazel"
hazelRabbit.speak "Good Frith!"

# Exposed properties
show '--- Exposed properties ---'
noCatsAtAll = {}
if "constructor" of noCatsAtAll
  show "Yes, there is a cat called 'constructor'."

Object::allProperties = ->
  for property of this
    property

test = x: 10, y: 3
show test.allProperties()

Object::ownProperties = ->
  for own property of @
    property

test = 'Fat Igor': true, 'Fireball': true
show test.ownProperties()

# Function forEachOf
show '--- Function forEachOf ---'
forEachOf = (object, action) ->
  for own property, value of object
    action property, value

chimera = head: "lion", body: "goat", tail: "snake"
forEachOf chimera, (name, value) ->
  show "The #{name} of a #{value}."

# Object methods
show '--- Object methods ---'
forEachIn = (object, action) ->
  for property of object
    if (Object::hasOwnProperty.call(object, property))
      action property, object[property]

test = name: "Mordecai", hasOwnProperty: "Uh-oh"
forEachIn test, (name, value) ->
  show "Property #{name} = #{value}"

for own property, value of test
  show "Property #{property} = #{value}"

obj = foo: 'bar'
# This test is needed to avoid hidden properties ...
show Object::hasOwnProperty.call(obj, 'foo') and
     Object::propertyIsEnumerable.call(obj, 'foo')
# ... because this returns true ...
show Object::hasOwnProperty.call(obj, '__proto__')
# ... this is required to get false.
show Object::hasOwnProperty.call(obj, '__proto__') and
     Object::propertyIsEnumerable.call(obj, '__proto__')

# Dictionary
show '--- Dictionary ---'
class Dictionary
  constructor: (@values = {}) ->

  store: (name, value) ->
    @values[name] = value

  lookup: (name) ->
    @values[name]

  contains: (name) ->
    Object::hasOwnProperty.call(@values, name) and
    Object::propertyIsEnumerable.call(@values, name)

  each: (action) ->
    for own property, value of @values
      action property, value

colours = new Dictionary
  Grover: 'blue'
  Elmo:   'orange'
  Bert:   'yellow'

show colours.contains 'Grover'
colours.each (name, colour) ->
  show name + ' is ' + colour

