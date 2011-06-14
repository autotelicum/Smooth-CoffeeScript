require './prelude'
bh = require './A2-BinaryHeap'
# Bring _, qc and bh into global
globalize _
globalize qc
globalize bh

# Declarative Tests
#-------------------
sortByValue = (obj) -> sortBy obj, (n) -> n
buildHeap = (c, a) ->
    heap = new BinaryHeap
    heap.push number for number in a
    c.note heap

declare 'heap is created empty', [],
  (c) -> c.assert (new BinaryHeap).size() == 0

declare 'heap pop is undefined when empty', [],
  (c) -> c.assert isUndefined (new BinaryHeap).pop()

declare 'heap contains number of inserted elements',
  [arbArray(arbInt)], (c, a) ->
    c.assert buildHeap(c, a).size() == a.length

declare 'heap contains inserted elements',
  [arbArray(arbInt)], (c, a) ->
    heap = buildHeap c, a
    c.assert isEqual sortByValue(a), \
      sortByValue(heap.content)

declare 'heap pops elements in sorted order',
  [arbArray(arbInt)], (c, a) ->
    heap = buildHeap c, a
    for n in sortByValue a then c.assert n == heap.pop()
    c.assert heap.size() == 0

declare 'heap does not remove non-existent elements',
  [arbArray(arbInt), arbInt],
  expectException (c, a, b) ->
    if b in a then c.guard false
    heap = buildHeap c, a
    heap.remove b

declare 'heap removes existing elements',
  [arbArray(arbInt), arbInt], (c, a, b) ->
    if not (b in a) then c.guard false
    aSort = sortByValue without a, b
    count = a.length - aSort.length
    heap = buildHeap c, a
    heap.remove b for i in [0...count]
    for n in aSort then c.assert n == heap.pop()
    c.assert heap.size() == 0

test()
