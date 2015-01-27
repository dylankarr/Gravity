---
---

define ['vector', 'keyboard', 'wheel'], (Vector, Keyboard, Wheel) ->
  class Camera
    PAN_SPEED: 1
    ROTATE_SPEED: 0.001
    ZOOM_SPEED: 0.001
    TIME_SCALE_SPEED: 0.001

    offset: new Vector(0, 0)
    rotation: 0
    scale: 1
    timeScale: 1

    update: (deltaTime) ->
      @timeScale += @TIME_SCALE_SPEED * deltaTime if Keyboard.isDown 187
      @timeScale -= @TIME_SCALE_SPEED * deltaTime if Keyboard.isDown 189
      @rotation += @ROTATE_SPEED * deltaTime if Keyboard.isDown 69
      @rotation -= @ROTATE_SPEED * deltaTime if Keyboard.isDown 81
      @rotation = ((@rotation%(Math.PI*2))+(Math.PI*2))%(Math.PI*2)
      @scale *= 1 + @ZOOM_SPEED * deltaTime if Keyboard.isDown 88
      @scale *= 1 - @ZOOM_SPEED * deltaTime if Keyboard.isDown 90
      @offset = @offset.add new Vector(@PAN_SPEED * deltaTime, 0) if Keyboard.isDown 65
      @offset = @offset.add new Vector(0, @PAN_SPEED * deltaTime) if Keyboard.isDown 87
      @offset = @offset.add new Vector(-@PAN_SPEED * deltaTime, 0) if Keyboard.isDown 68
      @offset = @offset.add new Vector(0, -@PAN_SPEED * deltaTime) if Keyboard.isDown 83
      @offset = Wheel.getOffset().multiply(deltaTime).add(@offset)

    render: (context, width, height) ->
      context.clearRect 0, 0, width, height
      context.translate width/2, height/2
      context.translate @offset.x, @offset.y
      context.rotate @rotation
      context.scale @scale, @scale
      context.translate -width/2, -height/2

    reset: (context) ->
      context.setTransform 1, 0, 0, 1, 0, 0
