View = require './view'
TasksView = require 'views/tasks_view'
template = require './templates/project_detail'

module.exports = class ProjectDetailView extends View
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
    @drawGraph()

  drawGraph: ->
    data = @model.graphData()

    Morris.Line
      element: 'burndown'
      data: data
      xkey: 'date'
      ykeys: ['estimatedHours', 'actualHours']
      labels: ['Esimated', 'Actual']
      lineColors: ['#167f39', '#044c29']
      lineWidth: 2
      smooth: false
      dateFormat: (date) ->
        new Date(date).toString("M/d/yyyy")

  events:
    "click .reset" : "resetForm"

  resetForm: ->
    @render()
