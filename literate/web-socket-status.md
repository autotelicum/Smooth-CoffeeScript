
## Web Socket Status

The Web Socket support in browsers is experimental and based on a changing draft standard. For a production application, have a look at [Socket.io support](http://socket.io/#browser-support) and [documentation](http://socket.io/#how-to-use).


## Mac OS X 10.6.8

* Safari 5.1.1
    - No Issues.


## Windows 7 (no service pack)

* Safari 5.1.1
    - No Issues. Use this browser if your normal browser fails. You do not have to set it as your default browser. If it is installed in the default location then the browser launcher in the prelude will start it.

* Opera 11.52
    - No issues. But web sockets have to be enabled manually according to the instructions in the prelude.

* Chrome 15.0.874.121 m
    - Fail. Does not launch its user interface when started as a child process from node.

* Firefox 4
    - No issues, if enabled, also works on Windows XP.

* Firefox 8.0.1
    - Fail. Has switched to a mozilla specific MozWebSocket on the client side. Mozilla's back and forth on this is described [here](https://developer.mozilla.org/en/WebSockets). The change breaks applications, that worked in their version 4 browser. Changing the client code to MozWebSocket will obviously not work in other browsers, so I am *not* changing the draft standard compliant code. Besides the server implementation does not implement protocol 10.

* Internet Explorer
    - Fail. Does not implement web sockets in version 9 and below. Version 10 is untested because it currently requires Windows 8.


## Test Web Socket

Open a command line terminal, change directory to `Smooth-CoffeeScript/src` and run:

    coffee 10-TestWebSockets.coffee

Verify that your web browser started and you can see: `RESPONSE: Cowabunga!`

If not then open the file `prelude/prelude.coffee` and see the section `User settings`.

To stop a web server or other script that does not stop by itself press: `Ctrl-C`.


-----------------------------------------------------------------------------

Formats	[Markdown](web-socket-status.md)	[PDF](web-socket-status.pdf)	[HTML](web-socket-status.html)
Copyright autotelicum © 2554/2011 ![License CCBYNCSA](ccbyncsa.png)


<!-- Commands used to format this document:

Edit ,>markdown2pdf --listings --xetex '--template=pandoc-template.tex' -o web-socket-status.pdf; open web-socket-status.pdf

Edit ,>pandoc -f markdown -t html -S --css pandoc-template.css --template pandoc-template.html -B readability-embed.js -o web-socket-status.html; open web-socket-status.html
-->
