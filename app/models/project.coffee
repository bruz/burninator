Model = require './model'
Tasks = require 'collections/tasks'
Task = require 'models/task'

module.exports = class Project extends Model
  className: 'Project'

  # Load the project from Parse, along with all child tasks. Wrapping the
  # callbacks with a jQuery Deferred object to expose that cleaner API.
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

  # COMPUTED ATTRIBUTES

  startDate: ->
    new Date(@get('startDate'))

  endDate: ->
    new Date(@get('endDate'))

  # start date formatted for form field
  formStartDate: ->
    @startDate().toString('M/d/yyyy')

  # end date formatted for form field
  formEndDate: ->
    @endDate().toString('M/d/yyyy')

  # Total hours added to a project as of a particular date, essentially the sum
  # of total hours on that date for its tasks.
  totalHoursOn: (date) ->
    @tasks.reduce (memo, t) ->
      hours = t.totalHours()
      taskDate = new Date(t.get('date'))

      if isNaN(hours) || taskDate > date
        memo
      else
        memo += hours 
    , 0

  # Remaining hours to completion on a particular date, just the sum for its tasks
  remainingHoursOn: (date) ->
    @tasks.reduce (memo, t) ->
      taskDate = new Date(t.get('date'))

      if taskDate <= date
        memo += t.remainingHoursOn(date)
      else
        memo
    , 0

  # Data for the burndown graph. Generates an array of actual vs estimated
  # hours for each day during the sprint.
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
