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
    view = this

    hours = _.sortBy @model.get('hours'), (change) ->
      change.date
      
    _.each hours, (change) ->
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
      remainingHours: @model.remainingHours()
    }

  addHourChange: (change) ->
    view = new HourChangeView({change: change})
    @$('.change-list').append(view.render().el)

  events:
    "click .exit" : "exit"

  exit: (event) ->
    event.preventDefault()
    @$('.modal').modal('hide')
