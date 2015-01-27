---
---

define ['jquery'], ($) ->
  class Keyboard
    @keys = {}

    @pressKey: (e) ->
      e.preventDefault()
      Keyboard.keys[e.originalEvent.keyCode] = true

    @liftKey: (e) ->
      e.preventDefault()
      delete Keyboard.keys[e.originalEvent.keyCode]

    @isDown: (keyCode) ->
      Keyboard.keys[keyCode] == true

  $(window).keydown Keyboard.pressKey
  $(window).keyup Keyboard.liftKey

  Keyboard
