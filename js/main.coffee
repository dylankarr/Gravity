---
---

require.config
  shim:
    underscore:
      exports: '_'
  paths:
    jquery: '//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min'
    underscore: '//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.7.0/underscore-min'

require ['jquery', 'underscore', 'particle', 'vector', 'keyboard'], ($, _, Particle, Vector, Keyboard) ->
  MAX_UPDATE_RATE = 0
  PARTICLE_COUNT = 100
  MIN_MASS = 1
  MAX_MASS = 10
  PAN_SPEED = 1
  ROTATE_SPEED = 0.001
  ZOOM_SPEED = 0.001
  TIME_SCALE_SPEED = 1.1

  width = window.innerWidth
  height = window.innerHeight
  offset = new Vector(0, 0)
  rotation = 0
  scale = 1
  timeScale = 1
  lastUpdateTime = 0
  paused = false

  $('canvas').attr 'width', width
  $('canvas').attr 'height', height

  $(window).bind 'wheel', (e) ->
    e.preventDefault()
    offset = offset.add new Vector
      x: -e.originalEvent.deltaX
      y: -e.originalEvent.deltaY

  $(window).keyup (e) ->
    e.preventDefault()
    if e.keyCode == 32
      paused = !paused

  $(window).keydown (e) ->
    e.preventDefault()
    if e.keyCode == 187
      timeScale *= TIME_SCALE_SPEED
    if e.keyCode == 189
      timeScale /= TIME_SCALE_SPEED

  ctx = $('canvas')[0].getContext '2d'

  for i in [1..PARTICLE_COUNT]
    mass = Math.random() * (MAX_MASS - MIN_MASS) + MIN_MASS
    position = new Vector Math.random() * width, Math.random() * height
    velocity = new Vector 0, 0
    new Particle mass, position, velocity

  renderParticles = (time) ->
    deltaTime = time - lastUpdateTime
    lastUpdateTime = time
    deltaTime *= timeScale

    rotation += ROTATE_SPEED * deltaTime if Keyboard.isDown 69
    rotation -= ROTATE_SPEED * deltaTime if Keyboard.isDown 81
    rotation = ((rotation%(Math.PI*2))+(Math.PI*2))%(Math.PI*2)
    scale *= 1 + ZOOM_SPEED * deltaTime if Keyboard.isDown 88
    scale /= 1 + ZOOM_SPEED * deltaTime if Keyboard.isDown 90
    offset = offset.add new Vector(PAN_SPEED * deltaTime, 0) if Keyboard.isDown 65
    offset = offset.add new Vector(0, PAN_SPEED * deltaTime) if Keyboard.isDown 87
    offset = offset.add new Vector(-PAN_SPEED * deltaTime, 0) if Keyboard.isDown 68
    offset = offset.add new Vector(0, -PAN_SPEED * deltaTime) if Keyboard.isDown 83

    ctx.clearRect 0, 0, width, height
    ctx.translate width/2, height/2
    ctx.translate offset.x, offset.y
    ctx.rotate rotation
    ctx.scale scale, scale
    ctx.translate -width/2, -height/2

    for particle in Particle.particles
      particle.update deltaTime unless paused
      particle.render ctx

    ctx.setTransform 1, 0, 0, 1, 0, 0
    window.requestAnimationFrame _.debounce renderParticles, @MAX_UPDATE_RATE, true

  renderParticles 0
