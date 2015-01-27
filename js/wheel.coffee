---
---

define ['jquery', 'vector'], ($, Vector) ->
  class Wheel
    @WHEEL_SPEED = 0.1
    @offset = new Vector(0, 0)

    @moveWheel: (e) ->
      e.preventDefault()
      Wheel.offset = Wheel.offset.add new Vector
        x: -e.originalEvent.deltaX
        y: -e.originalEvent.deltaY

    @getOffset: ->
      offset = @offset
      @offset = new Vector(0, 0)
      offset.multiply(Wheel.WHEEL_SPEED)

  $(window).bind 'wheel', Wheel.moveWheel

  Wheel
