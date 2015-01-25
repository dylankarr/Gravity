---
---

define ['vector'], (Vector) ->
  class Particle
    GRAVITATIONAL_CONSTANT: 0.001

    @particles: []

    lastUpdateTime: 0

    constructor: (@mass, @position, @velocity) ->
      Particle.particles.push @

    update: (time) ->
      deltaTime = time - @lastUpdateTime
      @lastUpdateTime = time

      return null if deltaTime == 0

      @force = new Vector(0, 0)
      @applyGravity()

      @velocity = @velocity.add @force.multiply(deltaTime)
      @position = @position.add @velocity.multiply(deltaTime)

    applyGravity: ->
      for particle in Particle.particles
        delta = particle.position.subtract @position
        if delta.magnitude() > @mass + particle.mass
          gForce = @GRAVITATIONAL_CONSTANT * particle.mass / delta.squareMagnitude()
          x = gForce * Math.cos(delta.angle())
          y = gForce * Math.sin(delta.angle())
          @force = @force.add new Vector(x, y)


    render: (context, scale) ->
      context.fillStyle = '#FFFFFF'
      context.beginPath()
      context.arc @position.x, @position.y, @mass, 0, Math.PI*2
      context.fill()
