require './prelude'

# Summation using a while loop
show '--- Summation using a while loop ---'
total = 0
count = 1
while count <= 10
  total += count
  count += 1
show total


# Summation using a for loop
show '--- Summation using a for loop ---'
total = 0
total += count for count in [1..10]
show total


# Summation using a reduce function
show '--- Summation using a reduce function ---'
sum = (v) -> _.reduce v, ((a,b) -> a+b), 0
show sum [1..10]


# Summation using reduce attached to Array
show '--- Summation using reduce attached to Array ---'
Array::sum ?= -> @reduce ((a,b) -> a+b), 0
show [1..10].sum()

