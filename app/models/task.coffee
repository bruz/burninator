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

  changeHours: (change, date) ->
    hours = @get('hours')
    date ||= Date.today().toString('M/d/yyyy')

    hours.push {date: date, hours: change}

    @trigger('change:hours')

  remainingHours: ->
    hours = @get('hours')

    @get('initialHours') + _.reduce hours, (memo, h) ->
      memo += h.hours
    , 0

  remainingHoursOn: (date) ->
    hours = @get('hours')

    @get('initialHours') + _.reduce hours, (memo, h) ->
      hoursDate = new Date(h.date)

      if hoursDate <= date
        memo += h.hours
      else
        memo
    , 0

  totalHours: ->
    hours = @get('hours')

    @get('initialHours') + _.reduce hours, (memo, h) ->
      if h > 0
        memo += h.hours
      else
        memo
    , 0

  totalHoursOn: (date) ->
    hours = @get('hours')

    @get('initialHours') + _.reduce hours, (memo, h) ->
      hoursDate = new Date(h.date)

      if h > 0 && hoursDate <= date
        memo += h.hours
      else
        memo
    , 0

  complete: ->
    @changeHours( -@remainingHours() )
