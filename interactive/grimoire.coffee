

{CoffeeScript} = require 'coffee-script'
_ = require 'underscore'
CoffeeKup = require 'coffeekup'


show = console.log
showDocument = (doc, width, height) -> show doc

webfragment = ->
  div id: "feature-detect", ->
    div id: "feature-javascript", style: "color:#FF0000; display: block", ->
      text "No JavaScript &rarr; no output and no interactivity."
    div id: "feature-mathml", style: "color:#FF0000; display: none", ->
      text "No MathML 1998 &rarr; math is not readable."
    div id: "feature-canvas", style: "color:#FF0000; display: none", ->
      text "No Canvas &rarr; graphical output is not rendered."
    div id: "feature-contenteditable", style: "color:#FF0000; display: none", ->
      text "No ContentEditable &rarr; CoffeeScript sections can not be changed."
  input class: 'field', type: 'button', value: 'Adjust layout', onclick: ->
    @value = if toggleLayout() then 'Layout: fixed' else 'Layout: freeflow'
  input class: 'field', type: 'button', value: 'Select editor', onclick: ->
    @value = if switchEditor() then 'Editor: CodeMirror' else 'Editor: plain text'
  input class: 'field', type: 'button', value: 'Evaluation', onclick: ->
    @value = if switchEvaluation() then '↑ ↩  Evaluate' else 'Auto Evaluate'
  script src: 'node_modules/coffee-script.js'
  script src: 'node_modules/coffeekup.js'
  script src: 'node_modules/underscore.js'
  script src: 'node_modules/qc.js'
  script src: 'codemirror/codemirror.js'
  script src: 'codemirror/coffeescript.js'
  coffeescript ->
    @reveal = (instance) -> # Very pandoc specific: requires --section-divs
      instance.getElementsByTagName('section')[0]?.style.display = 'block'
      instance.getElementsByTagName('h5')[0]?.innerHTML = 'Solution'
      instance.onclick = undefined
    @switchEditor = ->
      localStorage?.editor = if @useCodeMirror then 'TextArea' else 'CodeMirror'
      @useCodeMirror = not @useCodeMirror
    @switchEvaluation = ->
      localStorage?.evaluation =
        if localStorage?.evaluation is 'manual'
          'automatic'
        else
          'manual'
      localStorage?.evaluation is 'manual'
    @toggleLayout = ->
      fixedLayout = document.getElementById('page').style.maxWidth is ''
      localStorage?.fixedLayout = fixedLayout
      switchLayout fixedLayout
    switchLayout = (fixedLayout) -> # Should be in CSS
      document.getElementById('page').style.maxWidth =
        if fixedLayout then '600px' else ''
      s = document.getElementById('page').style
      if fixedLayout
        s.webkitHyphens = 'auto'
        s.mozHyphens = 'auto'
        s.msHyphens = 'auto'
        s.hyphens = 'auto'
        s.textAlign = 'justify'
      else
        s.webkitHyphens = ''
        s.mozHyphens = ''
        s.msHyphens = ''
        s.hyphens = ''
        s.textAlign = ''
      fixedLayout
    featureDetect = ->
      adjustCoverPosition = (idFeature) -> # Should be in CSS
        canvasCover = document.getElementById('drawCanvas')
        topPos = parseInt canvasCover?.style.top
        lineHeight = document.getElementById(idFeature)?.scrollHeight
        canvasCover?.style.top = (topPos + lineHeight) + 'px'

      mathmlDetect = ->
        (e = document.createElement 'div').innerHTML = '<math></math>'
        passed = e.firstChild and 'namespaceURI' of e.firstChild and
          e.firstChild.namespaceURI is 'http://www.w3.org/1998/Math/MathML'
        # TODO Needs a better test. Testing on Chrome directly because
        # it reports it supports MathML even though that is not the case.
        passed and not /Chrome/.test navigator.userAgent

      document.getElementById('feature-javascript')?.style.display = "none"
      used = (document.getElementsByTagName('math')?.length > 0)
      if used and mathmlDetect() is false
        document.getElementById('feature-mathml')?.style.display = "block"
        adjustCoverPosition 'feature-mathml'
      unless document.createElement('canvas').getContext?
        document.getElementById('feature-canvas')?.style.display = "block"
        adjustCoverPosition 'feature-canvas'
      unless 'isContentEditable' of document.documentElement
        document.getElementById('feature-contenteditable')?.style.display = "block"
        adjustCoverPosition 'feature-contenteditable'
    window.onload = ->
      featureDetect()
      switchLayout(on) if localStorage?.fixedLayout isnt 'false'
      @useCodeMirror = localStorage?.editor is 'CodeMirror'
      canvas = document.getElementById('drawCanvas')
      window.ctx = canvas.getContext '2d' if canvas?

      clearCanvas = ->
        if window.ctx?
          window.ctx.clearRect 0, 0,
            window.ctx.canvas.width, window.ctx.canvas.height
      drawCanvas = (draw) ->
        clearCanvas()
        draw window.ctx
      getParent = (child) -> child?.parentElement ? child?.parentNode

      addElement = (parent, text) ->
        newelem = document.createElement 'code'
        newelem.setAttribute 'class', 'sourceCode output'
        newelem.innerHTML = text
        parent.appendChild newelem

      separator = (parent) ->
        if parent.getElementsByClassName('output').length is 0
          addElement parent, '<hr><br>'

      addFrame = (parent, width, height, content) ->
        newelem = document.createElement 'iframe'
        newelem.setAttribute 'class', 'output'
        newelem.setAttribute 'width',  width
        newelem.setAttribute 'height', height
        newelem.setAttribute 'src',
          "data:text/html;charset=utf-8,#{encodeURIComponent content}"
        newelem.innerHTML = 
          '''<div id="feature-dataurl" style="color:#FF0000; display: block">
             No or insufficient Data URL support &rarr;
             web page output is not rendered in this browser.</div>'''
        parent.appendChild newelem

      showHere = (atTag, obj, shallow = false, symbol = '&rarr;') ->
        displayShallow = (o) ->
          """{#{"\n  #{k}: #{v}" for own k,v of o}\n}"""
        msg = switch typeof obj
          when 'undefined', 'string', 'function'
            obj
          when 'object'
            if shallow
              displayShallow obj
            else
              try
                JSON.stringify obj
              catch err
                displayShallow obj
          else obj?.toString()
        parentTag = getParent atTag
        separator parentTag
        addElement parentTag, "#{symbol} #{msg}<br>"
        obj

      showDocumentHere = (atTag, content, width = 300, height = 300) ->
        parentTag = getParent atTag
        separator parentTag
        addFrame parentTag, width, height, content
        return
      evaluateSource = (field = null) ->
        show = (obj, shallow = false, symbol = '&rarr;') ->
          showHere currentTag, obj, shallow, symbol
          return # Suppress display of the return value
        view = (obj, shallow = false, symbol = '&rarr;') ->
          showHere currentTag, obj, shallow, symbol
        showDocument = (content, width = 300, height = 300) ->
          showDocumentHere currentTag, content, width, height
        addErrorElement = (text) ->
          show """<span class="er">#{text}</span>"""
        # Naming convention: 'button-' <type> '-' <codeTagId>
        getCurrentTagId = (id) -> id.match(/button-\w+-(.*)/)[1]

        runOnDemand = (func) ->
          show "<button id='button-run-#{currentTag.id}'> Run </button>"
          document.getElementById("button-run-#{currentTag.id}").onclick = ->
            currentTag = document.getElementById getCurrentTagId @id
            view = show = (obj, shallow = false, symbol = '&rArr;') ->
              showHere currentTag, obj, shallow, symbol
            showDocument = (content, width = 300, height = 300) ->
              showDocumentHere currentTag, content, width, height
            func()
          return

        confirm = (message, func) ->
          show "#{message}" +
            "  <button id='button-yes-#{currentTag.id}'> Yes </button>" +
            "  <button id='button-no-#{currentTag.id}'> No </button>"
          document.getElementById("button-yes-#{currentTag.id}").onclick = ->
            currentTag = document.getElementById getCurrentTagId @id
            view = show = (obj, shallow = false, symbol = '&rArr;') ->
              showHere currentTag, obj, shallow, symbol
            showDocument = (content, width = 300, height = 300) ->
              showDocumentHere currentTag, content, width, height
            func true
          document.getElementById("button-no-#{currentTag.id}").onclick = ->
            currentTag = document.getElementById getCurrentTagId @id
            view = show = (obj, shallow = false, symbol = '&rArr;') ->
              showHere currentTag, obj, shallow, symbol
            showDocument = (content, width = 300, height = 300) ->
              showDocumentHere currentTag, content, width, height
            func false
          return

        prompt = (message, defaultValue, func) ->
          show "#{message}" +
            "  <input id='input-prompt-#{currentTag.id}' value='#{defaultValue}' />" +
            "  <button id='button-prompt-#{currentTag.id}'> Go </button>"
          document.getElementById("button-prompt-#{currentTag.id}").onclick = ->
            currentTag = document.getElementById getCurrentTagId @id
            view = show = (obj, shallow = false, symbol = '&rArr;') ->
              showHere currentTag, obj, shallow, symbol
            showDocument = (content, width = 300, height = 300) ->
              showDocumentHere currentTag, content, width, height
            func document.getElementById("input-prompt-#{getCurrentTagId @id}").value
          return
        # HTML colored output for QuickCheck.
        class HtmlListener extends ConsoleListener
          constructor: (@maxCollected = 10) ->
          log: (str) -> show str
          passed: (str) -> # print message as OK
            show """<span class="kw">#{str}</span>"""
          invalid: (str) -> # print message as warning
            show """<span class="dt">#{str}</span>"""
          failure: (str) -> # print message as error
            show """<span class="al">#{str}</span>"""
          done: ->
            show 'Completed test.'
            resetProps() # Chain here if needed

        # Enhanced noteArg returning its argument so it can be used inline.
        Case::note = (a) -> @noteArg a; a
        # Same as Case::note but also logs the noted args.
        Case::noteVerbose = (a) -> @noteArg a; show @args; a

        # Helper to declare a named test property for
        # a function func taking types as arguments.
        # Property is passed the testcase, the arguments
        # and the result of calling func, it must return
        # a boolean indicating success or failure.
        testPure = (func, types, name, property) ->
          declare name, types, (c, a...) ->
            c.assert property c, a..., c.note func a...
          return

        # Default qc configuration with 100 pass and 1000 invalid tests
        qcConfig = new Config 100, 1000

        # Test all known properties
        test = (msg, func) ->
          _.each [msg, func, runAllProps qcConfig, new HtmlListener],
            (o) -> unless _.isUndefined o then show o
        getCode = (codeTag) ->
          if codeTag.value?
            segment = codeTag.value
          else
            segment = codeTag.innerHTML
          #console.debug "From: #{segment}"
          code = segment.replace /<br>/g, '\n'
          code = code.replace /<[\/]?span[^>]*>/g, ''
          code = code.replace /[&]gt;/g, '>'
          code = code.replace /[&]lt;/g, '<'
          code = code.replace /[&]nbsp;/g, ' '
          #console.debug "To: #{code}"
          codeTag:codeTag, code:code

        if field? and @incrementalEvaluation
          segments = [getCode field]
        else
          # Obtain each code segment with an ownership tag
          segments =
            for codeSegment in window.document.getElementsByTagName 'pre'
              if codeSegment.className is 'sourceCode'
                codeTag = codeSegment.firstChild
                if codeTag.className is 'sourceCode coffeescript' \
                    or codeTag.className is 'sourceCode CoffeeScript'
                  getCode codeTag
          segments = (segment for segment in segments when segment?)
          for segment, i in segments
            if i > 0 and /^[\s]/.test segment.code
              segment.code = segments[i-1].code + '\n' + segment.code
              segments[i-1] = undefined
          segments = (segment for segment in segments when segment?)
        for segment in segments
          outList = getParent(segment.codeTag).getElementsByClassName 'output'
          outLength = outList?.length
          while outList and outLength > 0
            elem = outList[--outLength]
            getParent(elem).removeChild elem
        # Evaluate code segments
        incredibleLength = segments.length
        for incredibleIndex in [0...incredibleLength] by 1
          incredibleStart = new Date()
          currentSegment = segments[incredibleIndex]
          currentTag = currentSegment.codeTag
          if currentTag.id is ''
            currentTag.id = "codeTag#{incredibleIndex}"
          do (currentTag) ->
            try
              draw = undefined
              incredibleResult = eval CoffeeScript.compile \
                currentSegment.code, bare:on
              drawCanvas draw if draw?
              if incredibleResult isnt undefined and
                 typeof incredibleResult isnt 'function'
                show incredibleResult, on, '&crarr;'
              if globalNames?
                promoteToGlobal = (magic) ->
                  try
                    magicValue = eval magic
                  catch error
                    return # doesn't exist
                  this[magic] = magicValue
                for magic in globalNames.split ' '
                  promoteToGlobal magic
            catch error
              console.log error.message
              addErrorElement error
            return
          if showTiming? and showTiming is on
            incredibleTime = Number(0.001 *
              (new Date() - incredibleStart)).toFixed 3
            show "#{incredibleTime}s", on, '☕'
        return
      # Textarea editor code evaluation
      keyDownEvaluation = (evt) ->
        return unless evt?
        if localStorage?.evaluation is 'manual'
          if evt.keyCode is 13 and evt.shiftKey # ↑ Shift / ↩ Enter
            evt.preventDefault()
            evaluateSource evt.currentTarget
        if evt.keyCode is 13 and not evt.shiftKey
          evt.target?.rows++
        return
      keyUpEvaluation = (evt) ->
        return unless evt?
        unless localStorage?.evaluation is 'manual'
          evaluateSource evt.currentTarget unless evt.keyCode in
            [16,37,38,39,40] # Ignore shift and arrow keys

      # CodeMirror editor code evaluation
      cmEvaluation = (editor) ->
        editor.save()
        evaluateSource editor.getTextArea()
      cmAutoEvaluation = (editor) ->
        unless localStorage?.evaluation is 'manual'
          cmEvaluation editor
      cmManualEvaluation = (editor) ->
        if localStorage?.evaluation is 'manual'
          cmEvaluation editor
      createEditor = (codeElement, text) ->
        newelem = document.createElement 'textarea'
        newelem.setAttribute 'id', codeElement.id
        newelem.setAttribute 'class', codeElement.getAttribute('class')
        countLines = (c for c in text when c is '\n').length + 1
        newelem.setAttribute 'rows', countLines
        newelem.setAttribute 'style', 'width: 98%;'
        newelem.setAttribute 'autofocus', 'true'
        newelem.setAttribute 'spellcheck', 'false'
        newelem.innerHTML = text
        newelem.addEventListener 'keydown', keyDownEvaluation, false
        newelem.addEventListener 'keyup', keyUpEvaluation, false
        getParent(codeElement).replaceChild newelem, codeElement
        if @useCodeMirror
          elemCodeMirror = CodeMirror.fromTextArea newelem,
            onChange: cmAutoEvaluation
            extraKeys: {'Shift-Enter': cmManualEvaluation}
            lineNumbers: true
            theme: 'pantheme'
      activateEditor = ->
        @removeEventListener 'focus', activateEditor, false
        sourcecode = @innerHTML.toString().replace /<\/?span[^>]*>/g, ''
        sourcecode = sourcecode.replace /<br[ ]*[^>]*>/g, '\n'
        createEditor this, sourcecode

      # Activate text editor when code gets focus
      for segment in document.getElementsByTagName 'pre'
        segment.firstChild.addEventListener 'focus', activateEditor, false
      @incrementalEvaluation = off
      evaluateSource()

kup = if exports? then require 'coffeekup' else window.CoffeeKup

display = if exports?
  console.log
else
  (html) -> show _.escape html

display kup.render webfragment, format:on

