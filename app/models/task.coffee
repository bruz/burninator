Model = require './model'

module.exports = class Task extends Model
  className: 'Task'

  # all removed (completed) hours
  completedHours: ->
    hours = @get('hours')
    _.reduce hours, (memo, h) ->
      if h.hours
        memo - h.hours
      else
        memo
    , 0

  changeHours: (change) ->
    hours = @get('hours')
    today = Date.today().toString('M/d/yyyy')

    hours.push {date: today, hours: change}

    @trigger('change:hours')

  remainingHoursOn: (date) ->
    hours = @get('hours')

    @get('totalHours') + _.reduce hours, (memo, h) ->
      hoursDate = new Date(h.date)

      if hoursDate <= date
        memo += h.hours
      else
        memo
    , 0
