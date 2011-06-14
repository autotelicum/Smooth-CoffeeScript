kup = require './prelude/coffeekup'

# Web page with canvas and client-side WebSocket
webpage = kup.render -> 
  doctype 5
  html ->
    head ->
      meta charset: 'utf-8'
      title 'My animation | My awesome website'
      style '''
        body {font-family: sans-serif}
        header, nav, section, footer {display: block}
      '''
      coffeescript ->
        show = (msg) -> console.log msg
        color = 'rgba(255,40,20,0.7)'
        circle = (ctx, x, y) ->
          ctx.strokeStyle = color
          ctx.beginPath()
          ctx.arc x, y, 100, 0, 2*Math.PI, false
          ctx.stroke()

        addElement = (ni, num, text) ->
          newdiv = document.createElement 'div'
          newdiv.setAttribute 'id', 'div' + num
          newdiv.innerHTML = text
          ni.appendChild newdiv

        wsUri = 'ws://localhost:8080/'
        websocket = undefined
        num = 0
        socketClient = (buffer, ctx, x, y) ->
          websocket = new WebSocket wsUri
          websocket.onopen = (evt) ->
            show 'Connected'
          websocket.onclose = (evt) ->
            show 'Closed'
          websocket.onerror = (evt) ->
            show 'Error: ' + evt.data
          websocket.onmessage = (evt) ->
            #show evt.data
            addElement buffer, num++, evt.data
            pt = JSON.parse evt.data
            if pt.color? then color = pt.color
            circle ctx, x+100*pt.x, y+100*pt.y

        window.onload = ->
          canvas = document.getElementById 'drawCanvas'
          context = canvas.getContext '2d'
          buffer = document.getElementById 'message'
          socketClient buffer, context, 300, 200

        window.sendMessage = ->
          msg = document.getElementById('entryfield').value
          websocket.send msg

    body ->
      header -> h1 'Seed of Life'
      input id:'entryfield', value:'rgba(40,200,25,0.7)'
      button type: 'button', onclick: 'sendMessage()'
        'Change Color'
      br
      canvas id: 'drawCanvas', width: 600, height: 400
      div id: 'message'

# Server-side WebSocket server
ws = require './prelude/ws'
cp = require './10-Circular'
wsHandler = (websocket) ->
  websocket.on 'connect', (resource) ->
    show 'connect: ' + resource
    # close connection after 10s
    setTimeout websocket.end, 10 * 1000

  websocket.on 'data', (data) ->
    show data # process data
    blue = 'rgba(40,20,255,0.7)'
    websocket.write JSON.stringify
      color: if data is '' then blue else data

  websocket.on 'close', ->
    show 'closing'
    process.exit 0 # Exit server completely

  circ = new cp.CircularPosition 0.01
  annoy = setInterval (->
    websocket.write JSON.stringify circ.nextPoint()), 20

wsServer = ws.createServer wsHandler
wsServer.listen 8080

# Launch test server and client UI
require './prelude'
viewServer webpage
