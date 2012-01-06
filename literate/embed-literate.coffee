###
Edit ,>coffee -s >embed-literate.html; plumb embed-literate.html
###

kup = require 'coffeekup'

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
  input class: 'field', type: 'button', value: 'Switch editor', onclick: ->
    @value = if switchEditor() then 'Editor: CodeMirror' else 'Editor: plain text'

  script src: 'node_modules/coffee-script.js'
  script src: 'node_modules/coffeekup.js'
  script src: 'node_modules/underscore.js'
  script src: 'node_modules/qc.js'
  script src: 'codemirror/codemirror.js'
  script src: 'codemirror/coffeescript.js'
  link rel: 'stylesheet', href: 'codemirror/codemirror.css'
  link rel: 'stylesheet', href: 'codemirror/pantheme.css'

  coffeescript ->
    @reveal = (parent) ->
      parent.getElementsByTagName('code')[0].style.display = 'block'
    @switchEditor = ->
      localStorage?.editor = if @useCodeMirror then 'TextArea' else 'CodeMirror'
      @useCodeMirror = not @useCodeMirror
    @toggleLayout = ->
      fixedLayout = document.getElementById('page').style.maxWidth is ''
      localStorage?.fixedLayout = fixedLayout
      switchLayout fixedLayout
    switchLayout = (fixedLayout) ->
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
      unless document.createElement('canvas').getContext?
        document.getElementById('feature-canvas')?.style.display = "block"
      unless 'isContentEditable' of document.documentElement
        document.getElementById('feature-contenteditable')?.style.display = "block"

    window.onload = ->
      featureDetect()
      switchLayout(on) if localStorage?.fixedLayout isnt 'false'
      @useCodeMirror = localStorage?.editor is 'CodeMirror'

      canvas = document.getElementById('drawCanvas')
      window.ctx = canvas.getContext '2d' if canvas?

      getParent = (child) -> child?.parentElement ? child?.parentNode

      evaluateSource = ->
        # Clear output
        if window.ctx?
          window.ctx.clearRect 0, 0,
            window.ctx.canvas.width, window.ctx.canvas.height

        elem = window.document.getElementsByClassName('output')[0]
        while elem?
          getParent(elem).removeChild elem
          elem = window.document.getElementsByClassName('output')[0]

        # Create support functions
        addElement = (parent, text) ->
          newelem = document.createElement 'code'
          newelem.setAttribute 'class', 'sourceCode output'
          newelem.innerHTML = text
          parent.appendChild newelem
        separator = (parent) ->
          if parent.getElementsByClassName('output').length is 0
            addElement parent, '<hr><br>'
        addErrorElement = (text) ->
          parentTag = getParent codeTag
          separator parentTag
          addElement parentTag,
            """<span class="er">#{text}</span>"""
        show = (msg) ->
          parentTag = getParent codeTag
          separator parentTag
          addElement parentTag, "&rarr; #{msg}<br>"
          msg
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
        showDocument = (content, width = 300, height = 300) ->
          parentTag = getParent codeTag
          separator parentTag
          addFrame parentTag, width, height, content

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
        
        # Default qc configuration with 100 pass and 1000 invalid tests
        qcConfig = new Config 100, 1000
        
        # Test all known properties
        test = (msg, func) ->
          _.each [msg, func, runAllProps qcConfig, new HtmlListener],
            (o) -> unless _.isUndefined o then show o

        # Obtain each code segment with an ownership tag
        segments =
          for codeSegment in document.getElementsByTagName 'pre'
            if codeSegment.className is 'sourceCode'
              codeTag = codeSegment.getElementsByTagName('code')[0]
              if codeTag is null or codeTag is undefined 
                codeTag = codeSegment.getElementsByTagName('textarea')[0]
              if codeTag.className is 'sourceCode coffeescript' \
                  or codeTag.className is 'sourceCode CoffeeScript'
                if codeTag.value?
                  segment = codeTag.value
                else
                  segment = codeTag.innerHTML
                #console.debug "From: #{segment}"
                code = segment.replace /<br>/g, '\n'
                code = code.replace /<[^>]*>/g, ''
                code = code.replace /[&]gt;/g, '>'
                code = code.replace /[&]lt;/g, '<'
                code = code.replace /[&]nbsp;/g, ' '
                #console.debug "To: #{code}"
                codeTag:codeTag, code:code

        # Stitch together continuing code segments
        segments = (segment for segment in segments when segment?)
        for segment, i in segments
          if i > 0 and /^[\s]/.test segment.code
            segment.code = segments[i-1].code + '\n' + segment.code
            segments[i-1] = undefined
        segments = (segment for segment in segments when segment?)

        # Evaluate code segments
        for incredibleindex in [0...segments.length]
          segment = segments[incredibleindex]
          codeTag = segment.codeTag
          try
            draw = undefined
            eval CoffeeScript.compile segment.code, bare:on
            draw window.ctx if draw?
          catch error
            addErrorElement error
            return
        return

      # Text editor with live code evaluation
      keyEvaluation = (evt) ->
        evt?.target?.rows++ if evt?.keyCode is 13 # Enter
        evaluateSource() unless evt?.keyCode in
          [16,37,38,39,40] # Ignore shift and arrow keys
        return

      cmEvaluation = (editor, {from, to, newText, next}) ->
        editor.save()
        evaluateSource()

      createEditor = (codeElement, text) ->
        newelem = document.createElement 'textarea'
        newelem.setAttribute 'class', 'sourceCode coffeescript'
        countLines = (c for c in text when c is '\n').length + 1
        newelem.setAttribute 'style', 'width: 98%;'
        newelem.setAttribute 'rows', countLines
        newelem.setAttribute 'autofocus', 'true'
        newelem.setAttribute 'spellcheck', 'false'
        newelem.innerHTML = text
        newelem.addEventListener 'keyup', keyEvaluation, false
        getParent(codeElement).replaceChild newelem, codeElement
        if @useCodeMirror
          elemCodeMirror = CodeMirror.fromTextArea newelem,
            onChange: cmEvaluation
            lineNumbers: true
            theme: 'pantheme'

      activateEditor = ->
        @removeEventListener 'focus', activateEditor, false
        sourcecode = @innerHTML.toString().replace /<\/?span[^>]*>/g, ''
        sourcecode = sourcecode.replace /<br[ ]*[^>]*>/g, '\n'
        createEditor this, sourcecode

      # Activate text editor when code gets focus
      for segment in document.getElementsByTagName 'pre'
        segment.getElementsByTagName('code')[0]
          .addEventListener 'focus', activateEditor, false

      evaluateSource()

    # To obtain a base64 encoding of a file run the CoffeeScript compiler like this:
    # coffee -e "console.log require('fs').readFileSync('../img/ostrich.jpg').toString 'base64'"
    window.ostrich = 'data:image/png;base64,/9j/4AAQSkZJRgABAgAAZABkAAD/7AARRHVja3kAAQAEAAAAHgAA/+4ADkFkb2JlAGTAAAAAAf/bAIQAEAsLCwwLEAwMEBcPDQ8XGxQQEBQbHxcXFxcXHx4XGhoaGhceHiMlJyUjHi8vMzMvL0BAQEBAQEBAQEBAQEBAQAERDw8RExEVEhIVFBEUERQaFBYWFBomGhocGhomMCMeHh4eIzArLicnJy4rNTUwMDU1QEA/QEBAQEBAQEBAQEBA/8AAEQgAWgBaAwEiAAIRAQMRAf/EAIYAAAIDAQEBAAAAAAAAAAAAAAQFAgMGAAEHAQEBAQEBAAAAAAAAAAAAAAACAQMABBAAAgEDAwIDBQYFBQEAAAAAAQIDABEEITESQQVhIhNRcYGhMrFCMxQVBpHBUmJDcqIjUzQ1EQACAgICAgIDAAAAAAAAAAAAARECITFBElFhcaHBIgP/2gAMAwEAAhEDEQA/AMtBEzW3o9ICBUsWG9qPWHTavPa2TZIDENx1qxI7WvRHEA6Uwwe1evxyMg8YL6KPqe32CopZXgAQAUdBBE/l4sQw/EPQ+FNJcjs+DFI6wxsVGq738LtSXJ/c8EbGD0OOPIBqAAyk+weyr19yTt6ITxMjFG3XehJUa2hNTHdcOWVTJo4urno69D764EMGN9msviLXvRiCyATcgLXNBSEnrameQnKhGxz7KdWFoFQsrbmir+J+mq0j81qK9Mf7aU5JBZiMRqaY+cwGYWKqeJA3FKYHKi23zptjIqQmVnLBgeSrp5RsdayssjQNI3AGQgkDUr1tUcvvxkUeivkQeXXa39tC5vcV+kPzXxFiPfQQMUqtYWO5+NKtfKC34LTm5mTxlPKXgeTCwVVHhrQjRnmVD+oSwW4Gt99KIWZorBVFiOJuP6tzTjHxsJceKZQpyI+DWUEkm9yoBsSRtTbjgmxNNjH8xxhQqIyRITtyP0r8qtORLCI1IvLExDBhbS2laTgmH6QCI6yHk6cbt6h6szgdTakWefWeQqi+RmvIu21+Itp8RU3tFiCw5MT8OZCO6huOttakGjlBEZ5eIpbMuRIy2GllBB95ozFj9MlmIUMblR0otJIqZJILtfeifQ+yjsSGOYC2/W1F/p/9w2oyywjLRMVfanU2eZYjBCllIs5OpNht4ClSY8ryqsQJdiAoHtphMpjurqL3N2F9TVbIjNZ6OkpO19Bapfp2Tr6ciyzqvqPDGSzKgsSSdtL6gUz9PEfuOOJyBCWHNjsF9poPP7aqZTMJAOOu41HRgeoNaK8RJy/n2mNrieOSjHkZivIXuQCfcafYYAaOc6kCykai/wBX2mhcbtU57eJuJtIzPbrw2U2rSdiwZAkWRIto7WWMDRr7tY1Hl4DoDZMhsmR52u8YW0SnzctW8NTyoKZLEgLxBbz21BtqSTWpzO0JLOkoJGOtiygnTieVh76Q9/xUSKXJwrLEt/VjB2c25Fajq5KmZ/IzURLfe020/hQP52d2trr93f7K8m5hwQnK4AG++9GxQKncIGVfTuoZhuAaWESLPOtfY8/bjZLLcxFkPW38603n/wCofT4UsTusMYCgC/Wwq39VHyvQ7L8izoSiBgbjQjYjeo5JkWKxJa/QnX505jxhuRQvcsc+g1h40SmYmkBewTfQAmtBidjxpcaOZoNRbmisWI5amyXtb3Vm/VBkCML67bWp3h50UMKoh5MDsGPEDfVSfsrRhXJr8bGUYrLJ5kItxPQW/lV0UsarwH+Py2pR23v8bERyNzhbdGN3S/3lc/Uvv1FB9+7zldqzA2NgPNBoWnflwcW2XhsffST1AX7NQ8SzQsDpyv8AZWRkR1xpo528zlkkVRYctdSPnWsxclMvt2PloCiTIHVTuAwBsay3fHwl/c2JiJzWSfi8jg+Tz3AFvtqXrMNcHVZn82F8ObkqcogRyBNzp0vQqyvLlGeQ2JOi/wBKjYU87/DFFkMuPYq44sx+pjsSvsFIVThLY73/AIVFz5E23Clx4GXM35A1d+Yb29KGRgwtVnE/KiU2CkBaHyQGjYFb6bVR+bFSE4kNuVvGo7I6GYzumPJFO9l4A6hfCgVyJkOjWp73lY/UK3Y3OrEaUhljYagfGtaOUgWUMmmfJGwJ1tsb6i/srYftv92RMq4eawZNk5bgezxFYU71wuCCDYjY0uq+Ayz7XFlYuTF/wlSg0BW1tPdSPuGUkOohDTqvGOZtBY3vyfw3rC9v/cWfgyrIrliNGF/qH91d3HvWZ3NzyuikWKA6W9nuotN40JdV7O7h3P8AMZhkXzKiiOM9NN2+Jr3Fj5ed73NDxQAbijYmCWtpUeoRVPIZGgA2tV1h8qEjmuas9Tx6UIYgh8hlFShmEikN10ub2A9ulUP8KPX/AOZ/i3P4P4m33qOCiPNZg11tx0A1NhQWQxMY06EUc/8A5D/q+Hx8aAyfxW3361tUFtgbC1QNTPwrw/CtDM4UVjRlt/hQw26Uww/o6UWVFuwr0Iz2C163wonF3H00Bl2LgXF2or9NTxojH2G3woj+FZ/tI8H/2Q=='

console.log kup.render webfragment, format:on
