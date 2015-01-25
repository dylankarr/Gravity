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
  PARTICLE_COUNT = 500
  MIN_MASS = 10
  MAX_MASS = 1

  width = window.innerWidth
  height = window.innerHeight

  $('canvas').attr 'width', width
  $('canvas').attr 'height', height

  ctx = $('canvas')[0].getContext '2d'

  for i in [1..PARTICLE_COUNT]
    mass = Math.random() * (MAX_MASS - MIN_MASS) + MIN_MASS
    position = new Vector Math.random() * width, Math.random() * height
    velocity = new Vector 0, 0
    new Particle mass, position, velocity

  renderParticles = (time) ->
    ctx.clearRect 0, 0, width, height

    for particle in Particle.particles
      particle.update time
      particle.render ctx

    window.requestAnimationFrame _.debounce renderParticles, @MAX_UPDATE_RATE, true

  renderParticles 0
