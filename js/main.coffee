---
---

require.config
  paths:
    jquery: '//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min'
    underscore: '//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.7.0/underscore-min'

require ['particle', 'vector', 'camera', 'time'], (Particle, Vector, Camera, Time) ->
  PARTICLE_COUNT = 100

  canvas = document.getElementsByTagName('canvas')[0]
  context = canvas.getContext '2d'

  for i in [1..PARTICLE_COUNT]
    new Particle

  camera = new Camera

  renderParticles = (time) ->
    Time.update time

    camera.update Time.rawDeltaTime()
    camera.render context, canvas

    for particle in Particle.particles
      particle.update Time.deltaTime()
      particle.render context

    window.requestAnimationFrame renderParticles

  renderParticles 0
