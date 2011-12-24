###
Edit ,>coffee -s >embed-menu.html; plumb embed-menu.html
###

kup = require 'coffeekup'

webfragment = ->
  input class: 'field', type: 'button', value: 'Adjust layout', onclick: ->
    @value = if toggleLayout() then 'Layout: fixed' else 'Layout: freeflow'
  coffeescript ->
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
    window.onload = ->
      switchLayout(on) if localStorage?.fixedLayout isnt 'false'

console.log kup.render webfragment, format:on
