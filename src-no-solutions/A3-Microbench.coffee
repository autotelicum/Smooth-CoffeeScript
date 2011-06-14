# CoffeeScript
show = console.log

start = new Date()
N = 1000000
a = Array(N)
for i in [0...N]
  a[i] = Math.random()

s = 0
for v in a
  s += v

t = 0
for v in a
  t += v*v
t = Math.sqrt t

duration = new Date() - start
show "N: #{N} in #{duration*0.001} s"
show "Result: #{s} and #{t}"
