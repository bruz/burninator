View = require './view'
TasksView = require 'views/tasks_view'
template = require './templates/project_detail'

module.exports = class ProjectView extends View
  template: template

  initialize: ->
    @render()

    @tasksView = new TasksView
      el: @$('.tasks')
      tasks: @model.tasks

  getRenderData: ->
    {
      name: @model.get('name') 
    }
