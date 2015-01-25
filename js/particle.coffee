---
---

define ['vector'], (Vector) ->
  class Particle
    GRAVITATIONAL_CONSTANT: 1

    @particles: []

    lastUpdateTime: 0

    constructor: (@mass, @position, @velocity) ->
      Particle.particles.push @

    update: (time) ->
      deltaTime = time - @lastUpdateTime
      @lastUpdateTime = time

      return null if deltaTime == 0

      for particle in Particle.particles
        delta = particle.position.subtract @position
        if delta.magnitude() > @mass + particle.mass
          gForce = @GRAVITATIONAL_CONSTANT * particle.mass / delta.squareMagnitude()
          x = gForce * Math.cos(delta.angle()) / deltaTime
          y = gForce * Math.sin(delta.angle()) / deltaTime
          @velocity = new Vector(x + @velocity.x, y + @velocity.y)

      @position = @position.add @velocity.multiply(deltaTime)

    render: (context, scale) ->
      context.fillStyle = '#FFFFFF'
      context.beginPath()
      context.arc @position.x, @position.y, @mass, 0, Math.PI*2
      context.fill()
