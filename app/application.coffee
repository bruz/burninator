# The application bootstrapper.
Application =
  initialize: ->
    ProjectsView = require 'views/projects_view'
    Router = require 'lib/router'

    @projectsView = new ProjectsView()
    @pageSetup()

    # Instantiate the router
    @router = new Router()
    # Freeze the object
    Object.freeze? this

  # jQuery setup for elements in index.html
  pageSetup: ->
    $('.date').datepicker()

module.exports = Application
