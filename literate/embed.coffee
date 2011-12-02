
# Usage: coffee -s <embed.coffee >embed.html

kup = require 'coffeekup'
webpage = kup.render -> 
  input class: 'field', type: 'button', value: 'Adjust Width', onclick: ->
    document.getElementById('page').style.maxWidth =
      if document.getElementById('page').style.maxWidth is '' then '600px' else ''
  script src: 'node_modules/coffee-script.js'
  coffeescript ->
    window.onload = ->
      canvas = document.getElementById('drawCanvas')
      window.ctx = canvas.getContext '2d' if canvas?
      evaluateSource = ->
        program = ''
        if window.ctx?
          window.ctx.clearRect 0, 0,
            window.ctx.canvas.width, window.ctx.canvas.height
        document.getElementsByClassName('output')[0]
          .getElementsByTagName('code')[0].innerHTML = ''
        for codeSegment in document.getElementsByTagName 'pre'
          if codeSegment.className is 'sourceCode'
            codeTag = codeSegment.getElementsByTagName('code')[0]
            if codeTag.className is 'sourceCode coffeescript'
              segment = codeTag.innerHTML
              code = segment.replace /<br>/g, '\n'
              code = code.replace /<[^>]*>/g, ''
              code = code.replace /[&]gt;/g, '>'
              code = code.replace /[&]lt;/g, '<'
              program += code + '\n'
        jsprogram = ''
        try
          jsprogram = CoffeeScript.compile program, bare: on
          document.getElementsByClassName('js-source')[0]
            .getElementsByTagName('code')[0].innerHTML = jsprogram
        catch error
          document.getElementsByClassName('js-source')[0]
            .getElementsByTagName('code')[0].innerHTML = error
          return
        jsprogram = '''var show = function(msg) {
                       window.document.getElementsByClassName('output')[0]
                         .getElementsByTagName('code')[0].innerHTML += msg + '\\n'; };
                    ''' + jsprogram +
                    '; if (typeof draw !== "undefined") draw(window.ctx);'
        try
          eval jsprogram
        catch error
          document.getElementsByClassName('output')[0]
            .getElementsByTagName('code')[0].innerHTML = error

      for segment in document.getElementsByTagName 'pre'
        segment.getElementsByTagName('code')[0]
          .addEventListener 'keyup', evaluateSource, false
      evaluateSource()
, format:on

(require 'fs').writeFileSync "./embed.html", webpage
