Model = require './model'
Tasks = require 'collections/tasks'
Task = require 'models/task'

module.exports = class Project extends Model
  className: 'Project'

  @load: (id) ->
    dfd = $.Deferred()

    task = new @()

    projectQuery = new Parse.Query(Project)
    projectQuery.get id,
      success: (project) ->
        tasksQuery = new Parse.Query(Task)
        tasksQuery.equalTo('parent', project)
        #project.relation('tasks').query().find
        tasksQuery.find
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

  # COMPUTED ATTRIBUTES

  formStartDate: ->
    new Date(@get('startDate')).toString('M/d/yyyy')

  formEndDate: ->
    new Date(@get('endDate')).toString('M/d/yyyy')
