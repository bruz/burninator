View = require './view'
Project = require 'models/project'
template = require './templates/new_project'

module.exports = class NewProjectView extends View
  template: template

  initialize: (options) ->
    @callback = options.complete
    @projects = options.projects
    @project = new Project()

  afterRender: ->
    today = Date.today().toString('M/d/yyyy')
    @$('.data').attr('data-date', today)
    @$('.data input').val(today)
    @$('.date').datepicker()

    view = this
    @$('.modal').modal().on 'hide', (event) ->
      # datepicker also bubbles it's hide event to here
      return unless event.target == event.currentTarget

      view.callback(view.project.get('id'))
      $(view.el).remove()

  dispose: ->

  events:
    "click .create"  :  "create"

  create: (event) ->
    event.preventDefault()

    @$('.create').button('loading')

    view = this

    @project.save {
      name: view.$('.name').val()
      startDate: view.$('.start-date input').val()
      endDate: @$('.end-date input').val()
    }
    , {
      success: (project) ->
        view.projects.add(project)
        view.$('.modal').modal('hide')

      error: (project, error) ->
        console.log "FAIL: #{error}"
    }
