% Grimoire --- _[Smooth CoffeeScript](http://autotelicum.github.com/Smooth-CoffeeScript/)_
% 
% ☕

> This literate program is _interactive_ in its HTML~5~ form. Edit a CoffeeScript segment to try it. You can see the generated JavaScript as you modify a CoffeeScript function by typing 'show name' after its definition.


## Grimoire

A Grimoire is a book of magical incantations. This program got the name because it is full of magic. Not the superstitious kind --- but magical constants, assumptions and implicit definitions --- follow its style and conventions at your own peril. As it is with magic, this program does not actually work, it is all sleight of hand.

There is a little touch of self-referential magic in here: This literate program documents the internals of its own kind of literate program documents including itself.

If you have some CoffeeScript that would be more spiffy packaged in an interactive HTML~5~ document, then be warned: As in magical potions, the ingredients are exotic and intoxicating. They include `ssam` (streaming sam rc script) from `plan9port`, `pandoc` (the Haskell universal format converter) and the enchanted `CodeMirror` --- the embedded editor that shows your code as it _really_ is.

#### The Crystal Ball of Hindsight

One night, under the full moon, I might make this more approachable. There isn't anything going on in the `sam` structural regular expressions or the `ssam` pipeline that could not be done in, say, a CoffeeScript program. It is this way because the `plan9` toolset is eminent for prototyping and experiments and `pandoc` does most of the work. Creating these documents is a little something I am doing for fun. Building a professional quality publishing pipeline --- while interesting --- would be an order of magnitude more work. This is not like any commercial application I have ever seen or written.

The program attempts to change as little as possible in the `markdown` format, but meddles --- quite unwisely --- in the internals of the HTML~5~ created by `pandoc`. This is to create one document that is simultaneously a `markdown` document, a literate CoffeeScript program, and an interactive HTML~5~ application.


### Editor Commandline Commands

I use `acme` to stir the ingredients, but you can use any editor/command line you like --- don't blame me for the result. Speaking of don't blame me: If this program does not work for you, then it is not a bug, it is because you don't believe in magic --- because _seriously_ you don't, do you?

Below are the commands I use to extract CoffeeScript code, execute it and to format these Grimoire documents. To execute the commands; middle-button select them in the `acme` environment (if you are reading the markdown source code). As you can see, the magical constants start right here. To use the commands with another document, snarf them and `s/grimoire/new-document-name/g`.

##### Simple Extraction

This command extracts CoffeeScript to an editor buffer --- only bird tracks followed by the capitalization that you see below are extracted. This is used to avoid extracting code blocks that are spelled in all capitals i.e `~~~~ {.COFFEESCRIPT}`. In the online environment those blocks become read-only and are not executed.

~~~~ {.bash}
Edit ,x/^~~+[   ]*{\.[cC]offee[sS]cript.*}$/+,/^~~+$/-p
~~~~

##### Extract and Run Standalone

The next command extracts the CoffeeScript and prepend definitions that are provided by the interactive environment but do not exist in the standard standalone environment. Creates a CoffeeScript file. Compiles to a JavaScript file. Runs the CoffeeScript to produce an HTML and an output file. You can edit this bit if the document is not producing HTML. Opens the HTML in your web browser and plumbs it back into `acme`.

~~~~ {.bash}
Edit ,>ssam -n 'x/^~~+[   ]*{\.[cC]offee[sS]cript.*}$/+,/^~~+$/-' |cat embed-standalone.coffee - |tee grimoire.coffee | coffee -cs >grimoire.js; coffee grimoire.coffee |tee grimoire-output.html >grimoire.output; open grimoire-output.html; plumb grimoire-output.html
~~~~

##### Create PDF with TeX

The following command produces a PDF version of the document. It uses XeTeX which in this case must be present on your system together with too many TeX packages to list (try a full 1.6Gb install if you have the bandwidth or spend hours as I do: start from a basic TeX and add individual packages one-by-one in the Tex Live Utility). It is not required unless you want a PDF version. By the way XeTeX has some trouble with Unicode characters, sometimes. Anyway it assumes that the command above has been run, the `VerbatimInput` lines near the end of this document (you can only see them in the markdown not in the HTML because they are TeX commands) uses the created files to insert program output and JavaScript translation into the PDF. You can delete those lines if you don't want that.

~~~~ {.bash}
Edit ,>markdown2pdf --listings --xetex '--template=pandoc-template.tex' -o grimoire.pdf; open grimoire.pdf
~~~~

##### Create an HTML~5~ Application

The last command produces an interactive HTML~5~ document. It does assume that the 2^nd^ commands above has been run sometime earlier (to bootstrap itself). The command below works as a straight pipeline. First running the markdown through `pandoc` to produce HTML~5~ with `section` and `mathml` elements[^1]. It creates a standalone document based on the template in `pandoc-template.html` and includes different CSS files for styling itself and its embedded editor. It also includes itself with the `-B` (`include-before-body`) option, not the interactive HTML that you might be reading, but the output-HTML that the interactive HTML produces.

[^1]: MathML is at this time not rendered in the two consumer browsers, Microsoft Internet Explorer and Google Chrome. I have tried MathJax but that resulted in Opera displaying garbage instead of equations. I found that it was unacceptable that Opera which does show W3C standard MathML get degraded, just because Google and Microsoft have chosen not to implement the standard. Of course in a commercial project the decision would likely be the other way round because of Opera's tiny market share compared with IE and Chrome. MathML renders fine in Firefox, Opera, and Safari on OS X & iOS.

The next four stages are all `ssam` substitutions in the HTML that `pandoc` produced. Talk about being dependent on internal implementation details --- the `pandoc` used is version is 1.8.2.

(@) The relevant `<code>` elements (based on their class and spelling) are made contenteditable. That is only used to allow them to get focus and could possibly be replaced by pseudo onclick handlers. They are also set to _not_ be `spellcheck`ed, which should be obvious for `<code>` elements. But even with that flag, Firefox still spellchecks the CoffeeScript in the elements displaying a lot of ugly squiggles.

(@) Sections with an id that starts with `view-solution` are hidden and given a `reveal` event handler. The hidden part goes on to the next section, which in the markdown can be marked with a header `#####` without a text. That bit is now depending on `pandoc` not optimizing those superfluous headers away. But it makes it possible for solutions to have multiple code blocks and images in them. 

(@) This part replaces the 1^st^ and only the 1^st^ image reference in a document with a canvas element. This is something that should be changed: a canvas element isn't usable without scripting and this could be done in scripting.

(@) The last defaults images to be centered instead of left aligned. This should be done in CSS instead.

~~~~ {.bash}
Edit ,>pandoc -f markdown -t html -S -5 --mathml --section-divs --css pandoc-template.css --css codemirror/codemirror.css --css codemirror/pantheme.css --template pandoc-template.html -B grimoire-output.html | ssam 's/(<code class="sourceCode [cC]offee[sS]cript")/\1 contenteditable=\"true\" spellcheck=\"false\"/g' | ssam 's/(<section id="view-solution[0-9\-]*")(>)(\n.*\n)(<section id="section[0-9\-]*")(>)/\1 onclick=\"reveal(this)\" \2\3\4 style=\"display:none\" \5/g' | ssam 's/<img src=\"[^\"]+\" alt=\"[^\"]+\" \/>/<canvas id=\"drawCanvas\" width=\"320\" height=\"320\" style=\"position: absolute; top: 333px; left: 200px\"><\/canvas>/' | ssam 's/(<p)(><img)/\1 align=center\2/g' >grimoire.html; open grimoire.html; plumb grimoire.html
~~~~

### Interactive Environment

~~~~ {.coffeescript}
webfragment = ->
~~~~

#### Feature detection warning elements

~~~~ {.coffeescript}
  div id: "feature-detect", ->
    div id: "feature-javascript", style: "color:#FF0000; display: block", ->
      text "No JavaScript &rarr; no output and no interactivity."
    div id: "feature-mathml", style: "color:#FF0000; display: none", ->
      text "No MathML 1998 &rarr; math is not readable."
    div id: "feature-canvas", style: "color:#FF0000; display: none", ->
      text "No Canvas &rarr; graphical output is not rendered."
    div id: "feature-contenteditable", style: "color:#FF0000; display: none", ->
      text "No ContentEditable &rarr; CoffeeScript sections can not be changed."
~~~~

#### User settings menu

~~~~ {.coffeescript}
  input class: 'field', type: 'button', value: 'Adjust layout', onclick: ->
    @value = if toggleLayout() then 'Layout: fixed' else 'Layout: freeflow'
  input class: 'field', type: 'button', value: 'Select editor', onclick: ->
    @value = if switchEditor() then 'Editor: CodeMirror' else 'Editor: plain text'
  input class: 'field', type: 'button', value: 'Evaluation', onclick: ->
    @value = if switchEvaluation() then '↑ ↩  Evaluate' else 'Auto Evaluate'
~~~~

#### External scripts

These scripts should be the same as those listed in the application manifest, `pandoc-template.appcache` that is mentioned in the `pandoc-template.html` file.

~~~~ {.coffeescript}
  script src: 'node_modules/coffee-script.js'
  script src: 'node_modules/coffeekup.js'
  script src: 'node_modules/underscore.js'
  script src: 'node_modules/qc.js'
  script src: 'codemirror/codemirror.js'
  script src: 'codemirror/coffeescript.js'
~~~~

### The Interactive Environment

~~~~ {.coffeescript}
  coffeescript ->
~~~~

#### Hidden sections support

~~~~ {.coffeescript}
    @reveal = (instance) -> # Very pandoc specific: requires --section-divs
      instance.getElementsByTagName('section')[0]?.style.display = 'block'
      instance.getElementsByTagName('h5')[0]?.innerHTML = 'Solution'
      instance.onclick = undefined
~~~~

#### User settings support

~~~~ {.coffeescript}
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
~~~~

#### Feature Detection

~~~~ {.coffeescript}
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
~~~~

#### Startup

~~~~ {.coffeescript}
    window.onload = ->
      featureDetect()
      switchLayout(on) if localStorage?.fixedLayout isnt 'false'
      @useCodeMirror = localStorage?.editor is 'CodeMirror'
~~~~

#### Runtime canvas support

As mentioned in the command used to create an [HTML~5~ application, item #3](#create-an-html5-application) this should not be done automatically.

~~~~ {.coffeescript}
      canvas = document.getElementById('drawCanvas')
      window.ctx = canvas.getContext '2d' if canvas?

      clearCanvas = ->
        if window.ctx?
          window.ctx.clearRect 0, 0,
            window.ctx.canvas.width, window.ctx.canvas.height
      drawCanvas = (draw) ->
        clearCanvas()
        draw window.ctx
~~~~

#### Runtime output support

The `dataurl` in `addFrame` is not displayed in IE9 nor is its `innerHTML`.

~~~~ {.coffeescript}
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
~~~~

#### CoffeeScript Evaluation

This is called during startup for a full evaluation. It is also triggered by changes in one of the editor types, where it can be full evaluation with code stitching for short articles or incremental i.e. one code block for a whole book.

~~~~ {.coffeescript}
      evaluateSource = (field = null) ->
~~~~

#### Main output functions

~~~~ {.coffeescript}
        show = (obj, shallow = false, symbol = '&rarr;') ->
          showHere currentTag, obj, shallow, symbol
          return # Suppress display of the return value
        view = (obj, shallow = false, symbol = '&rarr;') ->
          showHere currentTag, obj, shallow, symbol
        showDocument = (content, width = 300, height = 300) ->
          showDocumentHere currentTag, content, width, height
        addErrorElement = (text) ->
          show """<span class="er">#{text}</span>"""
~~~~

#### Callbacks with output related to place of definition

~~~~ {.coffeescript}
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
~~~~

#### QuickCheck

You may ask: "What are these completely unrelated QuickCheck helpers doing here?" Well, it could be that I am simply trying to distract you while I pull something out of my sleeve --- or it could be that I didn't get round to moving them into `qc.js`, which as its name implies is written in JavaScript (and it is not a CommonJS module either).

Incidentally JavaScript could learn a thing or two from CoffeeScript. For example: it could use a backtick feature for embedding CoffeeScript into it. Until the day when these helpers are moved to a better resting place, at least they are not doing much harm here … unless you summon them. QuickCheck is a minor imp, using randomness to cause havoc in your code. Several examples are shown in 'Smooth CoffeeScript' which is why the helpers are here. Let me know if you should have converted `qc.js` to CoffeeScript or have written something better.

~~~~ {.coffeescript}
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
~~~~

#### Traversing and unescaping

The code for the field or the document is obtained with tags that relate the code back to its HTML element. The tag is needed to direct output to its place of origin. When an editor is instantiated for a `<code>` element it changes to a `<textarea>` so matching is on the class of a `<pre>`'s firstChild.

~~~~ {.coffeescript}
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
~~~~

Stitch together continuing code segments. This is done based on a test of whether they begin with whitespace. For example a class with methods in different code blocks or a program that is split up in sections as in this document. This only works during full evaluation.

~~~~ {.coffeescript}
          segments = (segment for segment in segments when segment?)
          for segment, i in segments
            if i > 0 and /^[\s]/.test segment.code
              segment.code = segments[i-1].code + '\n' + segment.code
              segments[i-1] = undefined
          segments = (segment for segment in segments when segment?)
~~~~

#### Clear output

A performance test showed that the vast majority of time was consumed by this little loop: deleting previously shown output from the DOM. It made full code reevaluation an impossibility for anything but short articles. It was tested in three different browsers and `removeChild` was unbeliably slow in all of them. I don't know of alternatives for quickly removing elements, so the evaluation model for large documents was changed to incremental.

~~~~ {.coffeescript}
        for segment in segments
          outList = getParent(segment.codeTag).getElementsByClassName 'output'
          outLength = outList?.length
          while outList and outLength > 0
            elem = outList[--outLength]
            getParent(elem).removeChild elem
~~~~

#### Evaluation

No real sandbox here, so the names and loop construct was changed to minimize the chance of conflict with the code that is being executed. Since clearing output made full reevaluation impossible, a small system where variables that are mentioned in `globalNames` are automatically promoted from the execution environment to the global environment was set up. This makes the named previous definitions available in subsequent code blocks during incremental evaluation (where there is no code stitching).

~~~~ {.coffeescript}
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
~~~~

#### Embedded Editors

~~~~ {.coffeescript}
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
~~~~

Create an editor by converting a `<code>` element to a `<textarea>`. If CodeMirror is enabled then the `<textarea>` is used as a basis for that editor.

~~~~ {.coffeescript}
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
~~~~

Setup editor activation

~~~~ {.coffeescript}
      activateEditor = ->
        @removeEventListener 'focus', activateEditor, false
        sourcecode = @innerHTML.toString().replace /<\/?span[^>]*>/g, ''
        sourcecode = sourcecode.replace /<br[ ]*[^>]*>/g, '\n'
        createEditor this, sourcecode

      # Activate text editor when code gets focus
      for segment in document.getElementsByTagName 'pre'
        segment.firstChild.addEventListener 'focus', activateEditor, false
~~~~

Complete evaluation works for smaller articles, but not for a whole book. This is primarily because getting rid of old output elements with the DOM `removeChild` is very slow.

So set `@incrementalEvaluation` to `on` in larger texts.

A suitable place is the same --- likely hidden --- section were `@globalNames` is initialized. Code stitching is only in effect when `@incrementalEvaluation` is `off`.

~~~~ {.coffeescript}
      @incrementalEvaluation = off
      evaluateSource()
~~~~

#### Bootstrap

Create the embeddable HTML/JavaScript fragment as output. This does not actually bootstrap Grimoire. If it did then as soon as an error happened during editing, the whole thing would come tumbling down. To bootstrap use the [Editor Commandline Commands](#editor-commandline-commands) or copy the code from the output field.

Is it possible to copyright magic? Let's say that the HTML/JavaScript code that is produced by this document is public domain or MIT licensed. Then you can use that any way you want to at your own risk. This document itself is licensed as CC-BYSA. To get the all the files this depend on go to the `interactive` directory in the repository branch [`gh-pages`](https://github.com/autotelicum/Smooth-CoffeeScript/tree/gh-pages/interactive). 

~~~~ {.coffeescript}

kup = if exports? then require 'coffeekup' else window.CoffeeKup

display = if exports?
  console.log
else
  (html) -> show _.escape html

display kup.render webfragment, format:on

~~~~

-----------------------------------------------------------------------------

\subsection{Output}
\VerbatimInput[baselinestretch=1,fontsize=\footnotesize,numbers=left]{grimoire-output.html}

\subsection{JavaScript}
\VerbatimInput[baselinestretch=1,fontsize=\footnotesize,numbers=left]{grimoire.js}

\rule[0.5ex]{1\columnwidth}{1pt}

Formats [Standalone](http://autotelicum.github.com/Smooth-CoffeeScript/interactive/grimoire-output.html)	[CoffeeScript](http://autotelicum.github.com/Smooth-CoffeeScript/interactive/grimoire.coffee)	[Markdown](http://autotelicum.github.com/Smooth-CoffeeScript/interactive/grimoire.md) [PDF](http://autotelicum.github.com/Smooth-CoffeeScript/interactive/grimoire.pdf) [HTML](http://autotelicum.github.com/Smooth-CoffeeScript/interactive/grimoire.html)

License [Creative Commons Attribution Share Alike](http://creativecommons.org/licenses/by-sa/3.0/)
by autotelicum © 2555/2012
