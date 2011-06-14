kup = require './prelude/coffeekup'

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
      # DO NOT USE: type: 'text/coffeescript'
      script src: './10-Circular.coffee'

      coffeescript ->
        draw = (ctx, x, y) ->
          circle = (ctx, x, y) ->
            ctx.beginPath()
            ctx.arc x, y, 100, 0, 2*Math.PI, false
            ctx.stroke()
          ctx.strokeStyle = 'rgba(255,40,20,0.7)'
          circle ctx, x, y
          circ = new CircularPosition()
          for i in [0...6]
            pt = circ.nextPoint()
            circle ctx, x+100*pt.x, y+100*pt.y
        window.onload = ->
          canvas = document.getElementById 'drawCanvas'
          context = canvas.getContext '2d'
          draw context, 300, 200
    body ->
      header -> h1 'Seed of Life'
      canvas id: 'drawCanvas', width: 600, height: 400

# Server-side HTTP server
show = console.log
http = require "http"
fs = require "fs"
cs = require("coffee-script").CoffeeScript
server = http.createServer (req, res) ->
  show "#{req.client.remoteAddress} " +
       "#{req.method} #{req.url}"
  if req.method is "GET"
    if req.url is "/"
      res.writeHead 200, "Content-Type": "text/html"
      res.write webpage
      res.end()
      return
    else if req.url is "/10-Circular.coffee"
      fs.readFile ".#{req.url}", "utf8", (err, data) ->
        if err then throw err
        compiledContent = cs.compile data
        res.writeHead 200,
          "Content-Type": "application/javascript"
        res.write compiledContent
        res.end()
      return
  res.writeHead 404, "Content-Type": "text/html"
  res.write "404 Not found"
  res.end()
server.listen 3389
show "Server running at"
show server.address()
