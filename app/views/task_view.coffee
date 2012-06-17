View = require './view'
TaskDetailView = require './task_detail_view'
TaskAddHoursView = require './task_add_hours_view'
TaskSubtractHoursView = require './task_subtract_hours_view'
template = require './templates/task'

module.exports = class TaskView extends View
  template: template
  tagName: 'tr'
  className: 'task'

  initialize: ->
    @model.on 'all', @render, @

  getRenderData: ->
    {
      name: @model.get('name')
      totalHours: @model.totalHours()
      completedHours: @model.completedHours()
      remainingHours: @model.remainingHours()
    }

  afterRender: ->
    view = this

  events:
    "click .add"      : "add"
    "click .subtract" : "subtract"
    "click .details"  : "details"
    "click .delete"   : "deleteTask"

  add: (event) ->
    event.preventDefault()

    new TaskAddHoursView
      model: @model

  subtract: (event) ->
    event.preventDefault()

    new TaskSubtractHoursView
      model: @model

  details: (event) ->
    event.preventDefault()
    
    new TaskDetailView
      model: @model

  deleteTask: (event) ->
    event.preventDefault()

    view = this
    @model.destroy
      success: ->
        $(view.el).remove()
