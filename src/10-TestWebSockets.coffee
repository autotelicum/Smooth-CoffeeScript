require './prelude'

webpage = kup.render -> 
  doctype 5
  html ->
    head ->
      meta charset: 'utf-8'
      title 'WebSocket Test'
      style '''
        body {font-family: sans-serif}
        header, nav, section, footer {display: block}
      '''
      coffeescript ->
        #wsUri = 'ws://echo.websocket.org/'
        wsUri = 'ws://localhost:8080/'
        output = null
        init = ->
          output = document.getElementById 'output'
          testWebSocket()

        testWebSocket = ->
          websocket = new WebSocket wsUri
          websocket.onopen    = (evt) -> onOpen evt
          websocket.onclose   = (evt) -> onClose evt
          websocket.onmessage = (evt) -> onMessage evt
          websocket.onerror   = (evt) -> onError evt

          onOpen = (evt) ->
            writeToScreen "CONNECTED"
            doSend "WebSocket works!"

          onClose = (evt) ->
            writeToScreen "DISCONNECTED"

          onMessage = (evt) ->
            writeToScreen '<span style="color: blue;">RESPONSE: ' + evt.data + '</span>'
            websocket.close()

          onError = (evt) ->
            writeToScreen '<span style="color: red;">ERROR:</span> ' + evt.data

          doSend = (message) ->
            writeToScreen "SENT: " + message
            websocket.send message

        writeToScreen = (message) ->
          pre = document.createElement "p"
          pre.style.wordWrap = "break-word"
          pre.innerHTML = message
          output.appendChild pre

        window.addEventListener "load", init, false

    body ->
      header -> h2 'WebSocket Test'
      div id: 'output'


wsHandler = (websocket) ->
  websocket.on 'connect', (resource) ->
    show 'connect: ' + resource
    # close connection after 10s
    setTimeout websocket.end, 10 * 1000 
  websocket.on 'data', (data) ->
    show data # process data
    websocket.write 'Cowabunga!' # respond
  websocket.on 'close', ->
    show 'closing'
    # Exit server completely
    process.exit 0
wsServer = ws.createServer wsHandler
wsServer.listen 8080


http = require 'http'
server = http.createServer (req, res) ->
  show "#{req.client.remoteAddress} #{req.method} #{req.url}"
  res.writeHead 200, 'Content-Type': 'text/html'
  res.write webpage
  res.end()
server.listen 8000
show 'Server running at'
show  server.address()

viewURL getServerURL server


