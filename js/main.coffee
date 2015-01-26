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

  width = window.innerWidth
  height = window.innerHeight
  offset = new Vector(0, 0)

  $('canvas').attr 'width', width
  $('canvas').attr 'height', height

  $(window).bind 'wheel', (e) ->
    e.preventDefault()
    offset = offset.add new Vector
      x: -e.originalEvent.deltaX
      y: -e.originalEvent.deltaY

  $(window).keydown (e) ->
    e.preventDefault()
    if e.keyCode == 37 || e.keyCode == 65
      offset = offset.add new Vector(PAN_SPEED, 0)
    if e.keyCode == 38 || e.keyCode == 87
      offset = offset.add new Vector(0, PAN_SPEED)
    if e.keyCode == 39 || e.keyCode == 68
      offset = offset.add new Vector(-PAN_SPEED, 0)
    if e.keyCode == 40 || e.keyCode == 83
      offset = offset.add new Vector(0, -PAN_SPEED)

  ctx = $('canvas')[0].getContext '2d'

  for i in [1..PARTICLE_COUNT]
    mass = Math.random() * (MAX_MASS - MIN_MASS) + MIN_MASS
    position = new Vector Math.random() * width, Math.random() * height
    velocity = new Vector 0, 0
    new Particle mass, position, velocity

  renderParticles = (time) ->
    ctx.clearRect 0, 0, width, height
    ctx.translate offset.x, offset.y

    for particle in Particle.particles
      particle.update time
      particle.render ctx

    ctx.translate -offset.x, -offset.y
    window.requestAnimationFrame _.debounce renderParticles, @MAX_UPDATE_RATE, true

  renderParticles 0
