View = require './view'
TasksView = require 'views/tasks_view'
template = require './templates/project_detail'

module.exports = class ProjectView extends View
  template: template

  initialize: (options) ->
    @tab = options.tab

    @render()

    @tasksView = new TasksView
      el: @$('.tasks')
      tasks: @model.tasks
      project: @model

  getRenderData: ->
    {
      tab: @tab
      name: @model.get('name') 
      startDate: @model.formStartDate()
      endDate: @model.formEndDate()
    }

  afterRender: ->
    @$('.date').datepicker()

  events:
    "click .reset" : "resetForm"

  resetForm: ->
    @render()
