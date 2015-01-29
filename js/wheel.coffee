---
---

define ['vector'], (Vector) ->
  class Wheel
    @WHEEL_SPEED = 0.1
    @offset = new Vector(0, 0)

    @moveWheel: (e) ->
      e.preventDefault()
      Wheel.offset = Wheel.offset.add new Vector
        x: -e.deltaX
        y: -e.deltaY

    @getOffset: ->
      offset = @offset
      @offset = new Vector(0, 0)
      offset.multiply(Wheel.WHEEL_SPEED)

  window.addEventListener 'mousewheel', Wheel.moveWheel

  Wheel
