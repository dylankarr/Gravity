---
---

require.config
  shim:
    underscore:
      exports: '_'
  paths:
    jquery: '//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min'
    underscore: '//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.7.0/underscore-min'

require ['jquery', 'underscore', 'particle', 'vector', 'camera'], ($, _, Particle, Vector, Camera) ->
  MAX_UPDATE_RATE = 0
  PARTICLE_COUNT = 100
  MIN_MASS = 1
  MAX_MASS = 10

  width = window.innerWidth
  height = window.innerHeight
  lastUpdateTime = 0
  paused = false

  $('canvas').attr 'width', width
  $('canvas').attr 'height', height

  $(window).keyup (e) ->
    e.preventDefault()
    if e.keyCode == 32
      paused = !paused

  ctx = $('canvas')[0].getContext '2d'

  for i in [1..PARTICLE_COUNT]
    mass = Math.random() * (MAX_MASS - MIN_MASS) + MIN_MASS
    position = new Vector Math.random() * width, Math.random() * height
    velocity = new Vector 0, 0
    new Particle mass, position, velocity

  camera = new Camera

  renderParticles = (time) ->
    deltaTime = time - lastUpdateTime
    lastUpdateTime = time

    camera.update deltaTime
    camera.render ctx, width, height

    for particle in Particle.particles
      particle.update deltaTime * camera.timeScale unless paused
      particle.render ctx

    camera.reset ctx
    window.requestAnimationFrame _.debounce renderParticles, @MAX_UPDATE_RATE, true

  renderParticles 0
