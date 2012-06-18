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

  # Change the remaining hours on a task, as of a specific date
  changeHours: (change, date) ->
    hours = @get('hours')
    date ||= Date.today().toString('M/d/yyyy')

    hours.push {date: date, hours: change}

    @trigger('change:hours')

  # Remaining hours on the task, including all hour changes regardless of
  # their date
  remainingHours: ->
    hours = @get('hours')

    @get('initialHours') + _.reduce hours, (memo, h) ->
      memo += h.hours
    , 0

  # Remaining hours on a particular date
  remainingHoursOn: (date) ->
    hours = @get('hours')

    @get('initialHours') + _.reduce hours, (memo, h) ->
      hoursDate = new Date(h.date)

      if hoursDate <= date
        memo += h.hours
      else
        memo
    , 0

  # Total hours added to the task, including the initial hours and any
  # subsequent hours added to the project.
  totalHours: ->
    hours = @get('hours')

    @get('initialHours') + _.reduce hours, (memo, h) ->
      if h > 0
        memo += h.hours
      else
        memo
    , 0

  # Same as totalHours but limited to hours on or before specified date
  totalHoursOn: (date) ->
    hours = @get('hours')

    @get('initialHours') + _.reduce hours, (memo, h) ->
      hoursDate = new Date(h.date)

      if h > 0 && hoursDate <= date
        memo += h.hours
      else
        memo
    , 0

  # Complete the task by reducing the hours to 0
  complete: ->
    @changeHours( -@remainingHours() )
