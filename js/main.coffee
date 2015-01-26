---
---

require.config
  shim:
    underscore:
      exports: '_'
  paths:
    jquery: '//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min'
    underscore: '//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.7.0/underscore-min'

require ['jquery', 'underscore', 'particle', 'vector'], ($, _, Particle, Vector) ->
  MAX_UPDATE_RATE = 1
  PARTICLE_COUNT = 100
  MIN_MASS = 1
  MAX_MASS = 10
  PAN_SPEED = 10
  ROTATE_SPEED = 0.01
  SCALE_SPEED = 1.1
  TIME_SCALE_SPEED = 1.1

  width = window.innerWidth
  height = window.innerHeight
  offset = new Vector(0, 0)
  rotation = 0
  scale = 1
  timeScale = 1
  lastUpdateTime = 0

  $('canvas').attr 'width', width
  $('canvas').attr 'height', height

  $(window).bind 'wheel', (e) ->
    e.preventDefault()
    console.log e.originalEvent.deltaZ
    offset = offset.add new Vector
      x: -e.originalEvent.deltaX
      y: -e.originalEvent.deltaY

  $(window).keyup (e) ->
    e.preventDefault()
    if e.keyCode == 32
      if timeScale == 0
        timeScale = 1
      else
        timeScale = 0

  $(window).keydown (e) ->
    e.preventDefault()
    if e.keyCode == 187
      timeScale *= TIME_SCALE_SPEED
    if e.keyCode == 189
      timeScale /= TIME_SCALE_SPEED
    if e.keyCode == 88
      scale *= SCALE_SPEED
    if e.keyCode == 90
      scale /= SCALE_SPEED
    if e.keyCode == 81
      rotation -= ROTATE_SPEED
    if e.keyCode == 69
      rotation += ROTATE_SPEED
    if e.keyCode == 37 || e.keyCode == 65
      offset = offset.add new Vector(PAN_SPEED, 0)
    if e.keyCode == 38 || e.keyCode == 87
      offset = offset.add new Vector(0, PAN_SPEED)
    if e.keyCode == 39 || e.keyCode == 68
      offset = offset.add new Vector(-PAN_SPEED, 0)
    if e.keyCode == 40 || e.keyCode == 83
      offset = offset.add new Vector(0, -PAN_SPEED)
    rotation = ((rotation%(Math.PI*2))+(Math.PI*2))%(Math.PI*2)

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

    ctx.clearRect 0, 0, width, height
    ctx.translate offset.x, offset.y
    ctx.translate width/2, height/2
    ctx.rotate rotation
    ctx.scale scale, scale
    ctx.translate -width/2, -height/2

    for particle in Particle.particles
      particle.update deltaTime
      particle.render ctx

    ctx.translate width/2, height/2
    ctx.scale 1/scale, 1/scale
    ctx.rotate -rotation
    ctx.translate -width/2, -height/2
    ctx.translate -offset.x, -offset.y
    window.requestAnimationFrame _.debounce renderParticles, @MAX_UPDATE_RATE, true

  renderParticles 0
