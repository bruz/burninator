Model = require './model'
Tasks = require 'collections/tasks'

module.exports = class Project extends Model
  className: 'Project'

  @load: (id) ->
    dfd = $.Deferred()

    task = new @()

    query = new Parse.Query(Project)
    query.get id,
      success: (project) ->
        project.relation('tasks').query().find
          success: (data) ->
            project.tasks.reset(data)
            dfd.resolve(project)
          error: (object, error) ->
            dfd.reject()
      error: (object, error) ->
        dfd.reject()

    dfd

  initialize: ->
    @tasks = new Tasks()

  fetchTasks: ->

    model = this
