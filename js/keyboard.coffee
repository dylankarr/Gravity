---
---

define ->
  class Keyboard
    @keys = {}

    @pressKey: (e) ->
      e.preventDefault()
      Keyboard.keys[e.keyCode] = true

    @liftKey: (e) ->
      e.preventDefault()
      delete Keyboard.keys[e.keyCode]

    @isDown: (keyCode) ->
      Keyboard.keys[keyCode] == true

  window.addEventListener 'keydown', Keyboard.pressKey
  window.addEventListener 'keyup', Keyboard.liftKey

  Keyboard
