View = require './view'
TaskView = require './task_view'
template = require './templates/tasks'

module.exports = class TasksView extends View
  template: template

  initialize: (options) ->
    @tasks = options.tasks

    @tasks.on 'reset', @addAll, @
    @tasks.on 'add', @prependOne, @

    @render()
    @addAll()

  addAll: ->
    @tasks.each(@appendOne)

  appendOne: (task) ->
    view = new TaskView({model: task})
    @$('.task-list').append(view.render().el)

  prependOne: (task) ->
    view = new TaskView({model: task})
    @$('.task-list').prepend(view.render().el)

