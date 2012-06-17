View = require './view'
Task = require 'models/task'
Project = require 'models/project'
template = require './templates/new_task'

module.exports = class NewTaskView extends View
  template: template

  initialize: (options) ->
    @callback = options.complete
    @projectId = options.projectId
    @task = new Task()
    @task.setACL(new Parse.ACL(Parse.User.current()))

  afterRender: ->
    @setupDatePickers()

    view = this
    @$('.modal').modal().on 'hide', (event) ->
      # datepicker also bubbles it's hide event to here
      return unless event.target == event.currentTarget

      view.callback()
      $(view.el).remove()

  events:
    "click .create"  :  "create"

  create: (event) ->
    event.preventDefault()

    @$('.create').button('loading')

    view = this

    name = view.$('.name').val()
    date = view.$('.date-created input').val()
    hours = parseInt @$('.hours').val()

    project = new Project()
    project.id = @projectId
    @task.set('parent', project)

    @task.save {
      parent: project
      name: name
      date: date
      initialHours: hours
      hours: []
    }, {
      success: (task) ->
        view.$('.modal').modal('hide')
        view.callback()

      error: (task, error) ->
        console.log "FAIL: #{error}"
    }
