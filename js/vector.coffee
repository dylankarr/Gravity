---
---

define ->
  class Vector
    constructor: ->
      if typeof arguments[0] == 'number'
        @x = arguments[0]
        @y = arguments[1]
      else
        @x = arguments[0].x
        @y = arguments[0].y

    add: (vector) ->
      new Vector @x + vector.x, @y + vector.y

    subtract: (vector) ->
      new Vector @x - vector.x, @y - vector.y

    multiply: (a) ->
      new Vector @x * a, @y * a

    angle: ->
      Math.atan2 @y, @x

    squareMagnitude: ->
      @x * @x + @y * @y

    magnitude: ->
      Math.sqrt @squareMagnitude()
