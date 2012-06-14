Model = require './model'
Tasks = require 'collections/tasks'
Task = require 'models/task'

module.exports = class Project extends Model
  className: 'Project'

  @load: (id) ->
    dfd = $.Deferred()

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

  startDate: ->
    new Date(@get('startDate'))

  endDate: ->
    new Date(@get('endDate'))

  formStartDate: ->
    @startDate.toString('M/d/yyyy')

  formEndDate: ->
    @endDate.toString('M/d/yyyy')

  totalHours: ->
    @tasks.reduce (memo, t) ->
      hours = parseInt(t.get('totalHours'))

      if isNaN(hours)
        memo
      else
        memo += hours 
    , 0

  remainingHoursOn: (date) ->
    @tasks.reduce (memo, t) ->
      memo += t.remainingHoursOn(date)
    , 0

  estimateData: ->
    [
      {date: @startDate(), hours: @totalHours()},
      {date: @endDate(), hours: 0}
    ]

  graphData: ->
    days = []

    today = Date.today()
    endDate = @endDate()
    date = @startDate()
    estimatedHours = @totalHours()

    numberOfDays = (endDate - date) / 86400000
    estimatedDelta = estimatedHours / numberOfDays 

    while date <= endDate
      if date > today
        actualHours = null
      else
        actualHours = @remainingHoursOn(date)

      days.push
        date: date.getTime()
        estimatedHours: estimatedHours
        actualHours: actualHours

      date.add(1).day()
      estimatedHours -= estimatedDelta

    days
