# The application bootstrapper.
Application =
  initialize: ->
    ProjectsView = require 'views/projects_view'
    Projects = require 'collections/projects'
    Router = require 'lib/router'

    @projects = new Projects()
    @projectsView = new ProjectsView({projects: @projects})
    @setUsername()

    # Instantiate the router
    @router = new Router()
    # Freeze the object
    Object.freeze? this

  setUsername: ->
    user = Parse.User.current()
    
    if user
      $('#username').html('signed in as ' + user.get('username'))

module.exports = Application
