
show = console.log
showDocument = (doc, width, height) -> show doc

kup = if exports? then require 'coffeekup' else window.CoffeeKup

webapp = ->
  doctype 5
  html ->
    head ->
      meta charset: 'utf-8'
      title 'Histogram'
      style 'body        {color: #FFFFFF;  background-color: #404040}
             #background {position: absolute; top:  40px; left: 20px}
             #image      {position: absolute; top:   0px; left: 80px}
             #picture    {position: absolute; top:   0px; left: 80px}
             #histogram  {position: absolute; top: 140px; left:  0px}'
    body ->
      div id: 'background', ->
        img    id: 'image', width: 90, height: 90, \
          src: window?.ostrich ? '../img/ostrich.jpg'
        canvas id: 'picture', width: 90, height: 90
        canvas id: 'histogram', width: 256, height: 100, \
          onClick: 'onChange()'
    coffeescript ->
      hues =
        red:      'rgba(255, 128, 128, 0.5)'
        green:    'rgba(128, 255, 128, 0.5)'
        blue:     'rgba(128, 128, 255, 0.5)'
        alpha:    'rgba(128, 128, 128, 0.5)'
      legend    = ['∀', 'R', 'G', 'B', 'α']
      textColor = '#F7C762'
      textFont  = '12pt Times'
      textPos   = x:230, y:-80
      view      = 0
      analyze = (data) ->
        bins = red: [], green: [], blue: [], alpha: []
        for name, bin of bins
          bin[i] = 0 for i in [0..255]
        for val, i in data
          switch i % 4
            when 0 then bins.red[val]++
            when 1 then bins.green[val]++
            when 2 then bins.blue[val]++
            when 3 then bins.alpha[val]++
        bins
      drawGraphs = (ctx, graphs) ->
        drawPlot = (ctx, plot, color) ->
          ctx.fillStyle = color
          ctx.beginPath()
          ctx.moveTo 0, 0
          for y, x in plot
            ctx.lineTo x, y
          ctx.lineTo plot.length, 0
          ctx.closePath()
          ctx.fill()

        ctx.translate 0, ctx.canvas.height
        ctx.fillStyle = textColor
        ctx.font = textFont
        ctx.fillText  legend[view], textPos.x, textPos.y
        ctx.scale 1, -1                        # flip y-axis
        drawPlot ctx, graphs.red,   hues.red   if view in [0, 1]
        drawPlot ctx, graphs.green, hues.green if view in [0, 2]
        drawPlot ctx, graphs.blue,  hues.blue  if view in [0, 3]
        drawPlot ctx, graphs.alpha, hues.alpha if view in [0, 4]
      window.onload = ->
        $ = (element) -> document.getElementById element
        @image = $ 'image'
        @canvas = $ 'picture'
        @histogram = $ 'histogram'

        @context = canvas.getContext '2d'
        @plot = histogram.getContext '2d'
        unless @context? or @plot?
          alert 'No canvas in this browser.'
          return
        window.onChange()
      window.onChange = ->
        @histogram.width = @histogram.width     # reset
        @plot.clearRect 0, 0, @histogram.width, @histogram.height
        @context.drawImage @image, 0, 0

        picture = @context.getImageData 0, 0,
          @image.width, @image.height
        graphs = analyze picture.data
        drawGraphs @plot, graphs, view

        if 0 < view < 4
          picture = @context.getImageData 0, 0,
            @image.width, @image.height
          for i in [0...picture.data.length] by 1
            unless i%4 in [3, view-1] # unless alpha or current
              picture.data[i] = 0
          @context.putImageData picture, 0, 0

        if view++ is 4 then view = 0
        return
webpage = kup.render webapp, format:on
showDocument webpage
