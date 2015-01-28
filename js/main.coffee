---
---

require.config
  shim:
    underscore:
      exports: '_'
  paths:
    jquery: '//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min'
    underscore: '//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.7.0/underscore-min'

require ['jquery', 'underscore', 'particle', 'vector', 'camera', 'keyboard'], ($, _, Particle, Vector, Camera, Keyboard) ->
  MAX_UPDATE_RATE = 0
  PARTICLE_COUNT = 100
  TIME_SCALE_SPEED = 0.001

  width = window.innerWidth
  height = window.innerHeight
  lastUpdateTime = 0
  paused = false
  timeScale = 1

  $('canvas').attr 'width', width
  $('canvas').attr 'height', height

  $(window).keyup (e) ->
    e.preventDefault()
    if e.keyCode == 32
      paused = !paused

  ctx = $('canvas')[0].getContext '2d'

  for i in [1..PARTICLE_COUNT]
    new Particle

  camera = new Camera

  renderParticles = (time) ->
    deltaTime = time - lastUpdateTime
    lastUpdateTime = time

    camera.update deltaTime
    camera.render ctx, width, height

    timeScale += TIME_SCALE_SPEED * deltaTime if Keyboard.isDown 187
    timeScale -= TIME_SCALE_SPEED * deltaTime if Keyboard.isDown 189

    for particle in Particle.particles
      particle.update deltaTime * timeScale unless paused
      particle.render ctx

    camera.reset ctx
    window.requestAnimationFrame _.debounce renderParticles, @MAX_UPDATE_RATE, true

  renderParticles 0
