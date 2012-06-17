View = require './view'
template = require './templates/task_subtract_hours'

module.exports = class TaskSubtractHoursView extends View
  template: template

  initialize: (options) ->
    @task = options.task

    $('body').append @render().el

  afterRender: ->
    @setupDatePickers()

    view = this
    @$('.modal').modal().on 'hide', (event) ->
      # datepicker also bubbles it's hide event to here
      return unless event.target == event.currentTarget

      $(view.el).remove()

  events:
    "click .save"  : "save"
    "click .exit"  : "exit"

  save: (event) ->
    event.preventDefault()

    change = parseInt(@$('.hours').val())
    date = @$('.date input').val()

    @model.changeHours(-change, date)
    @model.save()

    @$('.modal').modal('hide')

  exit: (event) ->
    event.preventDefault()
    @$('.modal').modal('hide')
