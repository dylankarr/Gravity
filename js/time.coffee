---
---

define ['keyboard'], (Keyboard) ->
  class Time
    @TIME_SCALE_SPEED: 0.001

    @_deltaTime: 0
    @_previousTime: 0
    @_paused: false
    @_pauseKey: false
    @_timeScale: 1

    @update: (time) ->
      if Time._pauseKey && !Keyboard.isDown 32
        Time._paused = !Time._paused
        Time._pauseKey = false
      else if Keyboard.isDown 32
        Time._pauseKey = true

      Time._deltaTime = time - Time._previousTime
      Time._timeScale += Time.TIME_SCALE_SPEED * Time._deltaTime if Keyboard.isDown 187
      Time._timeScale -= Time.TIME_SCALE_SPEED * Time._deltaTime if Keyboard.isDown 189
      Time._previousTime = time

    @deltaTime: ->
      return 0 if Time._paused
      Time._deltaTime * Time._timeScale

    @rawDeltaTime: ->
      Time._deltaTime
