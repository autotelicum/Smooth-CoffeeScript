
# Usage: require './prelude' or on commandline: coffee -r ./prelude

# This prelude is a learning environment for 'Smooth CoffeeScript'.
prelude = {}


# User settings
#---------------

# By default the prelude uses the global namespace to make access
# to its functions and underscore easy.
#
# Set useGlobal to `no` to get only prelude defined in your namespace.
#
# Setting useGlobal to `no` will make all samples fail, since all
# calls to the prelude functions must be qualified with prelude.
#
# Setting it to `no` can be used for your own development
# where it can help avoid name-clashes with other libraries.
# You can also freely copy parts of it into your own projects.
useGlobal = yes

# Set to `no` to get monochrome output
useColors = yes

# On Windows add your browser here if it is not listed.
# Edit path to Google Chrome if that is your browser.
# See below to enable WebSockets in Firefox or Opera.
windowsBrowsers = [
  "C:\\Users\\USERNAME\\AppData\\Local\\Google\\Chrome\\Application\\chrome.exe"
  "C:\\Program Files\\Safari\\Safari.exe"
  "C:\\Program Files\\Mozilla Firefox\\firefox.exe"
  "C:\\Program Files\\Opera\\opera.exe"
  #"C:\\Program Files\\Internet Explorer\\iexplore.exe" # IE9 known not to work
]

# *Enabling WebSockets in Firefox 4.*
#
# 1. Type about:config in address bar and continue
#    by clicking "I'll be careful, I promise"
#
# 2. Set network.websocket.enabled value to true and
#    set network.websocket.override-security-block
#    preferences to true.
#
# 3. Restart Firefox browser.

# *Enabling WebSockets in Opera 11.*
#
# 1. Open Opera browser, type or paste
#    opera:config#Enable%20WebSockets
#    in the address bar and press enter.
#
# 2. Select or tick mark against
#    "Enable WebSockets" under User Prefs.


# File helpers
#--------------

# Test if a file exists
prelude.fileExists = (filename) ->
  try
    (require 'fs').statSync(filename).isFile()
  catch error
    return false

# Return contents of filename as UTF-8 text
prelude.readTextFile = (filename) ->
  require('fs').readFileSync filename, 'utf8'

# Return contents of filename as binary buffer
prelude.readBinaryFile = (filename) ->
  require('fs').readFileSync filename


# Internal helper
#-----------------

# Translate a server object to a usable URL
prelude.getServerURL = (server) ->
  address = server.address().address
  if address == '0.0.0.0' # Windows does not like 0.0.0.0
    address = '127.0.0.1'
  "http://#{address}:#{server.address().port}/"


# Web browser and server functions
#----------------------------------

# Open a web browser pointing to URL or a filename
prelude.viewURL = (url) ->
  switch (require 'os').type()
    when 'Darwin'
      require('child_process').exec 'open ' + url
      return
    when 'Windows', 'CYGWIN_NT-6.1'
      for browser in windowsBrowsers
        if prelude.fileExists browser
          show "Browser: #{browser} URL: #{url}"
          require('child_process').execFile browser, [url]
          show "Process launced: #{browser} #{url}"
          return
    when 'Linux'
      ; # Is there a simple way to do it?
  show 'Open a web browser at: ' + url
  return

# View server instances
prelude.server = []
prelude.portNumber = 3456

# Start a server to view content
# (a file or HTML) in a browser
prelude.viewServer = (content) ->
  webpage =
    if prelude.fileExists content
      prelude.readTextFile content
    else
      content
  # Store each server with an increasing portnumber
  prelude.server.push(
    (require 'http').createServer (req, res) ->
      show "#{req.client.remoteAddress} #{req.method} #{req.url}"
      if req.method is 'GET'
        if req.url is '/'
          res.writeHead 200, 'Content-Type': 'text/html'
          res.write webpage
          res.end()
          return
        else if prelude.fileExists "..#{req.url.toString()}"
          if req.url[1..3] is 'img'
            res.writeHead 200, 'Content-Type': 'image/jpeg'
            res.write prelude.readBinaryFile "..#{req.url}"
            res.end()
          return
      res.writeHead 404, 'Content-Type': 'text/html'
      res.write '404 Not found'
      res.end()
  )
  lastServer = prelude.server.length-1
  prelude.server[lastServer].listen prelude.portNumber++
  viewURL prelude.getServerURL prelude.server[lastServer]

# Stop a running view server
prelude.stopServer = ->
  if (lastServer = prelude.server.length-1) >= 0
    prelude.server[lastServer].close()
    prelude.server.length -= 1


# Interactive utilities
#-----------------------

# Display a data object to a given depth and optionally in colors 
util = require 'util'
prelude.show = (obj, depth = 2, showHidden = false, colors = useColors) ->
  switch typeof obj
    when 'string' then util.print obj, '\n'
    when 'function' then util.puts obj.toString()
    else util.puts util.inspect obj, showHidden, depth, colors
  return obj

# Ask a yes/no question - does not mix with the REPL
prelude.confirm = (message, resultFunction) ->
  process.stdin.resume()
  process.stdin.setEncoding 'utf8'
  show message + ' (Y/n)'
  process.stdin.once 'data', (answer) ->
    process.stdin.pause()
    resultFunction answer in ['\n','y\n','Y\n','y','Y']
  undefined

# Ask a question with a string answer - does not mix with the REPL
prelude.prompt = (message, defaultAnswer, resultFunction) ->
  process.stdin.resume()
  process.stdin.setEncoding 'utf8'
  show message + ' ' + defaultAnswer
  process.stdin.once 'data', (answer) ->
    process.stdin.pause()
    resultFunction if answer is '\n' then defaultAnswer else answer.trimRight()
  undefined

# Import functions into the global namespace with globalize,
# so that they do not need to be qualified each time.
prelude.globalize = (ns, target = global) ->
  target[name] = ns[name] for name of ns


# External libraries
#--------------------

# Install underscore into `_` in the prelude
prelude._ = require './underscore'
# The REPL uses `_` for the last result so create
# a synonym for `_` to help resolve conflicts.
prelude.underscore = prelude._

# Install coffeekup in the kup namespace
prelude.kup = require './coffeekup'

# Install websocket in the ws namespace
prelude.ws = require './ws'

# Install quickcheck in the qc namespace
prelude.qc = require './qc'


# Additional test utilities
#---------------------------

# Node colored output for QuickCheck.
class NodeListener extends prelude.qc.ConsoleListener
  constructor: (@maxCollected = 10) ->
  log: (str) -> show str
  passed: (str) -> # print message in green
    console.log if useColors then "\033[32m#{str}\033[0m" else str
  invalid: (str) -> # print message in yellow
    console.warn if useColors then "\033[33m#{str}\033[0m" else str
  failure: (str) -> # print message in red
    console.error if useColors then "\033[31m#{str}\033[0m" else str
  done: ->
    show 'Completed test.'
    prelude.qc.resetProps() # Chain here if needed

# Enhanced noteArg returning its argument
# so it can be used inline.
prelude.qc.Case::note = (a) -> @noteArg a; a
# Same as Case::note but also logs the noted args.
prelude.qc.Case::noteVerbose = (a) -> @noteArg a; show @args; a

# Helper to declare a named test property for
# a function func taking types as arguments.
# Property is passed the testcase, the arguments
# and the result of calling func, it must return
# a boolean indicating success or failure.
prelude.qc.testPure = (func, types, name, property) ->
  prelude.qc.declare name, types, (c, a...) ->
    c.assert property c, a..., c.note func a...

# Default qc configuration with 100 pass and 1000 invalid tests
prelude.qcConfig = new prelude.qc.Config 100, 1000

# Test all known properties
prelude.qc.test = (msg, func) ->
  _.each [msg, func, prelude.qc.runAllProps prelude.qcConfig, new NodeListener],
    (o) -> unless _.isUndefined o then show o


# Shortcut to prelude definitions
#---------------------------------

# See comment at definition of useGlobal
namespace = global
if useGlobal
  prelude.globalize prelude, namespace
  # Uncomment this to get underscore functions in global
  # prelude.globalize prelude.underscore, namespace
else
  namespace.prelude = prelude

# In the REPL you can show definitions in the global namespace with: TAB.
exports.prelude = prelude
