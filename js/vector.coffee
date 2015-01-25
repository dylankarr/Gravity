---
---

define ->
  class Vector
    constructor: (@x, @y) ->

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
