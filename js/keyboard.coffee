---
---

define ['jquery'], ($) ->
  class Keyboard
    @keys = {}

    @pressKey: (e) ->
      Keyboard.keys[e.originalEvent.keyCode] = true

    @liftKey: (e) ->
      delete Keyboard.keys[e.originalEvent.keyCode]

    @isDown: (keyCode) ->
      Keyboard.keys[keyCode] == true

  $(window).keydown Keyboard.pressKey
  $(window).keyup Keyboard.liftKey

  Keyboard
