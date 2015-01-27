---
---

define ['vector'], (Vector) ->
  class Particle
    GRAVITATIONAL_CONSTANT: 0.001

    @particles: []

    lastUpdateTime: 0

    constructor: (@mass, @position, @velocity) ->
      @acceleration = new Vector(0, 0)
      Particle.particles.push @

    update: (deltaTime) ->
      return null if deltaTime == 0

      for particle in Particle.particles
        @applyGravity particle

      @velocity = @acceleration.multiply(deltaTime).add(@velocity)
      @position = @velocity.multiply(deltaTime).add(@position)
      @acceleration = new Vector(0, 0)

    applyGravity: (particle) ->
      delta = particle.position.subtract @position
      if delta.magnitude() > @mass + particle.mass
        gForce = @GRAVITATIONAL_CONSTANT * particle.mass * @mass / delta.squareMagnitude()
        @applyForce new Vector
          x: gForce * Math.cos(delta.angle())
          y: gForce * Math.sin(delta.angle())

    applyForce: (force) ->
      @acceleration = force.multiply(1/@mass).add(@acceleration)

    render: (context) ->
      context.fillStyle = '#FFFFFF'
      context.beginPath()
      context.arc @position.x, @position.y, @mass, 0, Math.PI*2
      context.fill()
