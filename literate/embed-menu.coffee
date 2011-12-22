###
Edit ,>coffee -s >embed-menu.html; plumb embed-menu.html
###

kup = require 'coffeekup'

webfragment = ->
  input class: 'field', type: 'button', value: 'Adjust Width', onclick: ->
    @value = if toggleLayout() then 'Allow Freeflow' else 'Limit Width'
  coffeescript ->
    @toggleLayout = ->
      fixedLayout = document.getElementById('page').style.maxWidth is ''
      localStorage?.fixedLayout = fixedLayout
      switchLayout fixedLayout
    switchLayout = (fixedLayout) ->
      document.getElementById('page').style.maxWidth =
        if fixedLayout then '600px' else ''
      fixedLayout
    window.onload = ->
      switchLayout(on) if localStorage?.fixedLayout isnt 'false'

console.log kup.render webfragment, format:on
