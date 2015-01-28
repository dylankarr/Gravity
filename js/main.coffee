---
---

require.config
  shim:
    underscore:
      exports: '_'
  paths:
    jquery: '//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min'
    underscore: '//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.7.0/underscore-min'

require ['jquery', 'underscore', 'particle', 'vector', 'camera', 'time'], ($, _, Particle, Vector, Camera, Time) ->
  MAX_UPDATE_RATE = 0
  PARTICLE_COUNT = 100

  width = window.innerWidth
  height = window.innerHeight

  $('canvas').attr 'width', width
  $('canvas').attr 'height', height

  ctx = $('canvas')[0].getContext '2d'

  for i in [1..PARTICLE_COUNT]
    new Particle

  camera = new Camera

  renderParticles = (time) ->
    Time.update time

    camera.update Time.rawDeltaTime()
    camera.render ctx, width, height

    for particle in Particle.particles
      particle.update Time.deltaTime()
      particle.render ctx

    camera.reset ctx
    window.requestAnimationFrame _.debounce renderParticles, MAX_UPDATE_RATE, true

  renderParticles 0
