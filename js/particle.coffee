---
---

define ['vector'], (Vector) ->
  class Particle
    GRAVITATIONAL_CONSTANT: 0.001
    MIN_MASS: 1
    MAX_MASS: 100
    POSITION_RADIUS: 250
    VELOCITY_RADIUS: 0.1

    @particles: []

    lastUpdateTime: 0

    constructor: (@mass, @position, @velocity) ->
      a = Math.random()
      angle = Math.random() * Math.PI * 2
      radius = a * a
      posX = Math.sin(angle) * radius * @POSITION_RADIUS
      posY = Math.cos(angle) * radius * @POSITION_RADIUS

      b = Math.random()
      velX = Math.cos(angle) * radius * @VELOCITY_RADIUS
      velY = -Math.sin(angle) * radius * @VELOCITY_RADIUS

      @mass ||= Math.random() * (@MAX_MASS - @MIN_MASS) + @MIN_MASS
      @position ||= new Vector(posX, posY)
      @velocity ||= new Vector(velX, velY)
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

    radius: ->
      1

    render: (context) ->
      context.fillStyle = '#FFFFFF'
      context.beginPath()
      context.arc @position.x, @position.y, @radius(), 0, Math.PI*2
      context.fill()
