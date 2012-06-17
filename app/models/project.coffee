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
    @startDate().toString('M/d/yyyy')

  formEndDate: ->
    @endDate().toString('M/d/yyyy')

  totalHoursOn: (date) ->
    @tasks.reduce (memo, t) ->
      hours = t.totalHours()
      taskDate = new Date(t.get('date'))

      if isNaN(hours) || taskDate > date
        memo
      else
        memo += hours 
    , 0

  remainingHoursOn: (date) ->
    @tasks.reduce (memo, t) ->
      taskDate = new Date(t.get('date'))

      if taskDate <= date
        memo += t.remainingHoursOn(date)
      else
        memo
    , 0

  graphData: ->
    days = []

    # morris.js can't handle a graph with 0 for every
    # data point
    hasData = false

    today = Date.today()
    endDate = @endDate()
    date = @startDate()
    estimatedHours = @totalHoursOn(date)

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

      if estimatedHours > 0 || actualHours > 0
        hasData = true

      date.add(1).day()
      estimatedHours -= estimatedDelta

    if hasData
      return days
    else
      return null
