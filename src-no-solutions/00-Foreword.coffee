require './prelude'
# Client-side web page with canvas
webpage = kup.render -> 
  doctype 5
  html ->
    head ->
      meta charset: 'utf-8'
      title 'My drawing | My awesome website'
      style '''
        body {font-family: sans-serif}
        header, nav, section, footer {display: block}
      '''
      coffeescript ->
        draw = (ctx, x, y) ->
          circle = (ctx, x, y) ->
            ctx.beginPath()
            ctx.arc x, y, 100, 0, 2*Math.PI, false
            ctx.stroke()
          ctx.strokeStyle = 'rgba(255,40,20,0.7)'
          circle ctx, x, y
          for angle in [0...2*Math.PI] by 1/3*Math.PI
            circle ctx, x+100*Math.cos(angle),
                        y+100*Math.sin(angle)
        window.onload = ->
          canvas = document.getElementById 'drawCanvas'
          context = canvas.getContext '2d'
          draw context, 300, 200
    body ->
      header -> h1 'Seed of Life'
      canvas id: 'drawCanvas', width: 600, height: 400
# Server-side HTTP server
http = require 'http'
server = http.createServer (req, res) ->
  show "#{req.client.remoteAddress} #{req.method} #{req.url}"
  res.writeHead 200, 'Content-Type': 'text/html'
  res.write webpage
  res.end()
server.listen 3389
show 'Server running at'
show  server.address()