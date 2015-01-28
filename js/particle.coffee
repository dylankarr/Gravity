---
---

define ['vector'], (Vector) ->
  class Particle
    GRAVITATIONAL_CONSTANT: 0.001
    MIN_MASS: 1
    MAX_MASS: 10
    POSITION_RADIUS: 250
    VELOCITY_RADIUS: 0.001

    @particles: []

    lastUpdateTime: 0

    constructor: (@mass, @position, @velocity) ->
      a = Math.random()
      posAngle = Math.random() * Math.PI * 2
      posRadius = a * a * @POSITION_RADIUS
      posX = Math.sin(posAngle) * posRadius
      posY = Math.cos(posAngle) * posRadius

      b = Math.random()
      velAngle = Math.random() * Math.PI * 2
      velRadius = b * b * @VELOCITY_RADIUS
      velX = Math.sin(velAngle) * velRadius
      velY = Math.cos(velAngle) * velRadius

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

    render: (context) ->
      context.fillStyle = '#FFFFFF'
      context.beginPath()
      context.arc @position.x, @position.y, @mass, 0, Math.PI*2
      context.fill()
