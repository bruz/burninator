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
    'signout'                : 'signout'
    'projects'               : 'projects'
    'projects/new'           : 'newProject'
    'projects/:id'           : 'project'
    'projects/:id/tasks/new' : 'newTask'

  home: ->
    @_clearPage()

  projects: ->
    @_clearPage()
    @_loadSidebar()

  signin: ->
    @_clearPage()

    if @_signedIn()
      @navigate('projects', {trigger: true})
    else
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
    @_clearPage()

    if @_signedIn()
      @navigate('projects', {trigger: true})
    else
      router = this

      view = new SignupView
        complete: (user) ->
          if user
            application.setUsername()
            router.navigate('projects', {trigger: true})
          else
            router.navigate('', {trigger: true})
            
      $('body').append view.render().el

  signout: ->
    Parse.User.logOut()
    @navigate('signin', {trigger: true})

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
    application.projectsView.update
      currentId: currentId

  _clearPage: ->
    # hide any other modals
    $('.modal').modal('hide')

    $('#project').html('')
    $('#projects').html('')

  _signedIn: ->
    Parse.User.current()
