View = require './view'
HourChangeView = require './hour_change_view'
template = require './templates/task_detail'

module.exports = class TaskDetailView extends View
  template: template

  initialize: (options) ->
    _.bindAll @, 'addHourChange'

    @callback = options.complete
    @task = options.task

    $('body').append @render().el

  afterRender: ->
    @setupDatePickers()

    view = this
    _.each @model.get('hours'), (change) ->
      view.addHourChange(change)

    view = this
    @$('.modal').modal().on 'hide', (event) ->
      # datepicker also bubbles it's hide event to here
      return unless event.target == event.currentTarget

      $(view.el).remove()

  getRenderData: ->
    {
      name: @model.get('name') 
      totalHours: @model.totalHours()
      completedHours: @model.completedHours()
    }

  addHourChange: (change) ->
    @$('.change-list').append("<li>#{change.hours}</li>")
    #view = 

  events:
    "click .exit" : "exit"

  exit: (event) ->
    event.preventDefault()
    @$('.modal').modal('hide')
