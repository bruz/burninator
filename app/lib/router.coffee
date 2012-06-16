application = require 'application'
NewProjectView = require 'views/new_project_view'
ProjectDetailView = require 'views/project_detail_view'
NewTaskView = require 'views/new_task_view'
SignupView = require 'views/signup_view'
SigninView = require 'views/signin_view'
Project = require 'models/project'

module.exports = class Router extends Backbone.Router
  routes:
    ''                       : 'signin'
    'signin'                 : 'signin'
    'signup'                 : 'signup'
    'projects'               : 'projects'
    'projects/new'           : 'newProject'
    'projects/:id'           : 'project'
    'projects/:id/tasks/new' : 'newTask'

  home: ->
    $('#project').html('')
    $('#projects').html('')

  projects: ->
    $('#project').html('')
    @_loadSidebar()

  signin: ->
    # hide any other modals
    $('.modal').modal('hide')

    router = this

    view = new SigninView
      complete: (user) ->
        if user
          application.setUsername()
          router.navigate('projects', {trigger: true})
        else
          router.navigate('', {trigger: true})
          
    $('body').append view.render().el

  signup: ->
    # hide any other modals
    $('.modal').modal('hide')

    router = this

    view = new SignupView
      complete: (user) ->
        if user
          application.setUsername()
          router.navigate('projects', {trigger: true})
        else
          router.navigate('', {trigger: true})
          
    $('body').append view.render().el

  newProject: ->
    @_loadSidebar()

    router = this
    view = new NewProjectView
      projects: application.projects
      complete: (projectId) ->
        router.navigate("projects/#{projectId}", {trigger: true})

    $('body').append view.render().el

  project: (id) ->
    @_loadSidebar(id)

    Project.load(id).done (project) ->
      view = new ProjectDetailView
        model: project
        el: $('#project')
        tab: 'tasks'
    .fail ->
      console.log "Failed to retrieve project"

  newTask: (id) ->
    @_loadSidebar(id)

    router = this
    view = new NewTaskView
      projectId: id
      complete: ->
        router.navigate("projects/#{id}", {trigger: true})

    $('body').append view.render().el

  _loadSidebar: (currentId) ->
    application.projectsView.currentId = currentId
    $('#projects').html application.projectsView.render().el
