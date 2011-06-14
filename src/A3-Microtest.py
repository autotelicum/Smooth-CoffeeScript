# CPython
import time
import random
import math

start = time.clock()
N = 1000000
a = [random.random()
  for i in range(N)]

s = 0
for v in a:
  s += v

t = 0
for v in a:
  t += v*v
t = math.sqrt(t)

duration = time.clock() - start
print 'N:', N, 'in', duration, 's'
print 'Result:', s, 'and', t
