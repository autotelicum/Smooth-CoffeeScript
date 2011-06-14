
class BinaryHeap

  # Public
  #--------
  constructor: (@scoreFunction = (x) -> x) ->
    @content = []

  push: (element) ->
    # Add the new element to the end of the array.
    @content.push element
    # Allow it to bubble up.
    @_bubbleUp @content.length - 1
  
  pop: ->
    # Store the first element so we can return it later.
    result = @content[0]
    # Get the element at the end of the array.
    end = @content.pop()
    # If there are any elements left, put the end
    # element at the start, and let it sink down.
    if @content.length > 0
      @content[0] = end
      @_sinkDown 0
    result

  size: -> @content.length

  remove: (node) ->
    len = @content.length
    # To remove a value, we must search through the
    # array to find it.
    for i in [0...len]
      if @content[i] == node
        # When it is found, the process seen in 'pop'
        # is repeated to fill up the hole.
        end = @content.pop()
        if i != len - 1
          @content[i] = end
          if @scoreFunction(end) < @scoreFunction(node)
            @_bubbleUp i
          else
            @_sinkDown i
        return
    throw new Error 'Node not found.'

  # Private
  #---------
  _bubbleUp: (n) ->
    # Fetch the element that has to be moved.
    element = @content[n]
    # When at 0, an element can not go up any further.
    while n > 0
      # Compute the parent element index, and fetch it.
      parentN = Math.floor((n + 1) / 2) - 1
      parent = @content[parentN]
      # Swap the elements if the parent is greater.
      if @scoreFunction(element) < @scoreFunction(parent)
        @content[parentN] = element
        @content[n] = parent
        # Update 'n' to continue at the new position.
        n = parentN
      # Found a parent that is less,
      # no need to move it further.
      else
        break
    return

  _sinkDown: (n) ->
    # Look up the target element and its score.
    length = @content.length
    element = @content[n]
    elemScore = @scoreFunction element
    loop
      # Compute the indices of the child elements.
      child2N = (n + 1) * 2
      child1N = child2N - 1
      # This is used to store the new position of
      # the element, if any.
      swap = null
      # If the first child exists (is inside the array)...
      if child1N < length
        # Look it up and compute its score.
        child1 = @content[child1N]
        child1Score = this.scoreFunction child1
        # If the score is less than our elements,
        # we need to swap.
        if child1Score < elemScore
          swap = child1N
      # Do the same checks for the other child.
      if child2N < length
        child2 = @content[child2N]
        child2Score = @scoreFunction child2
        compScore = if swap == null
            elemScore
          else
            child1Score
        if child2Score < compScore
          swap = child2N
      # If the element needs to be moved,
      # swap it, and continue.
      if swap != null
        @content[n] = @content[swap]
        @content[swap] = element
        n = swap
      # Otherwise, we are done.
      else
        break
    return

(exports ? this).BinaryHeap = BinaryHeap
