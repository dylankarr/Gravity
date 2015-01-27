---
---

define ['vector'], (Vector) ->
  class Particle
    MIN_MASS: 1
    MAX_MASS: 10
    GRAVITATIONAL_CONSTANT: 0.001

    @particles: []

    lastUpdateTime: 0

    constructor: (@mass, @position, @velocity) ->
      angle = Math.random() * Math.PI * 2
      radius = Math.random() * Math.random() * 500
      x = Math.sin(angle) * radius
      y = Math.cos(angle) * radius

      @mass ||= Math.random() * (@MAX_MASS - @MIN_MASS) + @MIN_MASS
      @position ||= new Vector(x, y)
      @velocity ||= new Vector(0, 0)
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
